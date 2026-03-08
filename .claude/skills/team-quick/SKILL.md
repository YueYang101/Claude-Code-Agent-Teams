---
name: team-quick
description: Choose between backend or fullstack quick task
argument-hint: <task description>
---
# Team: Quick Task — Selector

Choose the right variant for your quick task:

## Variants

| Command | Pipeline | Use When |
|---------|----------|----------|
| `/team-quick-backend` | coder → tester → documentor → logger | Small backend-only change |
| `/team-quick-fullstack` | [backend-coder + ui-coder] → tester → documentor → logger | Small change spanning both layers |

## Decision Rule

- If the change involves **UI, templates, styles, frontend components, or client-side code** → use `/team-quick-fullstack`
- If the change is purely **Python, CLI, data, or server-side** → use `/team-quick-backend`
- When in doubt → use `/team-quick-fullstack` (the coders will document "no changes needed" for unaffected layers)

## Usage

Invoke the appropriate variant directly:

```
/team-quick-backend rename Status.DONE to Status.COMPLETED
/team-quick-fullstack update the task card styling and its data model
```
