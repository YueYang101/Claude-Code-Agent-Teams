---
name: team-bugfix-backend
description: Backend-only bug fix with sequential core pipeline + optional epilogue
argument-hint: <bug description>
---
# Team: Bug Fix (Backend)

Backend bug investigation and fix team with sequential core pipeline. After the core phase completes and results are reported, optional epilogue agents run in the background.

## Bug Report
$ARGUMENTS

## Workflow

Create a team with the following agents and task dependencies:

```
CORE PHASE (blocking):
  Researcher → Coder → Tester

EPILOGUE PHASE (background, optional, parallel):
  Tester → [Documentor + Logger + Git Manager]
```

---

### Core Phase

### 1. Researcher (Explore agent — `.claude/agents/researcher.md`)
- **Task**: Reproduce and investigate the bug. Read relevant source files and tests. Identify the root cause, affected files, and blast radius. Check `PROGRESS.md` for any related known issues.
- **Output**: Bug analysis with: reproduction steps, root cause, affected files, and recommended fix strategy.
- **Blocked by**: nothing

### 2. Coder (general-purpose agent — `.claude/agents/backend-coder.md`)
- **Task**: Implement the fix based on the researcher's analysis. Follow conventions in `CLAUDE.md`. Keep the change minimal — fix the bug without unrelated refactoring.
- **Output**: Minimal, focused fix applied to the identified files.
- **Blocked by**: Researcher

### 3. Tester (general-purpose agent — `.claude/agents/tester.md`)
- **Task**: Write a regression test that reproduces the original bug and confirms the fix. Run the full test suite with `pytest` to ensure no regressions.
- **Output**: Regression test added, full suite passing.
- **Blocked by**: Coder

---

**After the Tester completes, report the result to the user.** The core deliverable is done. Then evaluate the epilogue.

---

### Epilogue Phase (background, optional)

Evaluate each agent's gating criteria. Spawn those that pass **in parallel, in the background** (`run_in_background: true`). All are blocked only by Tester (not by each other). Epilogue failure does not fail the pipeline.

### 4. Documentor (general-purpose agent — `.claude/agents/documentor.md`) — *optional*
- **Gate**: Run if the bug fix changed code structure or revealed an architectural issue. Skip for trivial one-line fixes.
- **Task**: Update `PROGRESS.md` with the fix. If the bug revealed an architectural issue, note it in `ARCHITECTURE.md`.
- **Output**: Updated session memory.
- **Blocked by**: Tester

### 5. Logger (general-purpose agent — `.claude/agents/logger.md`) — *optional*
- **Gate**: Run if meaningful work was done (commits exist, tasks were completed). Skip if no commits were made or user said "skip logging".
- **Task**: Record this bugfix in the daily dev log. Read the team's task list
  and completed work summary. Create `Log/<YYYY-MM>/` directory if it doesn't
  exist. Write or append to `Log/<YYYY-MM>/<YYYY-MM-DD>.md` using today's date.
  Follow the log entry template in the logger agent definition. If the file
  already exists, append under a `---` separator with a timestamp.
- **Output**: Daily log entry written/appended at `Log/<YYYY-MM>/<YYYY-MM-DD>.md`.
- **Blocked by**: Tester

### 6. Git Manager (general-purpose agent — `.claude/agents/git-manager.md`) — *optional*
- **Gate**: Run if >2 commits, or WIP/fixup commit messages exist, or work is on main/master. Skip for single clean commit or if user manages git themselves.
- **Task**: Clean up commit history — squash fixups, rewrite messages to conventional format. Ensure work is on a feature branch (not main/master). Optionally prepare a PR description.
- **Output**: Clean commit history on feature branch, PR description ready.
- **Blocked by**: Tester
