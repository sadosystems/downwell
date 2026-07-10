#!/usr/bin/env python3
"""
Compose the "trio" animation frames: Welltaro's run cycle, a spinning gem and
the air-bubble animation, side by side on a black background. Nothing moves —
each sprite just plays its own cycle in place.

Frame count = LCM of the three cycle lengths (8, 4, 16 -> 16), so the whole
sequence loops seamlessly: each output frame N draws cycle frame N % len for
every sprite.

Usage:
    python3 tools/trio_frames.py [outdir]

Writes trio_0.png .. trio_15.png (default outdir: downwiki/assets).
"""
import math
import os
import sys

from PIL import Image

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.dirname(HERE)
SPRITES = os.path.join(REPO, "decompiled_downwell", "sprites")

BLACK = (5, 5, 5, 255)  # Downwell's colorD

# name, folder, anchor x (centre), baseline y (feet/bottom of art)
CANVAS_W, CANVAS_H = 56, 32
CAST = [
    ("run", "sprPlayerRunExg", 14, 23),   # the full-sprint cycle
    ("gem", "sprGemM", 31, 22),
    ("bubble", "sprBubbleSmall", 45, 21), # the little bubble
]


def load_cycle(folder):
    d = os.path.join(SPRITES, folder)
    files = sorted(
        (f for f in os.listdir(d) if f.endswith(".png")),
        key=lambda f: int(f.rsplit("_", 1)[1].split(".")[0]),
    )
    return [Image.open(os.path.join(d, f)).convert("RGBA") for f in files]


def main():
    outdir = sys.argv[1] if len(sys.argv) > 1 else os.path.join(REPO, "downwiki", "assets")
    os.makedirs(outdir, exist_ok=True)

    cycles = {name: load_cycle(folder) for name, folder, _, _ in CAST}
    total = math.lcm(*(len(c) for c in cycles.values()))
    print(f"cycle lengths: { {n: len(c) for n, c in cycles.items()} } -> {total} frames")

    for n in range(total):
        frame = Image.new("RGBA", (CANVAS_W, CANVAS_H), BLACK)
        for name, _, cx, baseline in CAST:
            cycle = cycles[name]
            im = cycle[n % len(cycle)]
            # anchor by the art's own bbox: centred on cx, art bottom on baseline
            l, t, r, b = im.getbbox()
            x = cx - (l + r) // 2
            y = baseline - b
            frame.paste(im, (x, y), im)
        path = os.path.join(outdir, f"trio_{n}.png")
        frame.save(path)
    print(f"wrote {total} frames to {outdir}")


if __name__ == "__main__":
    main()
