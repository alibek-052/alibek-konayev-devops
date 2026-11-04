#!/usr/bin/env bash
# Konayev_Alibek_system.sh - prints student and system information
# Author: Alibek Konayev (IT2-2304)

# The script can be started from any directory:
# the project root is one level above the scripts/ folder.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
INFO_FILE="$PROJECT_DIR/Konayev_Alibek_info.txt"

LINE="=============================="

echo "$LINE"
echo "Student Information"
echo "$LINE"
echo
echo "Name: Alibek"
echo "Surname: Konayev"
echo "Group: IT2-2304"
echo "Student ID: 38386"
echo
echo "$LINE"
echo "System Information"
echo "$LINE"
echo
echo "Username: $(whoami)"
echo "Hostname: $(hostname 2>/dev/null || cat /etc/hostname)"
echo "Current Date: $(date '+%Y-%m-%d %H:%M:%S')"
if [ -r /etc/os-release ]; then
    . /etc/os-release
    echo "Operating System: ${PRETTY_NAME:-$(uname -s)} (kernel $(uname -r))"
else
    echo "Operating System: $(uname -sr)"
fi
echo "Disk Usage: $(df -h / | awk 'NR==2 {print $3 " used of " $2 " (" $5 ")"}')"
if command -v free >/dev/null 2>&1; then
    echo "Memory Usage: $(free -h | awk '/^Mem:/ {print $3 " used of " $2}')"
else
    echo "Memory Usage: n/a (free is not installed)"
fi
echo

if [ -f "$INFO_FILE" ]; then
    echo "Student information file exists."
else
    echo "Student information file does not exist."
fi
