# agent-team-config

Reusable multi-agent team configuration for Claude Code. Gives any project
a full team of specialist agents (researcher, architect, coder, tester,
documentor, logger) that coordinate via skills.

## Quick Start

### Option A: Bootstrap an existing project (recommended)

```bash
git clone https://github.com/yanger/agent-team-config.git ~/agent-team-config
cd your-project/
~/agent-team-config/init.sh .
```

### Option B: Use as GitHub template

Click "Use this template" on GitHub to create a new repo with the full config.

### Option C: Manual copy

```bash
git clone https://github.com/yanger/agent-team-config.git
cp -r agent-team-config/.claude/ your-project/.claude/
```

## What You Get

### 7 Agent Personas (`.claude/agents/`)

| Agent | Role | Tools |
|-------|------|-------|
| manager | Evaluates requests, assembles optimal team | Read-only + Bash |
| researcher | Investigates codebase, identifies patterns | Read-only + Bash |
| backend-coder | Implements Python backend code | All tools |
| ui-coder | Builds frontend/UI components | All tools |
| tester | Writes and runs tests | Read + Bash + Edit |
| documentor | Updates PROGRESS.md, ARCHITECTURE.md | Read + Edit |
| logger | Records daily dev log entries | Read + Bash + Edit |

### 11 Team Skills (`.claude/skills/`)

Three tiers of automation:

```
/team <request>                  → Manager picks optimal team dynamically
/team-feature <desc>             → Selector: backend or fullstack?
/team-feature-fullstack <desc>   → Direct: 7-agent preset pipeline
```

| Skill | Pipeline | Use When |
|-------|----------|----------|
| /team | dynamic | Any request — manager selects agents |
| /team-feature | selector | New feature |
| /team-feature-backend | 6 agents | Backend-only feature |
| /team-feature-fullstack | 7 agents (parallel coders) | Fullstack feature |
| /team-bugfix | selector | Bug fix |
| /team-bugfix-backend | 5 agents | Backend-only bug fix |
| /team-bugfix-fullstack | 6 agents (parallel coders) | Fullstack bug fix |
| /team-quick | selector | Small change |
| /team-quick-backend | 4 agents | Small backend change |
| /team-quick-fullstack | 5 agents (parallel coders) | Small fullstack change |
| /distribute-log | 2 agents | Record daily dev log |

## Prerequisites

- Claude Code CLI installed (`npm install -g @anthropic-ai/claude-code`)
- Agent teams enabled (handled automatically by `.claude/settings.json`)

## Container / Remote Usage

If you run Claude Code inside a Docker container, clone this repo into
the container's workspace and run `init.sh`:

```bash
# Inside container
git clone https://github.com/yanger/agent-team-config.git /tmp/agent-team-config
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
├── agents/                    # 7 reusable agent personas
│   ├── manager.md
│   ├── researcher.md
│   ├── backend-coder.md
│   ├── ui-coder.md
│   ├── tester.md
│   ├── documentor.md
│   └── logger.md
└── skills/                    # 11 team workflow skills
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
    └── distribute-log/SKILL.md

templates/                     # Starter docs for bootstrapped projects
├── CLAUDE.md.template
├── PROGRESS.md.template
└── ARCHITECTURE.md.template

init.sh                        # Bootstrap script
README.md                      # This file
```

## License

MIT
