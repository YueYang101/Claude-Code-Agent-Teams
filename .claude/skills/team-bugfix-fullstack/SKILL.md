---
name: team-bugfix-fullstack
description: Fullstack bug fix with parallel backend + UI coders
disable-model-invocation: true
argument-hint: <bug description>
---
# Team: Bug Fix (Fullstack)

Fullstack bug investigation and fix team with 6 agents. Backend Coder and UI Coder run in parallel after the Researcher (fork-join pattern).

## Bug Report
$ARGUMENTS

## Workflow

Create a team with the following agents and task dependencies:

```
                Researcher
                /        \
      Backend Coder    UI Coder     ← parallel
                \        /
                 Tester             ← waits for both
                    |
                Documentor
                    |
                  Logger
```

### 1. Researcher (Explore agent — `.claude/agents/researcher.md`)
- **Task**: Reproduce and investigate the bug across both backend and frontend layers. Read relevant source files and tests. Check browser console errors, network responses, and Python tracebacks. Identify the root cause, affected files, and blast radius. Tag the root cause as **frontend**, **backend**, or **integration**. Check `PROGRESS.md` for any related known issues. Use the bug report template at `bug-report-template.md` in this skill directory to structure your analysis.
- **Output**: Bug analysis with: reproduction steps, root cause (tagged by layer), affected files in both layers, and recommended fix strategy.
- **Blocked by**: nothing

### 2. Backend Coder (general-purpose agent — `.claude/agents/backend-coder.md`)
- **Task**: Implement the backend fix based on the researcher's analysis. Follow conventions in `CLAUDE.md`. Keep the change minimal — fix the bug without unrelated refactoring. If the bug is frontend-only (no backend changes needed), document "No backend changes needed — bug is frontend-only" and mark the task complete.
- **Output**: Minimal, focused backend fix applied (or documented as not needed).
- **Blocked by**: Researcher

### 3. UI Coder (general-purpose agent — `.claude/agents/ui-coder.md`)
- **Task**: Implement the frontend fix based on the researcher's analysis. Apply appropriate UI patterns and ensure accessibility is maintained. If the bug is backend-only (no frontend changes needed), document "No frontend changes needed — bug is backend-only" and mark the task complete.
- **Output**: Minimal, focused frontend fix applied (or documented as not needed).
- **Blocked by**: Researcher

### 4. Tester (general-purpose agent — `.claude/agents/tester.md`)
- **Task**: Write regression tests that reproduce the original bug and confirm the fix across both layers:
  - **Backend**: Regression test for any backend changes.
  - **Frontend/UI**: Regression test for any frontend changes.
  - **Integration**: If the bug was cross-layer, verify the fix works end-to-end.
  - Run `pytest` (and any frontend test runner) to ensure no regressions.
- **Output**: Regression tests added for affected layers, full suite passing.
- **Blocked by**: Backend Coder, UI Coder

### 5. Documentor (general-purpose agent — `.claude/agents/documentor.md`)
- **Task**: Update `PROGRESS.md` with the fix. If the bug revealed an architectural issue, note it in `ARCHITECTURE.md`. Include any new frontend directories if created.
- **Output**: Updated session memory.
- **Blocked by**: Tester

### 6. Logger (general-purpose agent — `.claude/agents/logger.md`)
- **Task**: Record this bugfix in the daily dev log. Read the team's task list
  and completed work summary. Create `Log/<YYYY-MM>/` directory if it doesn't
  exist. Write or append to `Log/<YYYY-MM>/<YYYY-MM-DD>.md` using today's date.
  Follow the log entry template in the logger agent definition (note which layers
  were affected). If the file already exists, append under a `---` separator with
  a timestamp.
- **Output**: Daily log entry written/appended at `Log/<YYYY-MM>/<YYYY-MM-DD>.md`.
- **Blocked by**: Documentor

## Reference Files
- `bug-report-template.md` — Template for the Researcher's bug analysis
