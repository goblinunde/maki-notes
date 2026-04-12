# README And Tag Release Workflow Plan

## File Responsibilities

- `README.md`: describe the template, prerequisites, build commands, repository layout, and the tag-driven release process.
- `.github/workflows/release.yml`: run only on tag pushes, build the TeX assets, package source files, and create or update the corresponding GitHub Release.

## Execution Checklist

- [ ] Verify the current gap by checking that `README.md` and `.github/workflows/release.yml` do not exist yet.
  Files: none
  Command: `test ! -f README.md && test ! -f .github/workflows/release.yml`
  Expected: exit status `0`
- [ ] Verify the gap explicitly by listing repository root and workflow files.
  Files: none
  Command: `rg --files -g 'README.md' -g '.github/workflows/*.yml'`
  Expected: output contains `.github/workflows/claude.yml` only
- [ ] Add `README.md` with a failing coverage target in mind: it must mention XeLaTeX, `make`, key source files, and tag release behavior.
  Files: `README.md`
  Verification command: `rg -n "XeLaTeX|make test|maki-notes\\.cls|push.*tag|Release" README.md`
  Expected: all required concepts appear in matches
- [ ] Add `.github/workflows/release.yml` with tag-only trigger and release steps.
  Files: `.github/workflows/release.yml`
  Verification command: `rg -n "push:|tags:|release|upload|make all|GITHUB_TOKEN|softprops/action-gh-release" .github/workflows/release.yml`
  Expected: matches confirm tag trigger, build, and release publication logic
- [ ] Perform a minimal syntax-oriented verification after editing.
  Files: `README.md`, `.github/workflows/release.yml`
  Command: `sed -n '1,240p' README.md && printf '\n---\n' && sed -n '1,260p' .github/workflows/release.yml`
  Expected: coherent Markdown and workflow YAML with no placeholder text
- [ ] Run a release-logic verification that proves the workflow is tag-only.
  Files: `.github/workflows/release.yml`
  Command: `rg -n "on:|tags:" .github/workflows/release.yml`
  Expected: trigger block shows `push` with tag patterns and no branch push trigger
- [ ] If local TeX tooling is available, run the existing build entry point once.
  Files: existing project sources
  Command: `make smoke`
  Expected: exit status `0`; otherwise record the toolchain limitation precisely
- [ ] Review `git diff -- README.md .github/workflows/release.yml docs/superpowers/plans/2026-04-12-readme-release-workflow.md` before completion.
  Files: edited files
  Command: `git diff -- README.md .github/workflows/release.yml docs/superpowers/plans/2026-04-12-readme-release-workflow.md`
  Expected: diff contains only the intended documentation and workflow changes
