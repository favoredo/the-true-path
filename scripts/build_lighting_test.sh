#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEFOLD_VARIANT=debug DEFOLD_SETTINGS_FILE=test/lighting.settings DEFOLD_OUTPUT_DIR=build/html5/lighting "$ROOT/scripts/build_html5.sh"
