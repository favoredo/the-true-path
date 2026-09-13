#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VERSION="$(tr -d '[:space:]' < "$ROOT/.defold-version")"
TOOLS_DIR="$ROOT/.tools"
BOB="$TOOLS_DIR/bob-$VERSION.jar"

mkdir -p "$TOOLS_DIR"
if [[ ! -s "$BOB" ]]; then
  URL="https://github.com/defold/defold/releases/download/$VERSION/bob.jar"
  TEMP="$BOB.download"
  curl --fail --location --retry 3 --output "$TEMP" "$URL"
  mv "$TEMP" "$BOB"
fi

ln -sfn "$(basename "$BOB")" "$TOOLS_DIR/bob.jar"
printf '%s\n' "$BOB"
