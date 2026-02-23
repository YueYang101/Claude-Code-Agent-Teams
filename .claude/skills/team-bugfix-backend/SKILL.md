---
name: team-bugfix-backend
description: Backend-only bug fix with 5-agent sequential pipeline
disable-model-invocation: true
argument-hint: <bug description>
---
# Team: Bug Fix (Backend)

Backend bug investigation and fix team with 5 agents and sequential dependencies.

## Bug Report
$ARGUMENTS

## Workflow

Create a team with the following agents and task dependencies:

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

### 4. Documentor (general-purpose agent — `.claude/agents/documentor.md`)
- **Task**: Update `PROGRESS.md` with the fix. If the bug revealed an architectural issue, note it in `ARCHITECTURE.md`.
- **Output**: Updated session memory.
- **Blocked by**: Tester

### 5. Logger (general-purpose agent — `.claude/agents/logger.md`)
- **Task**: Record this bugfix in the daily dev log. Read the team's task list
  and completed work summary. Create `Log/<YYYY-MM>/` directory if it doesn't
  exist. Write or append to `Log/<YYYY-MM>/<YYYY-MM-DD>.md` using today's date.
  Follow the log entry template in the logger agent definition. If the file
  already exists, append under a `---` separator with a timestamp.
- **Output**: Daily log entry written/appended at `Log/<YYYY-MM>/<YYYY-MM-DD>.md`.
- **Blocked by**: Documentor
