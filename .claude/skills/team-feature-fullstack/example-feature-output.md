# Example: "Add task filtering" feature output

> This document shows what a successful fullstack pipeline produces at each stage. Use it as a reference for quality and completeness.

## 1. Researcher found

**Backend:**
- Existing filter patterns in `src/task_manager/cli.py` (line 45-60) — `list` subcommand already supports `--status` flag
- `storage.py` has `load_tasks()` but no filtering — returns all tasks
- `models.py` has `Status` enum with `TODO`, `IN_PROGRESS`, `DONE`
- Risk: Adding filter params to `load_tasks()` changes its signature — check all callers

**Frontend/UI:**
- No frontend exists yet in the project
- Recommended: Flask + Jinja2 (lightweight, matches Python stack)
- UI patterns from Todoist/Linear: sidebar filters, tag chips, clear-all button
- Accessibility: filter controls need keyboard navigation, ARIA labels for screen readers

## 2. Architect produced

**Backend plan:**
- Add `filter_tasks(status, priority)` to `storage.py` — keep `load_tasks()` unchanged
- Add `GET /api/tasks?status=<status>&priority=<priority>` route in new `api.py`
- Return JSON: `{"tasks": [...], "total": int, "filters_applied": {...}}`

**Frontend plan:**
- `templates/tasks.html` — main task list with filter sidebar
- `static/css/tasks.css` — responsive layout with filter panel
- `static/js/filters.js` — fetch API calls, DOM updates

**Integration contract:**
```
GET /api/tasks?status=done&priority=high
Response: {"tasks": [{"id": 1, "title": "...", "status": "done", "priority": "high"}], "total": 1}
```

## 3. Backend Coder implemented
- `src/task_manager/storage.py` — added `filter_tasks()` function
- `src/task_manager/api.py` — new Flask blueprint with `/api/tasks` endpoint
- All interfaces match integration contract exactly

## 4. UI Coder implemented
- `templates/tasks.html` — responsive task list with filter sidebar
- `static/css/tasks.css` — mobile-first layout
- `static/js/filters.js` — calls `GET /api/tasks` with query params
- Keyboard navigation works, ARIA labels on filter controls

## 5. Tester verified
- `tests/test_storage.py` — 8 new tests for `filter_tasks()`
- `tests/test_api.py` — 6 new tests for `/api/tasks` endpoint
- `tests/test_ui.py` — 4 new tests for template rendering
- All 18 tests passing, plus existing 12 tests still green

## 6. Documentor updated
- `PROGRESS.md` — added "Task filtering feature (backend + frontend)" to completed items
- `ARCHITECTURE.md` — added `api.py` module, `templates/` and `static/` directories
- Added Google-style docstrings to `filter_tasks()` and API route

## 7. Logger recorded
- `Log/2026-02/2026-02-22.md` — full entry with 4 commits, summary of all layers
