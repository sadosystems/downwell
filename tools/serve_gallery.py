#!/usr/bin/env python3
"""
Launch the Downwell sprite-gallery server.

Convenience wrapper: locates sprite_gallery.py (in tools/ or the repo root),
starts it, and opens the packed-atlas view in your browser.

Usage:
    python3 serve_gallery.py [sprites_dir] [port]

Defaults come from sprite_gallery.py itself
(sprites_dir = ../decompiled_downwell/sprites, port = 8777).
Press Ctrl+C to stop the server.
"""
import os
import shutil
import subprocess
import sys
import time

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.dirname(HERE)


def find_gallery():
    for cand in (os.path.join(HERE, "sprite_gallery.py"),
                 os.path.join(REPO, "sprite_gallery.py")):
        if os.path.isfile(cand):
            return cand
    sys.exit("could not find sprite_gallery.py (looked in tools/ and the repo root)")


def open_browser(url):
    # From WSL, prefer the Windows browser; otherwise use the default handler.
    if shutil.which("powershell.exe"):
        try:
            subprocess.Popen(
                ["powershell.exe", "-NoProfile", "-Command", f"Start-Process '{url}'"],
                stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            return
        except Exception:
            pass
    try:
        import webbrowser
        webbrowser.open(url)
    except Exception:
        pass


def main():
    gallery = find_gallery()
    args = sys.argv[1:]
    port = args[1] if len(args) > 1 else "8777"
    url = f"http://localhost:{port}/"

    proc = subprocess.Popen([sys.executable, gallery, *args])
    time.sleep(1.5)                       # give the server a moment to bind
    open_browser(url)
    print(f"Sprite gallery running at {url}  (Ctrl+C to stop)")
    try:
        proc.wait()
    except KeyboardInterrupt:
        proc.terminate()


if __name__ == "__main__":
    main()
