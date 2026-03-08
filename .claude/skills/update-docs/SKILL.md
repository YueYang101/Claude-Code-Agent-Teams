---
name: update-docs
description: Update PROGRESS.md, ARCHITECTURE.md, and add docstrings
argument-hint: [optional scope or description of recent changes]
---
# Standalone: Update Documentation

Invoke the documentor agent to update session memory and architecture docs based on recent work.

## Context
$ARGUMENTS

## Workflow

Spawn a single **documentor** agent (general-purpose — `.claude/agents/documentor.md`) with the following task:

### Documentor
- **Task**: Review recent changes and update documentation:
  1. Read `PROGRESS.md` and `ARCHITECTURE.md` before editing.
  2. Check `git log --oneline -10` and `git diff --stat HEAD~5` to understand recent work.
  3. Update `PROGRESS.md` with completed work items and current status.
  4. Update `ARCHITECTURE.md` if module structure changed (new files, directories, interfaces).
  5. Add Google-style docstrings to any public functions missing them.
- **Context from user**: $ARGUMENTS (may describe what was recently done or which area to focus on)
- **Output**: Updated PROGRESS.md, ARCHITECTURE.md (if needed), docstrings added (if needed).
