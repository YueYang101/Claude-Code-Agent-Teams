---
name: team-feature-backend
description: Backend-only feature with 6-agent sequential pipeline
disable-model-invocation: true
argument-hint: <feature description>
---
# Team: Feature Implementation (Backend)

Full end-to-end backend feature team with 6 agents and sequential dependencies.

## Feature Request
$ARGUMENTS

## Workflow

Create a team with the following agents and task dependencies:

### 1. Researcher (Explore agent — `.claude/agents/researcher.md`)
- **Task**: Investigate the codebase to understand where the feature fits. Read `ARCHITECTURE.md` for module boundaries. Identify relevant files, interfaces, and potential conflicts.
- **Output**: A research summary with: relevant files, existing patterns to follow, risks, and recommended approach.
- **Blocked by**: nothing

### 2. Architect (Plan agent)
- **Task**: Based on the researcher's findings, design the implementation plan. Define which files to create/modify, public interfaces, and data flow. Update `ARCHITECTURE.md` if new modules are introduced.
- **Output**: A step-by-step implementation plan with file list, interface signatures, and test strategy.
- **Blocked by**: Researcher

### 3. Coder (general-purpose agent — `.claude/agents/backend-coder.md`)
- **Task**: Implement the feature following the architect's plan. Write clean code that follows conventions in `CLAUDE.md`. Create or modify only the files specified in the plan.
- **Output**: Working implementation with all planned files created/modified.
- **Blocked by**: Architect

### 4. Tester (general-purpose agent — `.claude/agents/tester.md`)
- **Task**: Write and run tests for the new feature. Tests should cover happy paths, edge cases, and integration with existing code. Run `pytest` and ensure all tests pass.
- **Output**: Test files created, all tests passing.
- **Blocked by**: Coder

### 5. Documentor (general-purpose agent — `.claude/agents/documentor.md`)
- **Task**: Update `PROGRESS.md` with completed work. Add docstrings if missing. Update `ARCHITECTURE.md` if the module map changed. Ensure the feature is discoverable.
- **Output**: Updated session memory and documentation.
- **Blocked by**: Tester

### 6. Logger (general-purpose agent — `.claude/agents/logger.md`)
- **Task**: Record this feature work in the daily dev log. Read the team's task
  list and completed work summary. Create `Log/<YYYY-MM>/` directory if it doesn't
  exist. Write or append to `Log/<YYYY-MM>/<YYYY-MM-DD>.md` using today's date.
  Follow the log entry template in the logger agent definition. If the file
  already exists (other work was logged today), append under a `---` separator
  with a timestamp.
- **Output**: Daily log entry written/appended at `Log/<YYYY-MM>/<YYYY-MM-DD>.md`.
- **Blocked by**: Documentor
