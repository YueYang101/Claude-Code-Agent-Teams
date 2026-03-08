---
name: team-quick-backend
description: Small backend-only change with core pipeline + optional epilogue
argument-hint: <task description>
---
# Team: Quick Task (Backend)

Minimal backend team for small, well-understood changes. After the core phase completes and results are reported, optional epilogue agents run in the background.

## Task
$ARGUMENTS

## Workflow

Create a team with the following agents and task dependencies:

```
CORE PHASE (blocking):
  Coder → Tester

EPILOGUE PHASE (background, optional, parallel):
  Tester → [Documentor + Logger + Git Manager]
```

---

### Core Phase

### 1. Coder (general-purpose agent — `.claude/agents/backend-coder.md`)
- **Task**: Implement the change directly. The task should be small and well-defined — no research phase needed. Follow conventions in `CLAUDE.md`.
- **Output**: Change implemented.
- **Blocked by**: nothing

### 2. Tester (general-purpose agent — `.claude/agents/tester.md`)
- **Task**: Run existing tests with `pytest`. If the change warrants a new test, write one. Ensure nothing is broken.
- **Output**: All tests passing.
- **Blocked by**: Coder

---

**After the Tester completes, report the result to the user.** The core deliverable is done. Then evaluate the epilogue.

---

### Epilogue Phase (background, optional)

Evaluate each agent's gating criteria. Spawn those that pass **in parallel, in the background** (`run_in_background: true`). All are blocked only by Tester (not by each other). Epilogue failure does not fail the pipeline.

### 3. Documentor (general-purpose agent — `.claude/agents/documentor.md`) — *optional*
- **Gate**: Run if code structure changed (new files, modified interfaces). Skip for trivial config changes or renames.
- **Task**: Update `PROGRESS.md` with the completed work. Only update `ARCHITECTURE.md` if the change affected module structure.
- **Output**: Updated session memory.
- **Blocked by**: Tester

### 4. Logger (general-purpose agent — `.claude/agents/logger.md`) — *optional*
- **Gate**: Run if meaningful work was done (commits exist, tasks were completed). Skip if no commits were made or user said "skip logging".
- **Task**: Record this change in the daily dev log. Read the team's task list
  and completed work summary. Create `Log/<YYYY-MM>/` directory if it doesn't
  exist. Write or append to `Log/<YYYY-MM>/<YYYY-MM-DD>.md` using today's date.
  Follow the log entry template in the logger agent definition. If the file
  already exists, append under a `---` separator with a timestamp.
- **Output**: Daily log entry written/appended at `Log/<YYYY-MM>/<YYYY-MM-DD>.md`.
- **Blocked by**: Tester

### 5. Git Manager (general-purpose agent — `.claude/agents/git-manager.md`) — *optional*
- **Gate**: Run if >2 commits, or WIP/fixup commit messages exist, or work is on main/master. Skip for single clean commit or if user manages git themselves.
- **Task**: Clean up commit history — squash fixups, rewrite messages to conventional format. Ensure work is on a feature branch (not main/master). Optionally prepare a PR description.
- **Output**: Clean commit history on feature branch, PR description ready.
- **Blocked by**: Tester
