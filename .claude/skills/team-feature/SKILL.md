---
name: team-feature
description: Choose between backend or fullstack feature workflow
argument-hint: <feature description>
---
# Team: Feature Implementation — Selector

Choose the right variant for your feature:

## Variants

| Command | Pipeline | Use When |
|---------|----------|----------|
| `/team-feature-backend` | researcher → architect → coder → tester → documentor → logger | Feature is backend-only (Python, CLI, data, API logic) |
| `/team-feature-fullstack` | researcher → architect → [backend-coder + ui-coder] → tester → documentor → logger | Feature spans both backend and frontend/UI |

## Decision Rule

- If the feature description mentions **UI, web, frontend, page, component, template, CSS, layout, form, button, dashboard, or view** → use `/team-feature-fullstack`
- If the feature is purely **Python logic, CLI, data model, storage, or API** with no user-facing UI → use `/team-feature-backend`
- When in doubt → use `/team-feature-fullstack` (the UI Coder will document "no frontend changes needed" if it turns out to be backend-only)

## Usage

Invoke the appropriate variant directly:

```
/team-feature-backend add retry logic to the storage module
/team-feature-fullstack add a task dashboard with filters and sorting
```
