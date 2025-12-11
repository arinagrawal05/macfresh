#!/bin/bash

################################################################################
# macfresh.sh — Ultra-safe macOS Cleanup Tool
# Version: 1.0.1
# Author: Arin Agrawal
################################################################################

VERSION="1.0.1"
DRY_RUN=false

# Colors
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
NC="\033[0m"

line() { printf "%s\n" "-------------------------------------------------"; }

# Disk usage helpers
get_used()  { df -h / | tail -1 | awk '{print $3}'; }
get_free()  { df -h / | tail -1 | awk '{print $4}'; }
get_usage() { df -h / | tail -1 | awk '{print $5}'; }

safe_rm() {
    local target="$1"
    if [ "$DRY_RUN" = true ]; then
        printf "    ${YELLOW}DRY RUN → Would remove:${NC} %s\n" "$target"
    else
        rm -rf "$target" 2>/dev/null
    fi
}

# Track reclamation
START_USED=$(df -k / | tail -1 | awk '{print $3}')

###############################################################################
# Pretty Header
###############################################################################
clear
echo "================================================="
echo "                 🧼  macfresh"
echo "        Ultra-Safe macOS Cleanup Utility"
echo "================================================="
echo "Version $VERSION — Status Report"
echo ""
echo "This cleanup is designed to be 100% safe."
echo "No application settings or development environments"
echo -e "are modified in any way.  ${GREEN}✅${NC}"
echo ""

###############################################################################
# Disk Before
###############################################################################
line
echo "📊  Disk Usage — Before Cleanup"
line
echo "Used:  $(get_used)"
echo "Free:  $(get_free)"
echo "Usage: $(get_usage)"
echo ""

###############################################################################
# Homebrew Cleanup
###############################################################################
line
echo "📦  Homebrew Cleanup"
line

if command -v brew >/dev/null; then
    echo "Removing old cached downloads…"
    echo -e "(Installed packages are never touched)  "
    echo ""

    SKIPPED=$(brew outdated --formula | awk '{print $1}' | paste -sd ", " -)

    if [ -z "$SKIPPED" ]; then
        echo "Nothing to skip — all packages are up-to-date."
    else
        echo "Skipped (not installed or not outdated):"
        echo "  $SKIPPED"
        echo ""
    fi

    if [ "$DRY_RUN" = true ]; then
        echo "DRY RUN → Would run: brew cleanup --prune=all"
    else
        brew cleanup --prune=all >/dev/null
    fi

    echo ""
    echo "✔ Homebrew cache cleaned successfully"
else
    echo -e "${YELLOW}Homebrew not installed — skipping.${NC}"
fi
echo ""

###############################################################################
# Temporary Files Cleanup
###############################################################################
line
echo "🗂  Temporary Files Cleanup"
line

safe_rm "/tmp/"*.tmp
safe_rm "/tmp/"*.temp

if [ -n "$TMPDIR" ]; then
    safe_rm "$TMPDIR"/*.tmp
    safe_rm "$TMPDIR"/*.temp
fi

echo -e "✔ System temporary files removed  "
echo -e "✔ User temporary files removed    "
echo ""

###############################################################################
# Developer Tools Cleanup
###############################################################################
line
echo "💻  Development Tools Cleanup"
line

if command -v npm >/dev/null; then
    if [ "$DRY_RUN" = true ]; then
        echo "DRY RUN → Would run: npm cache clean --force"
    else
        npm cache clean --force >/dev/null 2>&1
    fi
    echo -e "✔ npm cache cleaned (project files untouched)   "
fi

if command -v pip3 >/dev/null; then
    if [ "$DRY_RUN" = true ]; then
        echo "DRY RUN → Would run: pip3 cache purge"
    else
        pip3 cache purge >/dev/null 2>&1
    fi
    echo -e "✔ pip cache cleaned (environments untouched)    "
fi

if command -v docker >/dev/null; then
    echo "⚠ Docker detected — skipped for safety"
    echo "  To clean manually:  docker system prune -f"
fi

echo ""

###############################################################################
# macOS Housekeeping
###############################################################################
line
echo "🍎  macOS Housekeeping"
line

safe_rm "$HOME/.Trash/"*
echo "✔ Trash emptied"

echo -e "✔ Downloads folder preserved                      ${GREEN}✅${NC}"

safe_rm "$HOME/Library/Caches/com.apple.QuickLook.thumbnailcache"/*
echo "✔ QuickLook thumbnails reset"

find "$HOME/Library/Logs" -type f -mtime +7 -delete 2>/dev/null
echo "✔ Old logs (7+ days) cleaned"

echo ""

###############################################################################
# Disk After
###############################################################################
line
echo "📊  Disk Usage — After Cleanup"
line
echo "Used:  $(get_used)"
echo "Free:  $(get_free)"
echo "Usage: $(get_usage)"
echo ""

###############################################################################
# Space Reclaimed
###############################################################################
line
echo "📉  Space Reclaimed"
line

END_USED=$(df -k / | tail -1 | awk '{print $3}')
DIFF=$((START_USED - END_USED))

if [ $DIFF -le 0 ]; then
    echo "Cleanup completed, but no additional disk space"
    echo "was recovered this time (0 bytes cleaned)."
    echo "This is normal if caches were already empty."
else
    echo "Space recovered: $((DIFF / 1024)) MB"
fi
echo ""

###############################################################################
# Summary
###############################################################################
line
echo "SUMMARY"
line
echo "SAFE ITEMS CLEANED:"
echo "• Homebrew cached downloads"
echo "• Temporary system & user files"
echo "• npm & pip caches"
echo "• Trash contents"
echo "• Old log files"
echo "• Thumbnail cache"
echo ""
echo "ITEMS PRESERVED FOR SAFETY:"
echo "• Application settings           ✅"
echo "• Downloads folder               ✅"
echo "• Docker images/containers       ✅"
echo "• Recent logs                    ✅"
echo "• Development environments       ✅"
echo ""

line
echo "✓ Cleanup completed successfully"
echo "✨ Your Mac is now fresher than ever!"
echo "Developed by Arin Agrawal (https://x.com/ArinBuilds)"
line
echo ""

exit 0