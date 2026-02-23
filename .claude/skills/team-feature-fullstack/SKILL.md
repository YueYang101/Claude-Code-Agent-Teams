---
name: team-feature-fullstack
description: Fullstack feature with parallel backend + UI coders
disable-model-invocation: true
argument-hint: <feature description>
---
# Team: Feature Implementation (Fullstack)

Full end-to-end fullstack feature team with 7 agents. Backend Coder and UI Coder run in parallel after the Architect (fork-join pattern).

## Feature Request
$ARGUMENTS

## Workflow

Create a team with the following agents and task dependencies:

```
                Researcher
                    |
                Architect
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
- **Task**: Investigate the codebase to understand where the feature fits. Read `ARCHITECTURE.md` for module boundaries. Identify relevant files, interfaces, and potential conflicts.
  - **Backend**: Identify relevant Python modules, existing patterns, data models, and risks.
  - **Frontend/UI**: Research UI/UX patterns from popular tools (Todoist, Linear, Trello, etc.) for similar features. Identify common UI patterns for the interaction type (lists, forms, modals, filters, etc.). Note accessibility considerations (keyboard navigation, screen reader support, contrast). Recommend frontend framework/approach if none exists in the project.
- **Output**: A research summary with two sections:
  1. **Backend**: relevant files, existing patterns to follow, risks, recommended approach.
  2. **Frontend/UI**: UI patterns from reference apps, accessibility notes, tech recommendation.
- **Blocked by**: nothing

### 2. Architect (Plan agent)
- **Task**: Based on the researcher's findings, design a unified implementation plan covering both backend and frontend. The plan must include an integration contract (use the template at `integration-contract-template.md` in this skill directory) that enables the two coders to work independently in parallel.
- **Output**: A plan with three sections:
  1. **Backend plan**: Python files to create/modify, public interfaces, data flow.
  2. **Frontend plan**: UI files to create/modify, component hierarchy, layout design.
  3. **Integration contract**: Exact interface between frontend and backend — function signatures, API routes, data shapes, request/response formats.
- **Blocked by**: Researcher

### 3. Backend Coder (general-purpose agent — `.claude/agents/backend-coder.md`)
- **Task**: Implement the backend following the architect's backend plan. Write clean code that follows conventions in `CLAUDE.md`. Ensure all interfaces match the integration contract exactly so the UI Coder can connect without coordination.
- **Output**: Working backend implementation with all planned files created/modified. Interfaces match the integration contract.
- **Blocked by**: Architect

### 4. UI Coder (general-purpose agent — `.claude/agents/ui-coder.md`)
- **Task**: Implement the frontend following the architect's frontend plan. Apply the researcher's UI pattern recommendations. Follow the integration contract to connect to the backend. Handle responsive design and basic accessibility (keyboard navigation, semantic HTML, ARIA labels where appropriate).
- **Output**: Working frontend implementation with all planned UI files created/modified. Connects to backend via the integration contract.
- **Blocked by**: Architect

### 5. Tester (general-purpose agent — `.claude/agents/tester.md`)
- **Task**: Write and run tests for both layers and their integration:
  - **Backend**: Unit tests covering happy paths, edge cases, and integration with existing code.
  - **Frontend/UI**: Test client requests, rendered content assertions, or JS tests depending on the tech stack.
  - **Integration**: Verify frontend correctly calls backend end-to-end via the integration contract.
  - Run `pytest` (and any frontend test runner) and ensure all tests pass.
- **Output**: Test files created for both layers, all tests passing.
- **Blocked by**: Backend Coder, UI Coder

### 6. Documentor (general-purpose agent — `.claude/agents/documentor.md`)
- **Task**: Update `PROGRESS.md` with completed work. Add docstrings if missing. Update `ARCHITECTURE.md` if the module map changed — include any new frontend directories and components. Ensure the feature is discoverable.
- **Output**: Updated session memory and documentation (including frontend directories in ARCHITECTURE.md).
- **Blocked by**: Tester

### 7. Logger (general-purpose agent — `.claude/agents/logger.md`)
- **Task**: Record this feature work in the daily dev log. Read the team's task
  list and completed work summary. Create `Log/<YYYY-MM>/` directory if it doesn't
  exist. Write or append to `Log/<YYYY-MM>/<YYYY-MM-DD>.md` using today's date.
  Follow the log entry template in the logger agent definition (note both backend
  and frontend work). If the file already exists (other work was logged today),
  append under a `---` separator with a timestamp.
- **Output**: Daily log entry written/appended at `Log/<YYYY-MM>/<YYYY-MM-DD>.md`.
- **Blocked by**: Documentor

## Reference Files
- `integration-contract-template.md` — Template for the Architect's integration contract
- `example-feature-output.md` — Example of a completed pipeline output
