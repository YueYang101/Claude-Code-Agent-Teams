---
name: team-quick-backend
description: Small backend-only change with 4-agent pipeline
disable-model-invocation: true
argument-hint: <task description>
---
# Team: Quick Task (Backend)

Minimal backend team for small, well-understood changes. 4 agents with sequential dependencies.

## Task
$ARGUMENTS

## Workflow

Create a team with the following agents and task dependencies:

### 1. Coder (general-purpose agent — `.claude/agents/backend-coder.md`)
- **Task**: Implement the change directly. The task should be small and well-defined — no research phase needed. Follow conventions in `CLAUDE.md`.
- **Output**: Change implemented.
- **Blocked by**: nothing

### 2. Tester (general-purpose agent — `.claude/agents/tester.md`)
- **Task**: Run existing tests with `pytest`. If the change warrants a new test, write one. Ensure nothing is broken.
- **Output**: All tests passing.
- **Blocked by**: Coder

### 3. Documentor (general-purpose agent — `.claude/agents/documentor.md`)
- **Task**: Update `PROGRESS.md` with the completed work. Only update `ARCHITECTURE.md` if the change affected module structure.
- **Output**: Updated session memory.
- **Blocked by**: Tester

### 4. Logger (general-purpose agent — `.claude/agents/logger.md`)
- **Task**: Record this change in the daily dev log. Read the team's task list
  and completed work summary. Create `Log/<YYYY-MM>/` directory if it doesn't
  exist. Write or append to `Log/<YYYY-MM>/<YYYY-MM-DD>.md` using today's date.
  Follow the log entry template in the logger agent definition. If the file
  already exists, append under a `---` separator with a timestamp.
- **Output**: Daily log entry written/appended at `Log/<YYYY-MM>/<YYYY-MM-DD>.md`.
- **Blocked by**: Documentor
