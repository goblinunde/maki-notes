# Math Workflow Guide Implementation Plan

## File Responsibilities

- `maki-notes.sty`
  Add course metadata storage, chapter metadata storage, chapter guide rendering, local chapter navigation, and math workflow block environments.
- `Makefile`
  Add the new workflow guide test document to the `test` target.
- `tests/test-workflow-guide.tex`
  Exercise the new public API and fail before implementation.
- `example.tex`
  Demonstrate the new workflow API in a realistic lecture-note chapter.
- `README.md`
  Mention the workflow-layer capabilities and point to the dedicated doc.
- `docs/README.md`
  Add the new workflow guide document to the reader-facing index.
- `docs/template-guide.md`
  Summarize the new workflow-layer API in the main template overview.
- `docs/workflow-guide.md`
  Document the new API, usage pattern, and chapter guide structure.

## Constraints

- Keep old documents compatible when they do not use the new API.
- Keep public command names exactly as specified:
  - `\SetCourseInfo`
  - `\SetChapterInfo`
  - `\MakeChapterGuide`
  - `keyformula`
  - `pitfall`
  - `methodnote`
  - `examfocus`
- Use TDD: each behavior starts with a failing test run, then the minimum implementation, then a passing rerun.

## Task 1: Add a failing workflow guide test skeleton

- Files:
  - `tests/test-workflow-guide.tex`
- Steps:
  - Create `tests/test-workflow-guide.tex` with one chapter that uses:
    - `\SetCourseInfo`
    - `\SetChapterInfo`
    - `\chapter`
    - `\MakeChapterGuide`
  - Include at least two sections so chapter-local navigation has real content.
  - Include one `keyformula`, `pitfall`, `methodnote`, and `examfocus` block in the正文.
  - Do not change `maki-notes.sty` yet.
  - Run:
    - `latexmk -pdf -interaction=nonstopmode -file-line-error tests/test-workflow-guide.tex`
  - Expected red result:
    - build fails with undefined control sequence errors for the new workflow commands and environments.

## Task 2: Implement course and chapter metadata commands

- Files:
  - `maki-notes.sty`
- Steps:
  - Add internal storage macros for course-level and chapter-level metadata.
  - Add a `pgfkeys`-based parser for `\SetCourseInfo{...}`.
  - Add a `pgfkeys`-based parser for `\SetChapterInfo{...}`.
  - Hook into `\chapter` so “pending chapter metadata” binds to the chapter that was just opened and does not leak to the next chapter.
  - Re-run:
    - `latexmk -pdf -interaction=nonstopmode -file-line-error tests/test-workflow-guide.tex`
  - Expected red result:
    - build should still fail, but now on `\MakeChapterGuide` or the new block environments instead of the metadata commands.

## Task 3: Implement the chapter guide page and chapter-local navigation

- Files:
  - `maki-notes.sty`
- Steps:
  - Add any package support needed for stable chapter-local TOC rendering.
  - Implement `\MakeChapterGuide{...}` with `pgfkeys`.
  - Render a separate guide page with:
    - chapter number and title
    - subtitle
    - course/lecture/date line
    - prereq/goals/keywords/route/formulas/methods/pitfalls/examfocus blocks
    - a local chapter navigation block
  - Ensure empty fields are omitted cleanly.
  - Re-run:
    - `latexmk -pdf -interaction=nonstopmode -file-line-error tests/test-workflow-guide.tex`
  - Expected red result:
    - build should still fail only if the new block environments are not implemented yet.

## Task 4: Implement the math workflow block environments

- Files:
  - `maki-notes.sty`
- Steps:
  - Add `tcolorbox` environments:
    - `keyformula`
    - `pitfall`
    - `methodnote`
    - `examfocus`
  - Reuse the current semantic colors and box language.
  - Keep them unnumbered.
  - Re-run:
    - `latexmk -pdf -interaction=nonstopmode -file-line-error tests/test-workflow-guide.tex`
  - Expected green result:
    - `tests/test-workflow-guide.tex` compiles successfully.

## Task 5: Wire the new test into the repository test target

- Files:
  - `Makefile`
- Steps:
  - Add `tests/test-workflow-guide.tex` to `TEST_DOCS`.
  - Add `test-workflow-guide` to `TEST_NAMES`.
  - Run:
    - `make test`
  - Expected result:
    - the new test is included in the standard regression suite.
  - If failures occur in existing tests, fix only the regressions caused by the new workflow implementation.

## Task 6: Document the new workflow layer

- Files:
  - `README.md`
  - `docs/README.md`
  - `docs/template-guide.md`
  - `docs/workflow-guide.md`
- Steps:
  - Add a concise overview of the new workflow-layer capabilities to `README.md`.
  - Add `docs/workflow-guide.md` to the docs index.
  - Update `docs/template-guide.md` with the new public API and intended usage flow.
  - Create `docs/workflow-guide.md` with:
    - setup flow
    - API reference
    - chapter guide example
    - notes on local chapter navigation
    - examples of the four workflow blocks
  - Run:
    - `rg -n "SetCourseInfo|SetChapterInfo|MakeChapterGuide|keyformula|pitfall|methodnote|examfocus" README.md docs example.tex tests`
  - Expected result:
    - all new public names appear in the expected docs and examples.

## Task 7: Update the example document

- Files:
  - `example.tex`
- Steps:
  - Add one realistic chapter using the new workflow-layer API.
  - Keep the existing example readable; do not convert every chapter.
  - Run:
    - `latexmk -pdf -interaction=nonstopmode -file-line-error example.tex`
  - Expected result:
    - the example compiles and visibly demonstrates the new guide page.

## Task 8: Final verification

- Files:
  - none
- Steps:
  - Run:
    - `make test`
    - `make example`
  - Read full outputs and confirm exit code `0` for both.
  - Check `git diff --stat` for scope sanity.

## Suggested Commit Sequence

- Commit 1:
  - `test: add failing workflow guide coverage`
- Commit 2:
  - `feat: add course and chapter workflow metadata`
- Commit 3:
  - `feat: add chapter guide page and math workflow blocks`
- Commit 4:
  - `docs: document workflow guide API`

## Self-Review

- The plan maps each file to a clear responsibility.
- Every implementation task includes an explicit red/green loop.
- Public names match the approved spec exactly.
- The verification commands are concrete and reproducible.
- No placeholders or vague steps remain.
