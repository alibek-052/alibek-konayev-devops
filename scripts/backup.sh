#!/usr/bin/env bash
# Creates a compressed backup of config/ and logs/ inside backup/
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
mkdir -p "$PROJECT_DIR/backup"

ARCHIVE="$PROJECT_DIR/backup/backup_$(date +%Y%m%d_%H%M%S).tar.gz"
tar -czf "$ARCHIVE" -C "$PROJECT_DIR" config logs
echo "Backup created: $ARCHIVE"
