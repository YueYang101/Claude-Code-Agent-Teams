# agent-team-config

## Coding Conventions

- Follow PEP 8; max line length 100.
- Use type hints on all public functions.
- Docstrings: Google style.
- Imports: stdlib → third-party → local, separated by blank lines.
- No wildcard imports.
- Prefer `pathlib.Path` over `os.path`.
- Tests mirror source layout under `tests/`.

<!-- AGENT-TEAM-CONFIG-START -->
## Agent Team Rules

1. **Read before writing.** Always read the target file before editing it.
2. **One concern per commit.** Each logical change gets its own commit.
3. **Update session memory.** After completing work, update `PROGRESS.md`.
4. **Respect module ownership.** See `ARCHITECTURE.md` for directory boundaries.
5. **Run tests.** Every code change must pass tests before marking a task complete.
6. **No secrets in code.** Environment variables for credentials; never hardcode.

## Skills (Team Workflows)

Three ways to launch teams (from most to least automated):

```
/team add a task dashboard          → Manager evaluates, asks questions if needed,
                                      assembles custom team dynamically

/team-feature add a task dashboard  → Selector shows backend vs fullstack choice,
                                      user picks, runs preset pipeline

/team-feature-fullstack add a ...   → Direct: runs preset pipeline immediately
```

| Skill | Agents | Use When |
|-------|--------|----------|
| `/team` | _(dynamic — manager selects)_ | Let the manager pick the optimal team for any request |
| `/team-feature` | _(selector)_ | Choose between backend or fullstack feature workflow |
| `/team-feature-backend` | researcher → architect → coder → tester ∥ [epilogue] | Backend-only feature (no UI) |
| `/team-feature-fullstack` | researcher → architect → [backend-coder + ui-coder] → tester ∥ [epilogue] | Fullstack feature (parallel coders) |
| `/team-bugfix` | _(selector)_ | Choose between backend or fullstack bugfix workflow |
| `/team-bugfix-backend` | researcher → coder → tester ∥ [epilogue] | Backend-only bug fix |
| `/team-bugfix-fullstack` | researcher → [backend-coder + ui-coder] → tester ∥ [epilogue] | Fullstack bug fix (parallel coders) |
| `/team-quick` | _(selector)_ | Choose between backend or fullstack quick task |
| `/team-quick-backend` | coder → tester ∥ [epilogue] | Small backend-only change |
| `/team-quick-fullstack` | [backend-coder + ui-coder] → tester ∥ [epilogue] | Small fullstack change (parallel coders) |
| `/distribute-log` | researcher → logger | Manually recording a daily dev log |
| `/git-cleanup` | git-manager | Standalone commit cleanup, branch management, PR prep |
| `/update-docs` | documentor | Standalone documentation update |

> **∥ [epilogue]** = after tester completes, the team lead evaluates and optionally spawns documentor, logger, and/or git-manager **in parallel, in the background**. See pipeline skill files for gating criteria.

## Key Files

| File | Purpose |
|------|---------|
| `CLAUDE.md` | This file — project brief and conventions |
| `PROGRESS.md` | Session memory: sprint status tracking |
| `ARCHITECTURE.md` | Module structure and ownership map |
| `.claude/settings.json` | Claude Code settings (agent teams enabled) |
| `.claude/skills/*/SKILL.md` | Reusable multi-agent team skills (with frontmatter) |
| `.claude/agents/*.md` | Reusable agent personas (researcher, coder, tester, git-manager, etc.) |
<!-- AGENT-TEAM-CONFIG-END -->
