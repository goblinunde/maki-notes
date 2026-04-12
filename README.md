# Maki Notes

`maki-notes` 是一个面向中文数学讲义的 LaTeX 模板项目，核心由 [`maki-notes.cls`](./maki-notes.cls) 和 [`maki-notes.sty`](./maki-notes.sty) 组成，基于 `ctexbook`，默认使用 XeLaTeX 编译。仓库同时提供了示例文档、TikZ 模板页以及一组用于烟雾测试的最小文档。

这两个文件是同一套模板的两层，而不是两个完全解耦的通用组件：

- `maki-notes.cls` 是文档类入口，负责建立文档类、接收类选项并加载样式层
- `maki-notes.sty` 是模板主体实现，集中管理字体、页面、颜色、环境、TikZ 样式和页眉页脚

也就是说，当前仓库推荐的使用方式始终是：

```tex
\documentclass[...]{maki-notes}
```

而不是把 `.sty` 单独当成一个轻量通用包到处插拔。

## 特性

- 基于 `ctexbook` 的中文讲义排版入口
- 内置封面、章节标题、页眉页脚与数学环境样式
- 提供定义、定理、例题、真题、注释等讲义常用盒子环境
- 提供左右图文绕排、页边侧题注与无边框页边批注
- 集成 `TikZ`、`PGFPlots`、`tikz-3dplot` 等绘图能力
- 自带示例文档和基础测试文档，便于二次开发和回归验证

## 文档入口

如果你希望看比 README 更完整的说明，建议直接从 [`docs/README.md`](./docs/README.md) 开始。`docs/` 目录目前包含：

- [`docs/template-guide.md`](./docs/template-guide.md)：模板总览、类选项、编译方式和维护建议
- [`docs/wrapfig-margin-notes.md`](./docs/wrapfig-margin-notes.md)：图文绕排、侧题注与页边批注
- [`docs/tikz-template-pages.md`](./docs/tikz-template-pages.md)：TikZ 模板册、样式族和新增页面索引

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

如果你希望切换跨平台字体预设或主题配色，可以直接在 `\documentclass[...]` 里传入：

```tex
\documentclass[
  a4paper,
  12pt,
  oneside,
  fontpreset=common,
  theme=default
]{maki-notes}
```

## 字体与主题预设

模板现在支持两组类选项：

- `fontpreset=common|auto|windows|macos|linux`
- `theme=default|ocean|forest|graphite|amber|berry|sandstone`

默认值是：

- `fontpreset=common`
- `theme=default`

推荐写法：

```tex
\documentclass[
  a4paper,
  12pt,
  oneside,
  fontpreset=auto,
  theme=ocean
]{maki-notes}
```

### `fontpreset`

- `common`：默认预设，优先使用 TeX Live 自带或稳定可用的字体组合，跨平台最稳
- `auto`：按当前机器已安装字体自动选择最接近的平台预设
- `windows`：优先使用常见 Windows 中文字体，缺失时回退到 `common`
- `macos`：优先使用常见 macOS 中文字体，缺失时回退到 `common`
- `linux`：优先使用常见 Linux 中文字体，缺失时回退到 `common`

当前策略是：拉丁正文统一走更接近 Palatino 数学风格的正文字体栈，中文字体再按预设切换。这样可以避免旧版本里正文和数学字体风格不一致的问题。

### `theme`

- `default`：当前仓库原有的默认配色
- `ocean`：偏蓝青，更轻快
- `forest`：偏绿灰，更沉稳
- `graphite`：偏墨灰与铜棕，更正式
- `amber`：偏琥珀与蓝灰，适合讲义封面和流程图
- `berry`：偏莓红与靛灰，层次更强但仍保持克制
- `sandstone`：偏砂岩与石板灰，更接近纸面笔记气质

主题切换不会改变公开接口，只会改写现有的语义色位，例如 `LogicColor`、`DefColor`、`ExColor`、`NoteColor` 等。因此现有环境、TikZ 样式和页边批注会一起换色，但代码写法不需要变。

### 回退与报错

- 如果你选中了某个平台预设，但本机缺少对应字体，模板会自动回退到 `common`
- 如果你显式写了不支持的值，例如 `fontpreset=desktop` 或 `theme=sunset`，模板会抛出清晰错误并指出合法取值

## TikZ 预设族

模板里的 TikZ 样式不是零散颜色片段，而是按语义整理好的预设族。默认主题切换后，这些样式会自动跟随新的色位，不需要额外改图代码。

当前内置的预设主要包括：

- 神经网络与深度学习：`nn input`、`nn hidden`、`nn output`、`nn tensor`、`nn op`、`nn skip`
- 数学与几何：`math axis`、`math curve`、`math tangent`、`math vector`、`geom point`、`geom angle mark`
- 拓扑与流形：`topo patch`、`topo identify`、`topo geodesic`、`diag object`、`manifold latent`
- 流程图：`flow terminal`、`flow process`、`flow decision`、`flow io`、`flow arrow`
- 时间轴：`timeline axis`、`timeline event`、`timeline milestone`、`timeline span`
- 概率/集合图：`prob universe`、`prob event`、`prob event alt`、`prob condition`、`prob outcome`
- 图论/网络图：`graph node`、`graph node accent`、`graph edge`、`graph edge cut`、`graph walk`

如果你想看完整可编译的组合示例，可以直接参考：

- 文档索引：[`docs/README.md`](./docs/README.md)
- 模板总览：[`docs/template-guide.md`](./docs/template-guide.md)
- 样式测试页：[`tests/test-tikz-styles.tex`](./tests/test-tikz-styles.tex)
- 模板页：[`tikz-template-pages.tex`](./tikz-template-pages.tex)
- 模板册说明：[`docs/tikz-template-pages.md`](./docs/tikz-template-pages.md)

### 模板册新增页面索引

[`tikz-template-pages.tex`](./tikz-template-pages.tex) 现在除了深度学习与拓扑页，也包含一组更偏“课堂讲义/报告结构图”的通用模板页：

- `流程图模板`：适合算法步骤、证明路线、实验流水线
- `时间轴模板`：适合课程安排、项目里程碑、历史脉络
- `概率与条件事件模板`：适合样本空间裁剪、条件概率和集合关系
- `图论与网络结构模板`：适合最短路、最小割、网络流和搜索过程

如果你想按“该用哪组样式、该改哪些元素”来查，而不是直接翻 `.tex` 文件，可以看：

- [`docs/tikz-template-pages.md`](./docs/tikz-template-pages.md)

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

## 图文绕排与页边批注

新版模板支持把图像贴在正文左侧或右侧自动绕排，并把图题或补充说明放到页面外侧边栏。相关接口已经整理到单独文档：

- 详细说明：[`docs/wrapfig-margin-notes.md`](./docs/wrapfig-margin-notes.md)
- 示例展示：[`example.tex`](./example.tex)
- 整合测试：[`tests/test-wrap-layout.tex`](./tests/test-wrap-layout.tex)

常用接口如下：

```tex
\begin{rightfiguretext}{0.36\textwidth}
  \centering
  \includegraphics[width=\linewidth]{figures/demo.pdf}
  \sidecaption{把图题放到页边。}
\end{rightfiguretext}

\sidenote{这里可以放一条无边框页边批注。}
```

还可以配合使用：

- `leftfiguretext` / `rightfiguretext`：左右图文绕排
- `wrapcaption`：图下题注
- `sidecaption` / `sidecaptionof`：页边题注
- `sidenote` / `marginremark`：页边批注

## 仓库结构

```text
.
├── maki-notes.cls
├── maki-notes.sty
├── latexmkrc
├── Makefile
├── docs/
├── document2.tex
├── example.tex
├── tikz-template-pages.tex
├── smoke-packaging.tex
└── tests/
```

关键文件说明：

- `maki-notes.cls`：文档类入口，解析模板级类选项并加载样式包
- `maki-notes.sty`：样式主体，集中管理字体预设、主题色、环境和 TikZ 样式
- `document2.tex`：较完整的讲义模板示例
- `example.tex`：更适合作为二次开发起点的示例文档
- `docs/wrapfig-margin-notes.md`：图文绕排与页边批注用法说明
- `docs/tikz-template-pages.md`：TikZ 模板册结构与新增页面索引
- `tikz-template-pages.tex`：可直接复用的图形模板页
- `tests/`：用于验证模板基础能力的测试文档，其中 `tests/test-basic.tex` 覆盖类选项兼容，`tests/test-wrap-layout.tex` 集中覆盖新版绕排与页边接口

## GitHub Release 流程

仓库中的 release workflow 位于 [`.github/workflows/release.yml`](./.github/workflows/release.yml)，只会在推送 tag 时运行，不会在普通分支 push 时触发。

推荐使用语义化版本 tag，例如：

```sh
git tag v0.1.0
git push origin v0.1.0
```

workflow 会执行以下动作：

- 检出代码
- 用 XeLaTeX 编译示例文档、TikZ 模板页和测试文档
- 打包一份包含 `.tex` 源码、`docs/` 说明和 `tests/` 的源码发行包
- 调用 GitHub Models 生成 release notes
- 创建或更新与当前 tag 对应的 GitHub Release
- 上传编译后的 PDF 和源码包作为 release assets

当前 release 资产包括：

- `maki-notes-<tag>-source.tar.gz`
- `maki-notes-<tag>-manual.pdf`
- `maki-notes-<tag>-example.pdf`
- `maki-notes-<tag>-tikz-templates.pdf`

## GitHub Models 自动化

仓库还提供了 3 个基于 GitHub Models 的自动化 workflow：

- [`.github/workflows/issue-model-comment.yml`](./.github/workflows/issue-model-comment.yml)：在 issue `opened` 或 `edited` 时生成摘要并更新 issue 评论
- [`.github/workflows/pr-model-comment.yml`](./.github/workflows/pr-model-comment.yml)：在 PR `opened`、`reopened`、`ready_for_review` 或 `synchronize` 时生成摘要并更新 PR 评论
- [`.github/workflows/release.yml`](./.github/workflows/release.yml)：在 tag push 时生成 AI release notes

这些 workflow 默认使用 GitHub 自动注入的 `${{ secrets.GITHUB_TOKEN }}`，不需要你手动保存或暴露 token。

对应权限如下：

- issue 评论：`models: read` + `issues: write`
- PR 评论：`models: read` + `pull-requests: write`
- release note 与发布：`models: read` + `contents: write`

当前 workflow 默认模型标识写的是 `openai/gpt-5`。如果你在 GitHub Models 页面看到的实际 slug 不同，需要同步改掉 workflow 里的 `model` 字段。

## 开发建议

- 修改模板能力时，先更新 [`maki-notes.sty`](./maki-notes.sty) 或 [`maki-notes.cls`](./maki-notes.cls)，再运行 `make test`
- 调整字体预设或主题配色时，优先验证 [`tests/test-basic.tex`](./tests/test-basic.tex) 的类选项编译结果
- 新增展示内容时，优先放到 `example.tex` 或 `tikz-template-pages.tex`
- 调整图文绕排与页边批注时，优先同步更新 [`docs/wrapfig-margin-notes.md`](./docs/wrapfig-margin-notes.md) 和 [`tests/test-wrap-layout.tex`](./tests/test-wrap-layout.tex)
- 发布新版本时，只需要推送新的 tag；普通提交不会触发 release workflow
