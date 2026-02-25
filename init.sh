#!/usr/bin/env bash
set -euo pipefail

# ─── agent-team-config bootstrap ─────────────────────────────────────────────
# Copies the reusable multi-agent team configuration into any project directory.
#
# Usage:
#   /path/to/agent-team-config/init.sh <target-dir>
#
# Idempotent — safe to run multiple times.
# ──────────────────────────────────────────────────────────────────────────────

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${1:-.}"

# Resolve to absolute path
TARGET="$(cd "$TARGET" && pwd)"

echo ""
echo "Bootstrapping agent-team-config into: $TARGET"
echo ""

# ── 1. Copy .claude/agents/ and .claude/skills/ (always overwrite) ───────────
mkdir -p "$TARGET/.claude"

# Copy agents
rm -rf "$TARGET/.claude/agents"
cp -r "$SCRIPT_DIR/.claude/agents" "$TARGET/.claude/agents"
echo "✓ Copied .claude/agents/ (8 agent personas)"

# Copy skills
rm -rf "$TARGET/.claude/skills"
cp -r "$SCRIPT_DIR/.claude/skills" "$TARGET/.claude/skills"
echo "✓ Copied .claude/skills/ (13 team skills)"

# ── 2. Copy settings.json only if target doesn't have one ───────────────────
if [ ! -f "$TARGET/.claude/settings.json" ]; then
    cp "$SCRIPT_DIR/.claude/settings.json" "$TARGET/.claude/settings.json"
    echo "✓ Created .claude/settings.json (agent teams enabled)"
else
    echo "· Skipped .claude/settings.json (already exists)"
fi

# ── 3. Create PROGRESS.md from template if it doesn't exist ─────────────────
if [ ! -f "$TARGET/PROGRESS.md" ]; then
    cp "$SCRIPT_DIR/templates/PROGRESS.md.template" "$TARGET/PROGRESS.md"
    echo "✓ Created PROGRESS.md (session memory)"
else
    echo "· Skipped PROGRESS.md (already exists)"
fi

# ── 4. Create ARCHITECTURE.md from template if it doesn't exist ─────────────
if [ ! -f "$TARGET/ARCHITECTURE.md" ]; then
    cp "$SCRIPT_DIR/templates/ARCHITECTURE.md.template" "$TARGET/ARCHITECTURE.md"
    echo "✓ Created ARCHITECTURE.md (module map)"
else
    echo "· Skipped ARCHITECTURE.md (already exists)"
fi

# ── 5. Handle CLAUDE.md ─────────────────────────────────────────────────────
MARKER_START="<!-- AGENT-TEAM-CONFIG-START -->"
MARKER_END="<!-- AGENT-TEAM-CONFIG-END -->"

if [ -f "$TARGET/CLAUDE.md" ]; then
    # Check if the agent team section already exists
    if grep -q "$MARKER_START" "$TARGET/CLAUDE.md"; then
        # Replace existing section
        # Create temp file with content before marker, new section, content after marker
        TMPFILE="$(mktemp)"
        sed -n "1,/^${MARKER_START}$/p" "$TARGET/CLAUDE.md" | head -n -1 > "$TMPFILE"
        cat "$SCRIPT_DIR/templates/CLAUDE.md.template" >> "$TMPFILE"
        sed -n "/^${MARKER_END}$/,\$p" "$TARGET/CLAUDE.md" | tail -n +2 >> "$TMPFILE"
        mv "$TMPFILE" "$TARGET/CLAUDE.md"
        echo "✓ Updated agent team section in CLAUDE.md"
    else
        # Append the agent team section
        echo "" >> "$TARGET/CLAUDE.md"
        cat "$SCRIPT_DIR/templates/CLAUDE.md.template" >> "$TARGET/CLAUDE.md"
        echo "✓ Appended agent team config to CLAUDE.md"
    fi
else
    # Create CLAUDE.md from template
    cat > "$TARGET/CLAUDE.md" <<'HEADER'
# Project Name

## Tech Stack

<!-- Fill in your project's tech stack here -->

## Coding Conventions

<!-- Fill in your project's coding conventions here -->

HEADER
    cat "$SCRIPT_DIR/templates/CLAUDE.md.template" >> "$TARGET/CLAUDE.md"
    echo "✓ Created CLAUDE.md (with agent team config)"
fi

echo ""
echo "Done! Available skills:"
echo "  /team                    — Manager picks optimal team"
echo "  /team-feature            — New feature (backend or fullstack)"
echo "  /team-feature-backend    — Backend feature pipeline + epilogue"
echo "  /team-feature-fullstack  — Fullstack feature pipeline + epilogue"
echo "  /team-bugfix             — Bug fix (backend or fullstack)"
echo "  /team-bugfix-backend     — Backend bugfix pipeline + epilogue"
echo "  /team-bugfix-fullstack   — Fullstack bugfix pipeline + epilogue"
echo "  /team-quick              — Quick task (backend or fullstack)"
echo "  /team-quick-backend      — Backend quick task + epilogue"
echo "  /team-quick-fullstack    — Fullstack quick task + epilogue"
echo "  /distribute-log          — Record daily dev log"
echo "  /git-cleanup             — Standalone commit cleanup & PR prep"
echo "  /update-docs             — Standalone documentation update"
echo ""
