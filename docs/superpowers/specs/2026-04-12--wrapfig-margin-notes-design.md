# Wrapfig And Margin Notes Design

## Goal

Extend `maki-notes` with layout primitives that support:

- wrapped image blocks for “左图右文” and “右图左文”
- figure captions either below the wrapped figure or in the outer page margin
- unframed outer margin annotations that match the existing `maki-notes` visual language

## Constraints

- Preserve the current template identity: existing colors, fonts, and caption tone should remain recognizable.
- Avoid introducing a new page-wide layout system or redesigning the whole text block.
- Keep the new API easy to use in lecture-note prose and compatible with `XeLaTeX`.
- Prefer stable behavior in ordinary paragraphs over aggressively smart float placement.

## User-Facing API

### Wrapped figure environments

- `leftfiguretext`
  Behavior: wraps the following paragraph(s) around a figure placed on the left.
- `rightfiguretext`
  Behavior: wraps the following paragraph(s) around a figure placed on the right.

Each environment will accept:

- an optional line-count argument forwarded to `wrapfigure`
- a mandatory width argument for the figure block
- body content containing `\includegraphics`, `tikzpicture`, and optionally `\caption{...}` or `\sidecaption{...}`

Aliases will also be provided:

- `figuretextleft`
- `figuretextright`

### Caption helpers

- Standard `\caption{...}` remains available inside wrapped figure environments for a caption below the figure.
- `\wrapcaption{...}` will be added as a semantic alias to `\caption{...}`.
- `\sidecaption{...}` will create a figure-numbered side caption in the outer margin.
- `\sidecaptionof{<type>}{...}` will support generic side captions, with `figure` as the primary target.

### Margin note helpers

- `\sidenote{...}`: plain outer margin note, no title.
- `\marginremark[<title>]{...}`: outer margin note with a small colored title.

## Visual Language

### Wrapped figures

- No decorative box around the figure itself.
- Slightly tighter spacing than a standard float.
- Caption styling should reuse the template colors and current caption package.

### Margin notes and side captions

- No full border box.
- A single thin vertical line on the side adjacent to the text block.
- Small font size with restrained line spacing.
- Title in `LogicColor`, content in subdued main text.
- Minimal internal padding so the note feels like a margin annotation, not a callout card.

## Implementation Notes

- Add `wrapfig` for wrapped figure placement.
- Add `marginnote` for non-floating margin notes.
- Keep geometry mostly unchanged; use the existing right-side layout and narrow note width to avoid a global page redesign.
- Base margin note formatting on a compact tabular/minipage structure so the vertical rule can stretch with the text.
- For two-sided layouts, use page parity to keep the rule on the side closest to the text block when possible.

## Example Usage

```tex
\begin{rightfiguretext}{0.42\textwidth}
  \centering
  \includegraphics[width=\linewidth]{example-image}
  \sidecaption{条件概率示意图}
\end{rightfiguretext}
这一段正文会自动绕排到图的左侧, 适合插入图示说明。

\sidenote{这里补一条页边说明, 用来提示读者当前图示的关键结论。}

\begin{leftfiguretext}[14]{0.38\textwidth}
  \centering
  \includegraphics[width=\linewidth]{example-image}
  \wrapcaption{图下题注示例}
\end{leftfiguretext}
这一段正文会自动绕排到图的右侧。

\marginremark[提示]{页边批注适合放补充解释、定义提醒或推导中的旁支说明。}
```

## Self-Review

- API covers both requested wrapped layouts.
- Caption placement covers both below-figure and margin-side cases.
- Margin note style matches the “no box, thin line, small text” requirement.
- Scope stays limited to additive style primitives rather than a template-wide redesign.
