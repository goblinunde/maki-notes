# Beamer 支持

这一页集中说明 `maki-beamer.cls` 的定位、接口和与 `maki-notes` 主模板的关系。

## 关系

`maki-notes` 现在不是只有一本“讲义类”文档类, 而是两套入口共享同一层样式资源：

- [`maki-notes.cls`](../maki-notes.cls)
  适合书式讲义、课程笔记、章节导读页和章内导航。
- [`maki-beamer.cls`](../maki-beamer.cls)
  适合课堂汇报、专题报告、答辩式课程展示。
- [`maki-notes.sty`](../maki-notes.sty)
  负责字体预设、主题色、数学命令、内容块和 TikZ 语义样式。
- [`beamerthememaki.sty`](../beamerthememaki.sty)
  负责 Beamer 的 title page、outline、headline、footline 和 block 外观。

也就是说, `maki-beamer` 不是一套单独维护的第二份模板, 而是建立在 `maki-notes.sty` 之上的演示文稿入口。

## 设计来源

这套 Beamer 主题参考了仓库中的 [`beamer-example/`](../beamer-example) 设计, 尤其是 Durham 风格的 title page、outline page 和顶部导航思路；但最终实现改成了 `maki-notes` 自己的语义色位, 因此会自动跟随 `theme=...` 切换。

## 快速开始

```tex
\documentclass[
  aspectratio=169,
  fontpreset=common,
  theme=graphite
]{maki-beamer}

\title{科学机器学习讲义}
\subtitle{Transformer, PINN 与共享样式层}
\author{Maki Notes Demo}
\institute{maki-beamer / maki-notes}
\date{2026-04-13}

\begin{document}
\MakeTitlePage
\makeoutline[本次内容]

\section{引言}
\begin{frame}{共享样式}
  \begin{keyformula}
    \[
      \mathcal L = \mathcal L_r + \mathcal L_b + \mathcal L_i
    \]
  \end{keyformula}
\end{frame}
\end{document}
```

完整示例见：

- [`beamer-demo.tex`](../beamer-demo.tex)
- [`tests/test-beamer.tex`](../tests/test-beamer.tex)

## 类选项

### 与 `maki-notes` 共享的选项

- `fontpreset=common|auto|windows|macos|linux`
- `theme=default|ocean|forest|graphite|amber|berry|sandstone`

这两类选项仍然由 [`maki-notes.sty`](../maki-notes.sty) 解释, 所以讲义与课件会共享同一套字体策略与语义色位。

### `maki-beamer` 额外支持的选项

- `plain`
  关闭主题页眉和页脚。
- `invert`
  使用反相深色画布。
- `accessibility`
  用更接近黑白高对比的方案替代主题色。

除此之外, 其他常规 Beamer 选项会继续透传给 `ctexbeamer`, 例如：

- `aspectratio=169`
- `11pt`
- `handout`

## 推荐接口

### 标题与目录

- `\MakeTitlePage`
  生成标题页。它是 `\maketitle` 的稳定包装。
- `\makeoutline[标题]`
  生成目录页。可选参数默认是“目录”。

### 内容层

在 Beamer 里, 建议继续使用原生的演示文稿结构：

- `\section`
- `\subsection`
- `frame`
- `block`
- `alertblock`
- `exampleblock`
- `definition`
- `theorem`
- `example`
- `proof`

同时, 下列 `maki-notes` 内容块可以直接复用：

- `keyformula`
- `methodnote`
- `pitfall`
- `examfocus`

### 图形层

Beamer 与讲义会共享 `maki-notes.sty` 里的 TikZ 语义样式, 例如：

- `transformer ...`
- `pinn ...`
- `fpinn ...`
- `nn ...`
- `maki annotation`

这意味着课程讲义中的结构图可以直接搬到课件里, 不需要再写第二版颜色和节点样式。

## 与书式讲义的差异

下面这些接口或行为是 notes 模式专属, 不建议在 Beamer 中继续使用：

- `\chapter`
- `\SetChapterInfo`
- `\MakeChapterGuide`
- 图文绕排与页边批注工作流
- 依赖 `chapter` 的编号策略

在 Beamer 模式下：

- `\MakeChapterGuide` 会被安全忽略并给出警告
- 原来为书式讲义定义的彩色 `theorem` / `definition` / `example` 盒子不再覆盖 Beamer 原生环境
- 数学讲义工作流块仍可单独使用

这是刻意做的隔离：书式讲义和演示文稿的导航逻辑不同, 不应该强行共用同一套章节页面机制。

## 编译与验证

常用命令：

```sh
make beamer-demo
make test
```

如果你只想单独检查 Beamer 支持：

```sh
latexmk -pdf -interaction=nonstopmode -file-line-error beamer-demo.tex
latexmk -pdf -interaction=nonstopmode -file-line-error tests/test-beamer.tex
```
