#!/usr/bin/env bash
# Build the browser frontend and stage it next to index.html.
# Run, then serve:  python3 -m http.server -d web/www 8000
set -euo pipefail
cd "$(dirname "$0")/.."
cargo build -p web --release --target wasm32-unknown-unknown
wasm-bindgen target/wasm32-unknown-unknown/release/web.wasm \
  --target web --out-dir web/www --out-name web
cp assets/atlas.png web/www/atlas.png
if command -v wasm-opt >/dev/null 2>&1; then
  cp web/www/web_bg.wasm web/www/web_bg.wasm.pre-opt
  wasm-opt -Oz --enable-bulk-memory --enable-sign-ext \
    --enable-nontrapping-float-to-int --enable-reference-types \
    web/www/web_bg.wasm -o web/www/web_bg.wasm.opt
  # Binaryen can reduce raw bytes while making the HTTP-compressed payload
  # larger. Optimize for what users actually download.
  before=$(gzip -9 -c web/www/web_bg.wasm.pre-opt | wc -c)
  after=$(gzip -9 -c web/www/web_bg.wasm.opt | wc -c)
  if (( after < before )); then
    mv web/www/web_bg.wasm.opt web/www/web_bg.wasm
  else
    mv web/www/web_bg.wasm.pre-opt web/www/web_bg.wasm
    rm web/www/web_bg.wasm.opt
  fi
  rm -f web/www/web_bg.wasm.pre-opt
else
  echo "web: warning: wasm-opt not found; skipping Binaryen size pass" >&2
fi
echo "web: built web/www/ ($(du -h web/www/web_bg.wasm | cut -f1) wasm)"
