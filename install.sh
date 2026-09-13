#!/usr/bin/env bash
set -euo pipefail

# Install the `petri` CLI to a directory on your PATH.
# Usage:  curl -sL https://raw.githubusercontent.com/rohanhariharan/petri/main/install.sh | bash
#
# Defaults to ~/bin, or /usr/local/bin if run with sudo.

URL="https://raw.githubusercontent.com/rohanhariharan/petri/main/petri"

if [ "$(id -u)" -eq 0 ] || [ -z "${HOME+x}" ]; then
  DEST="/usr/local/bin"
else
  DEST="${HOME}/bin"
fi

mkdir -p "$DEST"
curl -sL "$URL" -o "$DEST/petri"
chmod +x "$DEST/petri"

echo "Installed petri to $DEST/petri"
echo "Run 'petri --help' to get started."
