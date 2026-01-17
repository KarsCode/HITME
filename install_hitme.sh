#!/usr/bin/env bash

set -e

INSTALL_PATH="/usr/local/bin/hitme"

echo "📦 Installing hitme..."

curl -s https://raw.githubusercontent.com/KarsCode/hitme/main/hitme.sh -o /tmp/hitme
chmod +x /tmp/hitme

sudo mv /tmp/hitme "$INSTALL_PATH"

echo "✅ Installed!"
echo "👉 Run: hitme"
