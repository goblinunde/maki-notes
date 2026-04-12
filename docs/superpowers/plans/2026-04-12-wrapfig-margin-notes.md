# Wrapfig And Margin Notes Implementation Plan

## File Responsibilities

- `tests/test-wrap-layout.tex`: failing/then passing coverage for wrapped figures, side captions, and margin notes.
- `maki-notes.sty`: implement wrapped figure environments, side caption helpers, and margin note formatting.
- `example.tex`: document and demonstrate the new layout primitives in a realistic chapter section.

## Execution Checklist

- [ ] Verify the new test file is absent before adding it.
  Command: `test ! -f tests/test-wrap-layout.tex`
  Expected: exit status `0`
- [ ] Add `tests/test-wrap-layout.tex` that references the new public API before implementation.
  Command: `latexmk -pdf -interaction=nonstopmode -file-line-error tests/test-wrap-layout.tex`
  Expected: compile fails with undefined control sequence or undefined environment errors
- [ ] Implement wrapped figure environments in `maki-notes.sty`.
  Command: `rg -n "leftfiguretext|rightfiguretext|figuretextleft|figuretextright|wrapfig" maki-notes.sty`
  Expected: new environments and package import are present
- [ ] Implement side caption and margin note helpers in `maki-notes.sty`.
  Command: `rg -n "sidecaption|sidecaptionof|sidenote|marginremark|marginnote" maki-notes.sty`
  Expected: helper commands and package import are present
- [ ] Add a short demonstration section to `example.tex`.
  Command: `rg -n "页边批注|leftfiguretext|rightfiguretext|sidecaption|sidenote" example.tex`
  Expected: example usage is present
- [ ] Re-run the dedicated test after implementation.
  Command: `latexmk -pdf -interaction=nonstopmode -file-line-error tests/test-wrap-layout.tex`
  Expected: exit status `0`
- [ ] Rebuild `example.tex` to verify the feature integrates with a real document.
  Command: `latexmk -pdf -interaction=nonstopmode -file-line-error example.tex`
  Expected: exit status `0`
- [ ] Review the final diff for only intended style, example, and spec/plan changes.
  Command: `git diff -- maki-notes.sty example.tex tests/test-wrap-layout.tex docs/superpowers/specs/2026-04-12--wrapfig-margin-notes-design.md docs/superpowers/plans/2026-04-12-wrapfig-margin-notes.md`
  Expected: diff contains only additive feature work and documentation
