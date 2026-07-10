#!/usr/bin/env bash
# Build the browser frontend and stage it next to index.html.
# Run, then serve:  python3 -m http.server -d web/www 8000
set -euo pipefail
cd "$(dirname "$0")/.."
cargo build -p web --release --target wasm32-unknown-unknown
cp target/wasm32-unknown-unknown/release/web.wasm web/www/web.wasm
echo "web: built web/www/ ($(du -h web/www/web.wasm | cut -f1) wasm)"
