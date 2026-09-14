#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BOB="$($ROOT/scripts/fetch_bob.sh)"
OUTPUT="$ROOT/${DEFOLD_OUTPUT_DIR:-build/html5}"
STAGING="$ROOT/.bundle/html5"
if [[ -x /usr/local/opt/openjdk@25/bin/java ]]; then
  JAVA_BIN=/usr/local/opt/openjdk@25/bin/java
elif [[ -x /opt/homebrew/opt/openjdk@25/bin/java ]]; then
  JAVA_BIN=/opt/homebrew/opt/openjdk@25/bin/java
else
  JAVA_BIN=java
fi

mkdir -p "$STAGING"
find "$STAGING" -mindepth 1 -delete
cd "$ROOT"
EXTRA_SETTINGS=()
if [[ -n "${DEFOLD_SETTINGS_FILE:-}" ]]; then EXTRA_SETTINGS=(--settings "$DEFOLD_SETTINGS_FILE"); fi
"$JAVA_BIN" -jar "$BOB" --root . ${EXTRA_SETTINGS[@]+"${EXTRA_SETTINGS[@]}"} --platform wasm-web --variant "${DEFOLD_VARIANT:-release}" --archive --bundle-output "$STAGING" resolve build bundle

INDEX="$(find "$STAGING" -mindepth 1 -name index.html -print -quit)"
if [[ -z "$INDEX" ]]; then
  echo "HTML5 bundle is missing index.html" >&2
  exit 1
fi
APP_DIR="$(dirname "$INDEX")"
mkdir -p "$OUTPUT"
find "$OUTPUT" -mindepth 1 -delete
cp -R "$APP_DIR"/. "$OUTPUT"/
touch "$OUTPUT/.nojekyll"

find "$OUTPUT" -maxdepth 1 -name '*.wasm' -print -quit | grep -q .
find "$OUTPUT" \( -name '*.arcd' -o -name '*.arci' \) -print -quit | grep -q .
printf 'HTML5 bundle ready: %s\n' "$OUTPUT"
