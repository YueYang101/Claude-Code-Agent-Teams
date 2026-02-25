# Architecture — Module Structure

> Reference for agents to understand directory ownership and key interfaces.

## Module Overview

| Module | Directory | Owner | Description |
|--------|-----------|-------|-------------|
| | | | |

## Directory Ownership

```
.
├── CLAUDE.md                       # Project brief (read-only reference)
├── PROGRESS.md                     # Session memory (updated by agents)
├── ARCHITECTURE.md                 # This file (updated when structure changes)
├── Log/                            # Daily dev logs (auto-written by logger agent)
│   └── <YYYY-MM>/                  # Month folders
│       └── <YYYY-MM-DD>.md         # Daily log entries
├── .claude/
│   ├── settings.json               # Claude Code settings (agent teams enabled)
│   ├── agents/                     # 8 reusable agent personas
│   │   ├── manager.md
│   │   ├── researcher.md
│   │   ├── backend-coder.md
│   │   ├── ui-coder.md
│   │   ├── tester.md
│   │   ├── documentor.md
│   │   ├── logger.md
│   │   └── git-manager.md
│   └── skills/                     # 13 team workflow skills
│       ├── team/SKILL.md
│       ├── team-feature/SKILL.md
│       ├── team-feature-backend/SKILL.md
│       ├── team-feature-fullstack/
│       │   ├── SKILL.md
│       │   ├── integration-contract-template.md
│       │   └── example-feature-output.md
│       ├── team-bugfix/SKILL.md
│       ├── team-bugfix-backend/SKILL.md
│       ├── team-bugfix-fullstack/
│       │   ├── SKILL.md
│       │   └── bug-report-template.md
│       ├── team-quick/SKILL.md
│       ├── team-quick-backend/SKILL.md
│       ├── team-quick-fullstack/SKILL.md
│       ├── distribute-log/SKILL.md
│       ├── git-cleanup/SKILL.md
│       └── update-docs/SKILL.md
└── src/                            # Source code
    └── ...
```

## Key Interfaces

<!-- Document your project's key interfaces here -->

## Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| | | |
