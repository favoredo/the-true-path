#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BOB="$($ROOT/scripts/fetch_bob.sh)"
OUTPUT="$ROOT/.bundle/test-bundle"
LOG="$ROOT/build/headless-test.log"
if [[ -x /usr/local/opt/openjdk@25/bin/java ]]; then
  JAVA_BIN=/usr/local/opt/openjdk@25/bin/java
elif [[ -x /opt/homebrew/opt/openjdk@25/bin/java ]]; then
  JAVA_BIN=/opt/homebrew/opt/openjdk@25/bin/java
else
  JAVA_BIN=java
fi
case "$(uname -s)-$(uname -m)" in
  Darwin-x86_64) PLATFORM=x86_64-macos ;;
  Darwin-arm64) PLATFORM=arm64-macos ;;
  Linux-x86_64) PLATFORM=x86_64-linux ;;
  *) echo "Unsupported headless test host: $(uname -s)-$(uname -m)" >&2; exit 1 ;;
esac

mkdir -p "$ROOT/build" "$OUTPUT"
find "$OUTPUT" -mindepth 1 -delete
cd "$ROOT"
"$JAVA_BIN" -jar "$BOB" --root . --settings test/test.settings --platform "$PLATFORM" --variant headless --archive --bundle-output "$OUTPUT" resolve build bundle

EXECUTABLE="$(find "$OUTPUT" -type f -perm -100 ! -name '*.so' -print -quit)"
if [[ -z "$EXECUTABLE" ]]; then
  echo "Headless bundle executable was not found" >&2
  exit 1
fi

set +e
if command -v timeout >/dev/null 2>&1; then
  timeout 20 "$EXECUTABLE" 2>&1 | tee "$LOG"
  STATUS=${PIPESTATUS[0]}
else
  "$EXECUTABLE" 2>&1 | tee "$LOG"
  STATUS=${PIPESTATUS[0]}
fi
set -e

[[ $STATUS -eq 0 ]]
grep -F 'TEST {"event":"suite_end","status":"pass"' "$LOG"
