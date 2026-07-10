#!/usr/bin/env python3
"""
Generate a Downwell-style dither-dissolve fade for an input image.

Produces 10 frames (0-9):
  frame 0        : empty (fully transparent)
  frames 1..7    : the image dithering in
  frames 8 and 9 : the complete image (last two frames identical & full)

The reveal order is a 4x4 Bayer ordered-dither pattern plus a gentle vertical
gradient so the bottom fills first and the top last -- i.e. played forwards it
fills bottom->top, played in reverse the top disappears first (matching
Downwell's sprTitleFade).

Every revealed pixel is written at FULL alpha (255); pixels not yet revealed are
fully transparent. No partial alpha, no intermediate colours -- the dither only
ever adds full-alpha pixels.

Usage:
    python3 dither_fade.py INPUT [-o OUTDIR] [-k VERTICAL] [--alpha-thresh N]
                                 [--direction bottom|top|none]
"""
import argparse
import glob
import os
import re
import sys
import numpy as np
from PIL import Image

# Standard 4x4 Bayer ordered-dither matrix.
BAYER4 = np.array([[0, 8, 2, 10],
                   [12, 4, 14, 6],
                   [3, 11, 1, 9],
                   [15, 7, 13, 5]], dtype=float)

# Cumulative fraction of the shape revealed by the END of each frame.
# Measured from Downwell's sprTitleFade: an S-curve whose last two frames are
# both the complete image.
SCHEDULE = [0.0, 0.021, 0.056, 0.099, 0.248, 0.508, 0.744, 0.901, 1.0, 1.0]


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("input", help="input image (PNG with alpha recommended)")
    ap.add_argument("-o", "--out",
                    help="output dir (default: <stem>_fade next to the input)")
    ap.add_argument("-k", "--vertical", type=float, default=0.3,
                    help="vertical-gradient strength vs the dither "
                         "(0 = pure dither; default 0.3)")
    ap.add_argument("--alpha-thresh", type=int, default=128,
                    help="input alpha >= this counts as part of the shape "
                         "(1-255, default 128)")
    ap.add_argument("--direction", choices=["bottom", "top", "none"],
                    default="bottom",
                    help="which edge fills first (default bottom, matching Downwell)")
    ap.add_argument("--match", metavar="REFDIR",
                    help="replay the EXACT per-frame reveal masks from a reference "
                         "frame sequence (e.g. the original sprTitleFade folder) "
                         "instead of computing a Bayer dither. Produces output that "
                         "is bit-for-bit identical (on the opaque pixel set) to the "
                         "reference, painting the input's pixels through those masks.")
    args = ap.parse_args()

    img = Image.open(args.input).convert("RGBA")
    arr = np.asarray(img)
    H, W = arr.shape[:2]
    rgb = arr[..., :3]
    alpha = arr[..., 3]

    shape = alpha >= args.alpha_thresh
    n = int(shape.sum())
    if n == 0:
        sys.exit("no pixels above --alpha-thresh; nothing to reveal")

    stem = os.path.splitext(os.path.basename(args.input))[0]
    outdir = args.out or os.path.join(
        os.path.dirname(os.path.abspath(args.input)), f"{stem}_fade")
    os.makedirs(outdir, exist_ok=True)

    # ---- match mode: replay exact reveal masks from a reference sequence ----
    if args.match:
        def frame_index(p):
            m = re.search(r"_(\d+)\.png$", os.path.basename(p))
            return int(m.group(1)) if m else -1
        refs = sorted((p for p in glob.glob(os.path.join(args.match, "*.png"))
                       if frame_index(p) >= 0), key=frame_index)
        if not refs:
            sys.exit(f"no <name>_<n>.png frames found in {args.match}")
        counts = []
        for f, rp in enumerate(refs):
            ref = np.asarray(Image.open(rp).convert("RGBA"))
            if ref.shape[:2] != (H, W):
                sys.exit(f"reference {rp} is {ref.shape[1]}x{ref.shape[0]}, "
                         f"input is {W}x{H} -- dimensions must match")
            # "on" = a pixel that is actually visible: opaque AND not pure black.
            # Downwell's fade paints a transient black leading edge that is
            # invisible on the game's black background, so those pixels must NOT
            # be reproduced as visible (full-alpha) pixels -- only the pixels you
            # can actually see are replayed.
            mask = (ref[..., 3] > 0) & (ref[..., :3].max(axis=2) > 0)
            ys, xs = np.where(mask)
            out = np.zeros((H, W, 4), dtype=np.uint8)
            col = rgb[ys, xs].copy()
            missing = alpha[ys, xs] < args.alpha_thresh  # on in ref but not in input
            col[missing] = 255                           # paint white (full alpha)
            out[ys, xs, :3] = col
            out[ys, xs, 3] = 255                         # full alpha only
            Image.fromarray(out, "RGBA").save(
                os.path.join(outdir, f"{stem}_{f}.png"))
            counts.append(int(mask.sum()))
        print(f"wrote {len(refs)} frames to {outdir} (match mode)")
        print("opaque per frame:", counts)
        return

    ys, xs = np.where(shape)

    # Per-pixel Bayer threshold, normalised to (0,1).
    bayer = (BAYER4[ys % 4, xs % 4] + 0.5) / 16.0

    # Vertical gradient across the shape's bounding box.
    y0, y1 = ys.min(), ys.max()
    span = max(1, y1 - y0)
    ny = (ys - y0) / span                       # 0 at top, 1 at bottom
    if args.direction == "bottom":
        vgrad = 1.0 - ny                        # top has higher threshold -> later
    elif args.direction == "top":
        vgrad = ny
    else:
        vgrad = np.zeros_like(ny)

    key = bayer + args.vertical * vgrad         # combined reveal key
    order = np.argsort(key, kind="stable")      # ascending -> revealed first

    counts = []
    for f, frac in enumerate(SCHEDULE):
        k = int(round(frac * n))
        sel = order[:k]
        out = np.zeros((H, W, 4), dtype=np.uint8)
        sy, sx = ys[sel], xs[sel]
        out[sy, sx, :3] = rgb[sy, sx]
        out[sy, sx, 3] = 255                    # full alpha only
        Image.fromarray(out, "RGBA").save(os.path.join(outdir, f"{stem}_{f}.png"))
        counts.append(k)

    print(f"wrote 10 frames to {outdir}")
    print(f"shape pixels: {n}")
    print("revealed per frame:", counts)


if __name__ == "__main__":
    main()
