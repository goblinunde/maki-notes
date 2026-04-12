# Maki Notes

`maki-notes` 是一个面向中文数学讲义的 LaTeX 模板项目，核心由 [`maki-notes.cls`](./maki-notes.cls) 和 [`maki-notes.sty`](./maki-notes.sty) 组成，基于 `ctexbook`，默认使用 XeLaTeX 编译。仓库同时提供了示例文档、TikZ 模板页以及一组用于烟雾测试的最小文档。

## 特性

- 基于 `ctexbook` 的中文讲义排版入口
- 内置封面、章节标题、页眉页脚与数学环境样式
- 提供定义、定理、例题、真题、注释等讲义常用盒子环境
- 集成 `TikZ`、`PGFPlots`、`tikz-3dplot` 等绘图能力
- 自带示例文档和基础测试文档，便于二次开发和回归验证

## 环境要求

- TeX Live，且可使用 `xelatex`
- `latexmk`
- `make`

项目默认通过 [`latexmkrc`](./latexmkrc) 指定 XeLaTeX：

```sh
xelatex -interaction=nonstopmode -file-line-error
```

## 快速开始

直接基于 [`example.tex`](./example.tex) 或 [`document2.tex`](./document2.tex) 修改即可：

```tex
\documentclass[a4paper,12pt,oneside]{maki-notes}

\renewcommand{\LectureNotesTitle}{你的讲义标题}
\renewcommand{\CoverTitle}{你的讲义标题}
\renewcommand{\CoverAuthorBlock}{作者信息}
\renewcommand{\CoverFooterBlock}{日期或附注}

\begin{document}
\frontmatter
\MakeTitlePage
\tableofcontents

\mainmatter
\chapter{第一章}
讲义正文。
\end{document}
```

## 常用命令

```sh
make main
make example
make tikz-templates
make smoke
make test
make clean
```

说明：

- `make main`：编译主示例 [`document2.tex`](./document2.tex)
- `make example`：编译简化示例 [`example.tex`](./example.tex)
- `make tikz-templates`：编译 TikZ 模板页 [`tikz-template-pages.tex`](./tikz-template-pages.tex)
- `make smoke`：编译最小烟雾测试文档 [`smoke-packaging.tex`](./smoke-packaging.tex)
- `make test`：编译烟雾文档和 `tests/` 下的基础测试文档
- `make clean`：清理中间文件

## 仓库结构

```text
.
├── maki-notes.cls
├── maki-notes.sty
├── latexmkrc
├── Makefile
├── document2.tex
├── example.tex
├── tikz-template-pages.tex
├── smoke-packaging.tex
└── tests/
```

关键文件说明：

- `maki-notes.cls`：文档类入口，定义标题页接口并加载样式包
- `maki-notes.sty`：样式主体，集中管理字体、颜色、环境和 TikZ 样式
- `document2.tex`：较完整的讲义模板示例
- `example.tex`：更适合作为二次开发起点的示例文档
- `tikz-template-pages.tex`：可直接复用的图形模板页
- `tests/`：用于验证模板基础能力的测试文档

## GitHub Release 流程

仓库中的 release workflow 位于 [`.github/workflows/release.yml`](./.github/workflows/release.yml)，只会在推送 tag 时运行，不会在普通分支 push 时触发。

推荐使用语义化版本 tag，例如：

```sh
git tag v0.1.0
git push origin v0.1.0
```

workflow 会执行以下动作：

- 检出代码
- 用 XeLaTeX 编译示例文档和测试文档
- 打包一份源码发行包
- 创建或更新与当前 tag 对应的 GitHub Release
- 上传编译后的 PDF 和源码包作为 release assets

当前 release 资产包括：

- `maki-notes-<tag>-source.tar.gz`
- `maki-notes-<tag>-manual.pdf`
- `maki-notes-<tag>-example.pdf`
- `maki-notes-<tag>-tikz-templates.pdf`

## 开发建议

- 修改模板能力时，先更新 [`maki-notes.sty`](./maki-notes.sty) 或 [`maki-notes.cls`](./maki-notes.cls)，再运行 `make test`
- 新增展示内容时，优先放到 `example.tex` 或 `tikz-template-pages.tex`
- 发布新版本时，只需要推送新的 tag；普通提交不会触发 release workflow
