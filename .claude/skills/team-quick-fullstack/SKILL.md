---
name: team-quick-fullstack
description: Small fullstack change with parallel backend + UI coders
disable-model-invocation: true
argument-hint: <task description>
---
# Team: Quick Task (Fullstack)

Minimal fullstack team for small, well-understood changes. 5 agents. Backend Coder and UI Coder run in parallel (fork-join pattern).

## Task
$ARGUMENTS

## Workflow

Create a team with the following agents and task dependencies:

```
      Backend Coder    UI Coder     ← parallel (no blockers)
                \        /
                 Tester             ← waits for both
                    |
                Documentor
                    |
                  Logger
```

### 1. Backend Coder (general-purpose agent — `.claude/agents/backend-coder.md`)
- **Task**: Implement the backend change directly. The task should be small and well-defined — no research phase needed. Follow conventions in `CLAUDE.md`.
- **Output**: Backend change implemented.
- **Blocked by**: nothing

### 2. UI Coder (general-purpose agent — `.claude/agents/ui-coder.md`)
- **Task**: Implement the frontend change directly. The task should be small and well-defined — no research phase needed. Follow UI best practices and maintain accessibility.
- **Output**: Frontend change implemented.
- **Blocked by**: nothing

### 3. Tester (general-purpose agent — `.claude/agents/tester.md`)
- **Task**: Run existing tests with `pytest` (and any frontend test runner). If the changes warrant new tests, write them for both layers. Ensure nothing is broken.
- **Output**: All tests passing across both layers.
- **Blocked by**: Backend Coder, UI Coder

### 4. Documentor (general-purpose agent — `.claude/agents/documentor.md`)
- **Task**: Update `PROGRESS.md` with the completed work. Only update `ARCHITECTURE.md` if the change affected module structure (including any new frontend directories).
- **Output**: Updated session memory.
- **Blocked by**: Tester

### 5. Logger (general-purpose agent — `.claude/agents/logger.md`)
- **Task**: Record this change in the daily dev log. Read the team's task list
  and completed work summary. Create `Log/<YYYY-MM>/` directory if it doesn't
  exist. Write or append to `Log/<YYYY-MM>/<YYYY-MM-DD>.md` using today's date.
  Follow the log entry template in the logger agent definition (note both backend
  and frontend work). If the file already exists, append under a `---` separator
  with a timestamp.
- **Output**: Daily log entry written/appended at `Log/<YYYY-MM>/<YYYY-MM-DD>.md`.
- **Blocked by**: Documentor
