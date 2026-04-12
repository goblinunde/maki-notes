# Wrap Feature Docs, Tests, And Git Plan

## File Responsibilities

- `docs/wrapfig-margin-notes.md`: user-facing guide for wrapped figures, side captions, and outer margin notes.
- `tests/test-wrap-layout.tex`: consolidated regression document covering the new public APIs in one place.
- `README.md`: top-level feature summary, usage pointers, and links to the new guide and test document.
- `.gitignore`: ignore any newly generated PDF artifact if the test target name changes.

## Execution Checklist

- [ ] Inspect current docs and test coverage before editing.
  Commands: `sed -n '1,260p' README.md`, `sed -n '1,220p' tests/test-wrap-layout.tex`
  Expected: current README lacks a dedicated usage guide section for the new layout API, and the consolidated test can be expanded in place.
- [ ] Add a user-facing markdown guide at `docs/wrapfig-margin-notes.md`.
  Command: `sed -n '1,260p' docs/wrapfig-margin-notes.md`
  Expected: guide documents `leftfiguretext`, `rightfiguretext`, `wrapcaption`, `sidecaption`, `sidenote`, and `marginremark`.
- [ ] Refresh `tests/test-wrap-layout.tex` to keep all new layout features covered in one document.
  Command: `latexmk -pdf -interaction=nonstopmode -file-line-error tests/test-wrap-layout.tex`
  Expected: exit status `0` and the generated PDF demonstrates both wrap directions, caption placements, and margin note styles.
- [ ] Update `README.md` to mention the new layout features and point to the detailed guide and consolidated test.
  Command: `rg -n "图文绕排|页边批注|wrapfig-margin-notes|test-wrap-layout" README.md`
  Expected: new feature section and references are present.
- [ ] Verify the updated documentation and test document against the actual template.
  Commands: `latexmk -pdf -interaction=nonstopmode -file-line-error tests/test-wrap-layout.tex`, `latexmk -pdf -interaction=nonstopmode -file-line-error example.tex`
  Expected: both commands exit with status `0`.
- [ ] Attempt repository submission steps.
  Commands: `git add ...`, `git commit -m "Document wrap layouts and margin notes"`, `git push origin <branch>`
  Expected: commit and push succeed, or the environment reports the exact restriction that prevents them.
