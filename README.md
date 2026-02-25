# agent-team-config

Reusable multi-agent team configuration for Claude Code. Gives any project
a full team of specialist agents (researcher, architect, coder, tester,
documentor, logger, git-manager) that coordinate via skills.

## Quick Start

### Option A: Bootstrap an existing project (recommended)

```bash
git clone https://github.com/YueYang101/Claude-Code-Agent-Teams.git ~/agent-team-config
cd your-project/
~/agent-team-config/init.sh .
```

### Option B: Use as GitHub template

Click "Use this template" on GitHub to create a new repo with the full config.

### Option C: Manual copy

```bash
git clone https://github.com/YueYang101/Claude-Code-Agent-Teams.git
cp -r agent-team-config/.claude/ your-project/.claude/
```

## What You Get

### 8 Agent Personas (`.claude/agents/`)

| Agent | Role | Tools |
|-------|------|-------|
| manager | Evaluates requests, assembles optimal team | Read-only + Bash |
| researcher | Investigates codebase, identifies patterns | Read-only + Bash |
| backend-coder | Implements Python backend code | All tools |
| ui-coder | Builds frontend/UI components | All tools |
| tester | Writes and runs tests | Read + Bash + Edit |
| documentor | Updates PROGRESS.md, ARCHITECTURE.md | Read + Edit |
| logger | Records daily dev log entries | Read + Bash + Edit |
| git-manager | Commit cleanup, branch management, PR prep | Read + Bash + Edit |

### 13 Team Skills (`.claude/skills/`)

Three tiers of automation:

```
/team <request>                  → Manager picks optimal team dynamically
/team-feature <desc>             → Selector: backend or fullstack?
/team-feature-fullstack <desc>   → Direct: preset pipeline
```

| Skill | Pipeline | Use When |
|-------|----------|----------|
| /team | dynamic | Any request — manager selects agents |
| /team-feature | selector | New feature |
| /team-feature-backend | core + epilogue | Backend-only feature |
| /team-feature-fullstack | core + epilogue (parallel coders) | Fullstack feature |
| /team-bugfix | selector | Bug fix |
| /team-bugfix-backend | core + epilogue | Backend-only bug fix |
| /team-bugfix-fullstack | core + epilogue (parallel coders) | Fullstack bug fix |
| /team-quick | selector | Small change |
| /team-quick-backend | core + epilogue | Small backend change |
| /team-quick-fullstack | core + epilogue (parallel coders) | Small fullstack change |
| /distribute-log | 2 agents | Record daily dev log |
| /git-cleanup | 1 agent | Standalone commit cleanup and PR prep |
| /update-docs | 1 agent | Standalone documentation update |

> **Pipeline structure**: All preset pipelines use a two-phase approach:
> - **Core phase** (blocking): researcher → architect → coder(s) → tester
> - **Epilogue phase** (background, optional): documentor + logger + git-manager run in parallel, gated by smart criteria

## Prerequisites

- Claude Code CLI installed (`npm install -g @anthropic-ai/claude-code`)
- Agent teams enabled (handled automatically by `.claude/settings.json`)

## Container / Remote Usage

If you run Claude Code inside a Docker container, clone this repo into
the container's workspace and run `init.sh`:

```bash
# Inside container
git clone https://github.com/YueYang101/Claude-Code-Agent-Teams.git /tmp/agent-team-config
cd /workspace/my-project
/tmp/agent-team-config/init.sh .
```

Or mount it as a volume so it persists across container restarts.

## Customization

### Change agent models

Edit `.claude/agents/<name>.md` — change the `model: opus` line in frontmatter.
Options: `opus`, `sonnet`, `haiku`.

### Add a new agent

Create `.claude/agents/my-agent.md` with frontmatter:

```yaml
---
name: my-agent
description: What this agent does
model: opus
allowed-tools: Read, Grep, Glob, Bash
---
Your agent's instructions here.
```

### Add a new skill

Create `.claude/skills/my-skill/SKILL.md` with frontmatter:

```yaml
---
name: my-skill
description: What this skill does
disable-model-invocation: true
argument-hint: <description>
---
Your skill's workflow instructions here.
```

## File Structure

```
.claude/
├── settings.json              # Enables agent teams
├── agents/                    # 8 reusable agent personas
│   ├── manager.md
│   ├── researcher.md
│   ├── backend-coder.md
│   ├── ui-coder.md
│   ├── tester.md
│   ├── documentor.md
│   ├── logger.md
│   └── git-manager.md
└── skills/                    # 13 team workflow skills
    ├── team/SKILL.md
    ├── team-feature/SKILL.md
    ├── team-feature-backend/SKILL.md
    ├── team-feature-fullstack/
    │   ├── SKILL.md
    │   ├── integration-contract-template.md
    │   └── example-feature-output.md
    ├── team-bugfix/SKILL.md
    ├── team-bugfix-backend/SKILL.md
    ├── team-bugfix-fullstack/
    │   ├── SKILL.md
    │   └── bug-report-template.md
    ├── team-quick/SKILL.md
    ├── team-quick-backend/SKILL.md
    ├── team-quick-fullstack/SKILL.md
    ├── distribute-log/SKILL.md
    ├── git-cleanup/SKILL.md
    └── update-docs/SKILL.md

templates/                     # Starter docs for bootstrapped projects
├── CLAUDE.md.template
├── PROGRESS.md.template
└── ARCHITECTURE.md.template

init.sh                        # Bootstrap script
README.md                      # This file
```

## License

MIT
