# GitHub Models Workflows Plan

## File Responsibilities

- `.github/workflows/issue-model-comment.yml`: call GitHub Models on issue events and post an issue comment.
- `.github/workflows/pr-model-comment.yml`: call GitHub Models on pull request events and post a PR comment.
- `.github/workflows/release.yml`: extend the existing tag release workflow to generate AI release notes before publishing the release.
- `README.md`: document the new workflows, triggers, and required permissions.

## Execution Checklist

- [ ] Verify the new workflow files do not exist yet.
  Command: `test ! -f .github/workflows/issue-model-comment.yml && test ! -f .github/workflows/pr-model-comment.yml`
  Expected: exit status `0`
- [ ] Add the issue comment workflow with `models: read` and `issues: write`.
  Command: `rg -n "models: read|issues: write|issues:|createComment|models.github.ai" .github/workflows/issue-model-comment.yml`
  Expected: matches confirm trigger, permission scope, model call, and comment creation
- [ ] Add the PR comment workflow with `models: read` and `pull-requests: write`.
  Command: `rg -n "models: read|pull-requests: write|pull_request:|createComment|models.github.ai" .github/workflows/pr-model-comment.yml`
  Expected: matches confirm trigger, permission scope, model call, and PR comment creation
- [ ] Update the release workflow so tag pushes also generate AI release notes.
  Command: `rg -n "models: read|contents: write|Generate AI release notes|body_path|models.github.ai" .github/workflows/release.yml`
  Expected: matches confirm release-note generation and publish wiring
- [ ] Update `README.md` so users know when each workflow runs and which permissions are required.
  Command: `rg -n "GitHub Models|issue|PR|release notes|models: read|issues: write|pull-requests: write|contents: write" README.md`
  Expected: all workflow behaviors and permission scopes appear
- [ ] Perform syntax-oriented verification by reading the edited workflow files and README.
  Command: `sed -n '1,260p' .github/workflows/issue-model-comment.yml && printf '\n---\n' && sed -n '1,260p' .github/workflows/pr-model-comment.yml && printf '\n---\n' && sed -n '1,320p' .github/workflows/release.yml`
  Expected: coherent YAML with no placeholder text
- [ ] Review the final diff for only intended workflow and README changes.
  Command: `git diff -- .github/workflows/issue-model-comment.yml .github/workflows/pr-model-comment.yml .github/workflows/release.yml README.md docs/superpowers/plans/2026-04-12-github-models-workflows.md`
  Expected: diff contains only workflow, documentation, and plan changes
