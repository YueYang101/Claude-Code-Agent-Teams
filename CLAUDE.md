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
## Auto-Trigger Agent Teams

**MANDATORY**: On EVERY user message, you MUST automatically route the request through the agent team system by invoking `/team`. Do NOT work solo — always use the team workflow unless the user explicitly opts out.

### How It Works

1. **Every request goes to the manager agent** via `/team` — the manager evaluates, classifies, and assembles the optimal team
2. **Default assumption: all tasks are complex.** Downgrade to single-agent only if the scope is provably trivial
3. **The manager decides** the team composition, agent count, and execution order — not a static lookup table
4. **No exceptions** for investigation, research, or "just a question" requests — the manager routes these to a researcher agent

### When to Skip (Opt-Out Only)

Teams are skipped ONLY when the user explicitly says:
- "no team" / "solo" / "do it yourself" / "skip agents" / "just answer"
- These disable the team for that single message only — next message re-enables auto-trigger

### Complexity Guidelines

| Scope | Team Size | Example |
|-------|-----------|---------|
| Trivial (provably single-line) | Skip teams | "what does X mean?", greetings |
| Small (1-2 files) | 2-3 agents | rename, config change, quick fix |
| Standard (3-5 files) | 3-5 agents | feature, bugfix, refactor |
| Complex (5+ files, multi-layer) | 5-7 agents | fullstack feature, large refactor |

**When in doubt, use more agents, not fewer.**

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
