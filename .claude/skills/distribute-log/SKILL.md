---
name: distribute-log
description: Record daily dev log from session activity
disable-model-invocation: true
argument-hint: [optional notes]
---
# Team: Daily Dev Log

Lightweight 2-agent team that records a daily dev log entry from session activity.

## Notes
$ARGUMENTS

## Workflow

### 1. Researcher (Explore agent — `.claude/agents/researcher.md`)
- **Task**: Gather today's work. Read `PROGRESS.md`, run
  `git log --oneline --since="midnight"`, and scan recently modified files.
  Compile: accomplishments, commits table, blockers/notes.
- **Output**: Structured summary of today's session activity.
- **Blocked by**: nothing

### 2. Logger (general-purpose agent — `.claude/agents/logger.md`)
- **Task**: Write/append daily log to `Log/<YYYY-MM>/<YYYY-MM-DD>.md`.
  Create directories if needed. Follow the log entry template in the logger
  agent definition. If file exists, append under `---` with timestamp.
- **Output**: Log file written at `Log/<YYYY-MM>/<YYYY-MM-DD>.md`.
- **Blocked by**: Researcher
