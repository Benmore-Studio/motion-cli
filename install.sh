#!/bin/sh
# Installer for the Motion CLI. Downloads the single `motion` script into a bin
# directory on your PATH and marks it executable. Usage:
#   curl -fsSL https://raw.githubusercontent.com/Benmore-Studio/motion-cli/main/install.sh | sh
set -e

REPO="https://raw.githubusercontent.com/Benmore-Studio/motion-cli/main/motion"
DEST="${MOTION_BIN:-/usr/local/bin/motion}"

if ! command -v python3 >/dev/null 2>&1; then
  echo "motion: Python 3.9+ is required but not found." >&2
  exit 1
fi

echo "Installing motion → $DEST"
if curl -fsSL "$REPO" -o "$DEST" 2>/dev/null && chmod +x "$DEST" 2>/dev/null; then
  :
else
  echo "Elevated permissions needed for $DEST — retrying with sudo…"
  sudo curl -fsSL "$REPO" -o "$DEST"
  sudo chmod +x "$DEST"
fi

echo "Done. Get started with:"
echo "  motion login"
