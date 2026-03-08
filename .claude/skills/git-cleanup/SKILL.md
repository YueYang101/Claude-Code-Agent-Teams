---
name: git-cleanup
description: Clean up commits, manage branches, and prepare PRs
argument-hint: [optional branch name or PR title]
---
# Standalone: Git Cleanup

Invoke the git-manager agent to clean up commit history, ensure work is on a feature branch, and optionally prepare a pull request.

## Context
$ARGUMENTS

## Workflow

Spawn a single **git-manager** agent (general-purpose — `.claude/agents/git-manager.md`) with the following task:

### Git Manager
- **Task**: Assess the current git state and perform cleanup:
  1. Check the current branch — if on `main`/`master`, create a feature branch first.
  2. Review recent commits since divergence from the base branch.
  3. Squash WIP/fixup commits and rewrite messages to conventional commit format.
  4. Generate a PR description summarizing the changes.
  5. If `gh` CLI is available and the user wants a PR, create a draft PR.
- **Context from user**: $ARGUMENTS (may include branch name, PR title, or specific instructions)
- **Safety**: NEVER mutate main/master. Only rebase/squash on feature branches.
- **Output**: Clean commit history on a feature branch, PR description ready.
