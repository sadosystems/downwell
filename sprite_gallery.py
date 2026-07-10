#!/usr/bin/env python3
"""
Texture-atlas view of the decompiled Downwell sprites.

Bin-packs every PNG (at its native pixel size) into a single atlas and scales
the whole atlas to fit one screen, so all sprites are visible at once. Hover a
sprite to see its path; click it to copy the path to the clipboard.

Usage:
    python3 sprite_gallery.py [sprites_dir] [port]

Defaults:
    sprites_dir = ./decompiled_downwell/sprites (relative to this file)
    port        = 8777

Then open http://localhost:<port>/ in a browser (works from Windows too,
since WSL2 forwards localhost).
"""
import os
import sys
import html
import struct
import subprocess
import posixpath
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
from functools import partial

HERE = os.path.dirname(os.path.abspath(__file__))
DEFAULT_SPRITES = os.path.join(HERE, "decompiled_downwell", "sprites")

SPRITES = os.path.abspath(sys.argv[1]) if len(sys.argv) > 1 else DEFAULT_SPRITES
PORT = int(sys.argv[2]) if len(sys.argv) > 2 else 8777
PAD = 1  # px gap between packed sprites

if not os.path.isdir(SPRITES):
    sys.exit(f"sprites dir not found: {SPRITES}")

try:
    WIN_BASE = subprocess.check_output(["wslpath", "-w", SPRITES]).decode().strip()
except Exception:
    WIN_BASE = SPRITES.replace("/", "\\")


def png_size(path):
    """Read (w, h) from a PNG's IHDR without decoding the image."""
    try:
        with open(path, "rb") as fh:
            head = fh.read(24)
        if head[:8] != b"\x89PNG\r\n\x1a\n":
            return None
        return struct.unpack(">II", head[16:24])
    except Exception:
        return None


def win_path(rel_dir, fname):
    parts = [] if rel_dir == "." else rel_dir.split(os.sep)
    return "\\".join([WIN_BASE, *parts, fname])


def wsl_path(rel_dir, fname):
    d = SPRITES if rel_dir == "." else os.path.join(SPRITES, rel_dir)
    return os.path.join(d, fname)


def collect():
    items = []
    for root, dirs, files in os.walk(SPRITES):
        dirs.sort()
        rel = os.path.relpath(root, SPRITES)
        for f in sorted(files):
            if not f.lower().endswith(".png"):
                continue
            size = png_size(os.path.join(root, f))
            if not size:
                continue
            w, h = size
            url = f if rel == "." else posixpath.join(rel.replace(os.sep, "/"), f)
            items.append({
                "url": "/" + url, "w": w, "h": h,
                "wsl": wsl_path(rel, f), "win": win_path(rel, f),
                "name": (f if rel == "." else rel + "/" + f),
            })
    return items


def pack(items):
    """Shelf packer: sort by height desc, wrap rows into a ~16:9 atlas."""
    items.sort(key=lambda d: (d["h"], d["w"]), reverse=True)
    area = sum((it["w"] + PAD) * (it["h"] + PAD) for it in items)
    max_w = max((it["w"] for it in items), default=1)
    width = max(max_w, int((area * 16 / 9) ** 0.5))
    x = y = row_h = 0
    for it in items:
        if x + it["w"] + PAD > width:
            x = 0
            y += row_h + PAD
            row_h = 0
        it["x"], it["y"] = x, y
        x += it["w"] + PAD
        row_h = max(row_h, it["h"] + PAD)
    return width, y + row_h


def build_atlas():
    items = collect()
    aw, ah = pack(items)
    parts = []
    for it in items:
        wsl = html.escape(it["wsl"], quote=True)
        win = html.escape(it["win"], quote=True)
        parts.append(
            f'<img class="s" loading="lazy" src="{html.escape(it["url"], quote=True)}" '
            f'style="left:{it["x"]}px;top:{it["y"]}px;'
            f'width:{it["w"]}px;height:{it["h"]}px" '
            f'data-wsl="{wsl}" data-win="{win}" title="{html.escape(it["name"])}">'
        )
    return "\n".join(parts), aw, ah, len(items)


PAGE = r"""<!doctype html>
<html lang="en"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Downwell sprite atlas (__COUNT__)</title>
<style>
  :root { color-scheme: dark; }
  * { box-sizing: border-box; }
  html, body { margin: 0; height: 100%; overflow: hidden;
    background: #0d0f13; color: #e6e6e6;
    font: 12px/1.4 system-ui, sans-serif; }
  #stage { position: fixed; inset: 0; }
  #atlas { position: absolute; transform-origin: top left;
    image-rendering: pixelated;
    background-image:
      linear-gradient(45deg,#181b21 25%,transparent 25%),
      linear-gradient(-45deg,#181b21 25%,transparent 25%),
      linear-gradient(45deg,transparent 75%,#181b21 75%),
      linear-gradient(-45deg,transparent 75%,#181b21 75%);
    background-size: 16px 16px;
    background-position: 0 0, 0 8px, 8px -8px, -8px 0; }
  img.s { position: absolute; image-rendering: pixelated; cursor: pointer;
    transition: opacity .1s; }
  img.s:hover { outline: 2px solid #3b82f6; outline-offset: 0;
    box-shadow: 0 0 0 9999px rgba(0,0,0,.35); z-index: 9; }
  img.dim { opacity: .08; }
  #bar { position: fixed; top: 10px; left: 50%; transform: translateX(-50%);
    display: flex; gap: 8px; align-items: center; z-index: 20;
    background: rgba(20,23,29,.92); border: 1px solid #2a2f38;
    border-radius: 8px; padding: 6px 8px; backdrop-filter: blur(4px); }
  #bar .sub { color: #8b93a1; padding: 0 4px; }
  #filter { background: #0f1115; color: #e6e6e6; border: 1px solid #2a2f38;
    border-radius: 6px; padding: 5px 9px; width: 200px; }
  .toggle { display: flex; border: 1px solid #2a2f38; border-radius: 6px;
    overflow: hidden; }
  .toggle button { background: #0f1115; color: #cbd2dc; border: 0;
    padding: 5px 10px; cursor: pointer; font: inherit; }
  .toggle button.on { background: #3b82f6; color: #fff; }
  #hud { position: fixed; bottom: 0; left: 0; right: 0; z-index: 20;
    background: rgba(15,17,21,.92); border-top: 1px solid #2a2f38;
    padding: 6px 12px; display: flex; gap: 12px; align-items: center;
    backdrop-filter: blur(4px); }
  #path { flex: 1; color: #9aa4b2; font-family: ui-monospace, monospace;
    white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
  #toast { color: #22c55e; opacity: 0; transition: opacity .15s; font-weight: 600; }
  #toast.show { opacity: 1; }
</style></head>
<body>
<div id="bar">
  <span class="sub">__COUNT__ sprites</span>
  <input id="filter" placeholder="filter by name...">
  <div class="toggle">
    <button data-mode="win" class="on">Windows path</button>
    <button data-mode="wsl">WSL path</button>
  </div>
</div>
<div id="stage"><div id="atlas" style="width:__AW__px;height:__AH__px">__BODY__</div></div>
<div id="hud">
  <span>hover = path &middot; click = copy</span>
  <span id="path">&nbsp;</span>
  <span id="toast">copied!</span>
</div>
<script>
  const AW = __AW__, AH = __AH__;
  const atlas = document.getElementById("atlas");
  const stage = document.getElementById("stage");
  const pathEl = document.getElementById("path");
  const toast = document.getElementById("toast");
  let mode = "win";

  function fit(){
    const vw = stage.clientWidth, vh = stage.clientHeight;
    const s = Math.min(vw / AW, vh / AH);
    atlas.style.transform = "scale(" + s + ")";
    atlas.style.left = Math.max(0, (vw - AW * s) / 2) + "px";
    atlas.style.top  = Math.max(0, (vh - AH * s) / 2) + "px";
  }
  addEventListener("resize", fit); fit();

  document.querySelectorAll(".toggle button").forEach(b => {
    b.onclick = () => { mode = b.dataset.mode;
      document.querySelectorAll(".toggle button")
        .forEach(x => x.classList.toggle("on", x === b)); };
  });

  async function copy(text){
    try { await navigator.clipboard.writeText(text); return true; }
    catch(e){
      const ta = document.createElement("textarea");
      ta.value = text; ta.style.position = "fixed"; ta.style.opacity = "0";
      document.body.appendChild(ta); ta.select();
      let ok = false; try { ok = document.execCommand("copy"); } catch(_){}
      ta.remove(); return ok;
    }
  }

  atlas.addEventListener("mouseover", e => {
    if (e.target.classList.contains("s")) pathEl.textContent = e.target.dataset[mode];
  });
  let tt;
  atlas.addEventListener("click", async e => {
    if (!e.target.classList.contains("s")) return;
    const p = e.target.dataset[mode];
    const ok = await copy(p);
    pathEl.textContent = p;
    if (ok){ toast.classList.add("show"); clearTimeout(tt);
      tt = setTimeout(() => toast.classList.remove("show"), 900); }
  });

  const imgs = Array.from(atlas.querySelectorAll("img.s"));
  document.getElementById("filter").oninput = e => {
    const q = e.target.value.trim().toLowerCase();
    imgs.forEach(im => im.classList.toggle("dim",
      q && !im.title.toLowerCase().includes(q)));
  };
</script>
</body></html>"""


class Handler(SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path in ("/", "/index.html"):
            body, aw, ah, count = build_atlas()
            page = (PAGE.replace("__BODY__", body)
                        .replace("__AW__", str(aw))
                        .replace("__AH__", str(ah))
                        .replace("__COUNT__", str(count)))
            data = page.encode("utf-8")
            self.send_response(200)
            self.send_header("Content-Type", "text/html; charset=utf-8")
            self.send_header("Content-Length", str(len(data)))
            self.end_headers()
            self.wfile.write(data)
        else:
            super().do_GET()

    def log_message(self, *a):
        pass


if __name__ == "__main__":
    _, aw, ah, count = build_atlas()
    handler = partial(Handler, directory=SPRITES)
    srv = ThreadingHTTPServer(("0.0.0.0", PORT), handler)
    print(f"Packed {count} sprites into a {aw}x{ah} atlas")
    print(f"Open  http://localhost:{PORT}/")
    srv.serve_forever()
