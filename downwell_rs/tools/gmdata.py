#!/usr/bin/env python3
"""Minimal data.win (GameMaker 2022.3) parser for the Downwell port.

Extracts what the decompile lacks: asset index order (sprite/room/object ids),
sprite origins, texture page rects, room contents (layers/tiles/instances).
Format reference: UndertaleModTool serialization.

Usage:
  gmdata.py chunks            list FORM chunks
  gmdata.py rooms             list rooms with asset indices
  gmdata.py sprites [name..]  dump sprite entries (origin, frames, tpag)
  gmdata.py objects           list objects (name, sprite, depth, parent)
  gmdata.py room N            dump room N (views, layers, instances, tiles)
"""
import struct, sys, os

DATA = os.path.expanduser('~/downwell-linux/assets/game.unx')

class R:
    def __init__(self, buf, pos=0):
        self.b = buf
        self.p = pos
    def u8(self):  v = self.b[self.p]; self.p += 1; return v
    def u16(self): v = struct.unpack_from('<H', self.b, self.p)[0]; self.p += 2; return v
    def i16(self): v = struct.unpack_from('<h', self.b, self.p)[0]; self.p += 2; return v
    def u32(self): v = struct.unpack_from('<I', self.b, self.p)[0]; self.p += 4; return v
    def i32(self): v = struct.unpack_from('<i', self.b, self.p)[0]; self.p += 4; return v
    def f32(self): v = struct.unpack_from('<f', self.b, self.p)[0]; self.p += 4; return v
    def ptrlist(self):
        n = self.u32()
        return [self.u32() for _ in range(n)]

buf = open(DATA, 'rb').read()

def chunk_table():
    assert buf[:4] == b'FORM'
    chunks = {}
    p = 8
    while p < len(buf):
        name = buf[p:p+4].decode()
        size = struct.unpack_from('<I', buf, p+4)[0]
        chunks[name] = (p+8, size)
        p += 8 + size
    return chunks

CH = chunk_table()

def string_at(ptr):
    # string references point at the utf8 data; length is 4 bytes before
    if ptr == 0:
        return None
    ln = struct.unpack_from('<I', buf, ptr-4)[0]
    return buf[ptr:ptr+ln].decode('utf-8', 'replace')

def asset_names(chunk):
    off, size = CH[chunk]
    r = R(buf, off)
    return [string_at(struct.unpack_from('<I', buf, p)[0]) for p in r.ptrlist()]

def cmd_chunks():
    for name, (off, size) in CH.items():
        print(f'{name}  off={off:#x} size={size}')

def cmd_rooms():
    off, _ = CH['ROOM']
    r = R(buf, off)
    for i, p in enumerate(r.ptrlist()):
        print(i, string_at(struct.unpack_from('<I', buf, p)[0]))

def sprite_entry(p):
    r = R(buf, p)
    s = {}
    s['name'] = string_at(r.u32())
    s['w'] = r.i32(); s['h'] = r.i32()
    s['ml'] = r.i32(); s['mr'] = r.i32(); s['mb'] = r.i32(); s['mt'] = r.i32()
    s['transparent'] = r.i32(); s['smooth'] = r.i32(); s['preload'] = r.i32()
    s['bbox_mode'] = r.i32(); s['sep_masks'] = r.i32()
    s['ox'] = r.i32(); s['oy'] = r.i32()
    marker = r.i32()
    if marker == -1:
        # GMS2 "special" sprite
        s['version'] = r.i32()
        s['stype'] = r.i32()
        s['playback_speed'] = r.f32()
        s['playback_type'] = r.i32()
        if s['version'] >= 2:
            s['sequence_ptr'] = r.u32()
        if s['version'] >= 3:
            s['nineslice_ptr'] = r.u32()
        s['frames'] = r.ptrlist()
    else:
        # old format: marker was the frame count's first word — rewind
        r.p -= 4
        s['frames'] = r.ptrlist()
    return s

def tpag_entry(p):
    r = R(buf, p)
    k = ['src_x','src_y','src_w','src_h','tx','ty','tw','th','bw','bh','page']
    return dict(zip(k, [r.u16() for _ in range(11)]))

def cmd_sprites(names):
    off, _ = CH['SPRT']
    r = R(buf, off)
    ptrs = r.ptrlist()
    for i, p in enumerate(ptrs):
        s = sprite_entry(p)
        if names and s['name'] not in names:
            continue
        print(i, s['name'], f"{s['w']}x{s['h']} origin=({s['ox']},{s['oy']})",
              'frames=%d' % len(s['frames']))
        for fp in s['frames']:
            print('   tpag', tpag_entry(fp))

def cmd_objects():
    off, _ = CH['OBJT']
    r = R(buf, off)
    for i, p in enumerate(r.ptrlist()):
        rr = R(buf, p)
        name = string_at(rr.u32())
        spr = rr.i32()
        visible = rr.i32()
        # 2022.5+: managed flag; 2022.3 may not have it — print raw next words
        w = [rr.i32() for _ in range(6)]
        print(i, name, 'sprite=', spr, 'visible=', visible, 'next=', w)

def cmd_room(idx):
    off, _ = CH['ROOM']
    r = R(buf, off)
    ptrs = r.ptrlist()
    p = ptrs[idx]
    rr = R(buf, p)
    name = string_at(rr.u32())
    caption = string_at(rr.u32())
    w = rr.u32(); h = rr.u32(); speed = rr.u32(); persistent = rr.i32()
    argb = rr.u32(); draw_bg = rr.i32(); ccid = rr.i32(); flags = rr.u32()
    bgs = rr.u32(); views = rr.u32(); objs = rr.u32(); tiles = rr.u32()
    print(f'room {idx} {name!r} {w}x{h} speed={speed} flags={flags:#x}')
    print(f'  ptrs: bgs={bgs:#x} views={views:#x} insts={objs:#x} tiles={tiles:#x}')
    # trailing: world, bounds, gravity, mpp, then GMS2 layers ptr
    rest = [rr.u32() for _ in range(8)]
    layers_ptr = rr.u32()
    print('  rest:', rest, 'layers_ptr=%#x' % layers_ptr)
    # views
    vr = R(buf, views)
    for vp in vr.ptrlist():
        v = R(buf, vp)
        en = v.i32()
        vals = [v.i32() for _ in range(15)]
        print('  view enabled=%d' % en, vals)
    # instances
    ir = R(buf, objs)
    ilist = ir.ptrlist()
    print('  instances:', len(ilist))
    objnames = asset_names('OBJT')
    for ip in ilist[:400]:
        i = R(buf, ip)
        x = i.i32(); y = i.i32(); oid = i.i32(); iid = i.i32(); cc = i.i32()
        sx = i.f32(); sy = i.f32(); col = i.u32(); rot = i.f32()
        nm = objnames[oid] if 0 <= oid < len(objnames) else '?'
        print(f'    ({x},{y}) {nm} id={iid} cc={cc} scale=({sx},{sy}) col={col:#x} rot={rot}')
    # layers
    lr = R(buf, layers_ptr)
    for lp in lr.ptrlist():
        l = R(buf, lp)
        lname = string_at(l.u32())
        lid = l.u32(); ltype = l.u32(); depth = l.i32()
        xoff = l.f32(); yoff = l.f32(); hs = l.f32(); vs = l.f32(); vis = l.u32()
        print(f'  layer {lname!r} id={lid} type={ltype} depth={depth} off=({xoff},{yoff}) vis={vis}')
        if ltype == 4:  # assets layer (legacy tiles live here)
            legacy = l.ptrlist()
            print(f'    legacy tiles: {len(legacy)}')
        elif ltype == 2:  # instances layer
            n = l.u32()
            ids = [l.u32() for _ in range(n)]
            print(f'    instance ids: {ids[:20]}{"..." if n>20 else ""}')

if __name__ == '__main__':
    cmd = sys.argv[1] if len(sys.argv) > 1 else 'chunks'
    if cmd == 'chunks': cmd_chunks()
    elif cmd == 'rooms': cmd_rooms()
    elif cmd == 'sprites': cmd_sprites(set(sys.argv[2:]))
    elif cmd == 'objects': cmd_objects()
    elif cmd == 'room': cmd_room(int(sys.argv[2]))

# ---- module API for pack_assets.py ----
def sprites_table():
    """[{idx, name, w, h, ox, oy, nframes}] for all sprites."""
    off, _ = CH['SPRT']
    r = R(buf, off)
    out = []
    for i, p in enumerate(r.ptrlist()):
        s = sprite_entry(p)
        out.append(dict(idx=i, name=s['name'], w=s['w'], h=s['h'],
                        ox=s['ox'], oy=s['oy'], nframes=len(s['frames'])))
    return out

def room_instances(idx):
    """[(x, y, objname)] in creation order for room idx."""
    off, _ = CH['ROOM']
    r = R(buf, off)
    p = r.ptrlist()[idx]
    rr = R(buf, p)
    for _ in range(12):
        rr.u32()
    objs = rr.u32()
    ir = R(buf, objs)
    objnames = asset_names('OBJT')
    out = []
    for ip in ir.ptrlist():
        i = R(buf, ip)
        x = i.i32(); y = i.i32(); oid = i.i32()
        out.append((x, y, objnames[oid]))
    return out
