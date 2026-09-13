#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PORT="${PORT:-8000}"

[[ -f "$ROOT/build/html5/index.html" ]] || "$ROOT/scripts/build_html5.sh"
cd "$ROOT/build/html5"
exec python3 -m http.server "$PORT" --bind 127.0.0.1
