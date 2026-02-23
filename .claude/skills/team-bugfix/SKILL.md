---
name: team-bugfix
description: Choose between backend or fullstack bugfix workflow
disable-model-invocation: true
argument-hint: <bug description>
---
# Team: Bug Fix — Selector

Choose the right variant for your bug fix:

## Variants

| Command | Pipeline | Use When |
|---------|----------|----------|
| `/team-bugfix-backend` | researcher → coder → tester → documentor → logger | Bug is in backend code only |
| `/team-bugfix-fullstack` | researcher → [backend-coder + ui-coder] → tester → documentor → logger | Bug may span backend and frontend/UI |

## Decision Rule

- If the bug involves **UI rendering, layout, styling, browser behavior, frontend interaction, or client-side errors** → use `/team-bugfix-fullstack`
- If the bug is purely in **Python logic, CLI, data handling, or server-side code** → use `/team-bugfix-backend`
- When in doubt → use `/team-bugfix-fullstack` (the coders will document "no changes needed" for unaffected layers)

## Usage

Invoke the appropriate variant directly:

```
/team-bugfix-backend task complete crashes when ID doesn't exist
/team-bugfix-fullstack dashboard fails to render tasks with special characters
```
