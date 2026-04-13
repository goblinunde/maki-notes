# 模板总览

`maki-notes` 是一个面向中文数学讲义与课程演示文稿的 LaTeX 模板。它不是“一个通用 `.sty` 包 + 随便搭一个文档类”的松散组合，而是一套配套设计的模板：

- [`maki-beamer.cls`](../maki-beamer.cls) 负责 Beamer 文档类入口、类选项解析和演示文稿装配
- [`maki-notes.cls`](../maki-notes.cls) 负责文档类入口、类选项解析和整体装配
- [`beamerthememaki.sty`](../beamerthememaki.sty) 负责 Beamer 的标题页、目录页、页眉页脚和 block 风格
- [`maki-notes.sty`](../maki-notes.sty) 负责页面、字体、主题色、环境、TikZ 样式、页眉页脚等核心实现

推荐的使用方式是：

```tex
\documentclass[...]{maki-notes}
```

或者：

```tex
\documentclass[...]{maki-beamer}
```

而不是把 `.sty` 单独抽出来当一个轻量通用包使用。

## 适合什么场景

这个模板目前最适合：

- 中文数学讲义
- 中文课程汇报与专题演示文稿
- 带大量示意图的课程笔记
- 需要讲次导读页和章内导航的课程讲义
- 教学型技术说明文档
- 需要统一风格的 LaTeX 模板仓库

它默认假设你接受这些前提：

- 使用 XeLaTeX 编译
- 允许模板接管页面、章节标题、页眉页脚和颜色体系
- 文档主体是讲义，而不是论文投稿模板或极简 article

## 核心入口文件

- [`document2.tex`](../document2.tex)
  更完整的讲义模板，适合看整体风格和页面效果。
- [`example.tex`](../example.tex)
  更适合作为新项目起点，结构较轻。
- [`beamer-demo.tex`](../beamer-demo.tex)
  Beamer 支持的完整示例，适合直接改造成课程汇报。
- [`tikz-template-pages.tex`](../tikz-template-pages.tex)
  图形模板册，适合直接复制结构图。

如果你不知道该从哪个文件开始：

- 想直接写内容：从 `example.tex` 开始
- 想整体了解模板能力：看 `document2.tex`
- 想写演示文稿：看 `beamer-demo.tex`
- 想找图形模板：看 `tikz-template-pages.tex`

## 编译方式

仓库默认通过 [`latexmkrc`](../latexmkrc) 指定 XeLaTeX。常用命令如下：

```sh
make main
make example
make beamer-demo
make tikz-templates
make smoke
make test
make clean
```

对应含义：

- `make main`
  编译 [`document2.tex`](../document2.tex)
- `make example`
  编译 [`example.tex`](../example.tex)
- `make beamer-demo`
  编译 [`beamer-demo.tex`](../beamer-demo.tex)
- `make tikz-templates`
  编译 [`tikz-template-pages.tex`](../tikz-template-pages.tex)
- `make smoke`
  编译最小打包烟雾文档
- `make test`
  编译测试文档，适合改模板后回归验证

## 类选项

模板当前主要开放两类跨 notes / beamer 共享的类选项：

- `fontpreset=common|auto|windows|macos|linux`
- `theme=default|ocean|forest|graphite|amber|berry|sandstone|cobalt|sage|ruby|midnight`

如果你使用的是 `maki-beamer`，还可以额外指定：

- `layout=durham|minimal|splitbar`

最常见写法：

```tex
\documentclass[
  a4paper,
  12pt,
  oneside,
  fontpreset=common,
  theme=default
]{maki-notes}
```

### 字体预设

- `common`
  默认预设，优先使用 TeX Live 自带或稳定可用的字体，跨平台最稳。
- `auto`
  根据当前机器能找到的字体自动选用最接近的平台方案。
- `windows`
  优先常见 Windows 中文字体，缺失时回退到 `common`。
- `macos`
  优先常见 macOS 中文字体，缺失时回退到 `common`。
- `linux`
  优先常见 Linux 中文字体，缺失时回退到 `common`。

当前拉丁正文字体栈会尽量保持和数学字体更一致的气质，避免正文和数学看起来像两套系统。

### 主题预设

- `default`
  当前仓库默认配色。
- `ocean`
  偏蓝青，更轻快。
- `forest`
  偏绿灰，更沉稳。
- `graphite`
  偏墨灰与铜棕，更正式。
- `amber`
  偏琥珀与蓝灰，适合流程图和封面。
- `berry`
  偏莓红与靛灰，层次更明显。
- `sandstone`
  偏砂岩和石板灰，更接近纸面笔记感。
- `cobalt`
  偏钴蓝与青绿，适合科学计算、机器学习和课程汇报。
- `sage`
  偏鼠尾草绿与灰蓝，更稳，更适合推导页较多的内容。
- `ruby`
  偏暗红与蓝灰，适合强调性更强的专题报告。
- `midnight`
  偏深蓝灰与冷色强调，适合正式汇报和结构图页。

这些主题不会改变公开接口，只会改写语义色位。所以你现有的盒子环境、TikZ 图和页边批注在换主题后都会一起换色。

### Beamer 版式

- `durham`
  默认版式，延续 `beamer-example/` 参考设计的标题页和导航逻辑。
- `minimal`
  更克制，弱化装饰条，更强调正文内容。
- `splitbar`
  更强调导航条和分栏式信息组织，适合教学型汇报。

推荐把接口理解成两层：`theme=` 负责共享配色，`layout=` 负责 Beamer 版式。

### 错误与回退

- 指定平台字体预设但系统缺少相关字体时，会自动回退到 `common`
- 显式写错值时会报清晰错误，而不是静默退化

## 公开能力概览

模板当前最重要的公开能力可以分成 6 类：

### 1. 文档结构和讲义环境

- 封面、目录、章节标题
- 定义、定理、例题、真题、注释等盒子环境
- 页眉页脚和统一色彩层级

### 2. 数学讲义工作流层

- `\SetCourseInfo{...}`：课程、学期、对象、讲次、日期等元信息
- `\SetChapterInfo{...}`：当前章的副标题、关键词、先修要求、学习目标
- `\MakeChapterGuide{...}`：生成整页章节导读
- 当前章局部导航：在导读页里展示本章 `section`
- `keyformula`、`pitfall`、`methodnote`、`examfocus`：数学讲义专用信息块

这部分单独文档见：

- [`workflow-guide.md`](./workflow-guide.md)

### 3. 图文绕排与页边批注

- 左图右文、右图左文的自动绕排
- 图下题注与页边侧题注
- 无边框页边批注

这部分单独文档见：

- [`wrapfig-margin-notes.md`](./wrapfig-margin-notes.md)

### 4. TikZ 语义样式族

模板里的 TikZ 不是“每张图重新手写颜色”，而是有一层统一的语义样式：

- 深度学习
- 数学/几何
- 三维球面
- 拓扑/流形
- 交换图
- 傅里叶/信号图
- 流程图
- 时间轴
- 概率/集合图
- 图论/网络图

这部分单独文档见：

- [`tikz-template-pages.md`](./tikz-template-pages.md)

### 5. Beamer 演示文稿入口

- `maki-beamer.cls`：基于 `ctexbeamer` 的演示文稿入口
- `beamerthememaki.sty`：参考 `beamer-example/` 设计的 title page、outline、headline、footline
- `maki-beamer` 公开 `layout=durham|minimal|splitbar`，把版式层和共享配色层分开了
- `\MakeTitlePage`、`\makeoutline[标题]`：稳定入口
- 继续复用 `keyformula`、`methodnote`、`pitfall`、`examfocus`
- 继续复用 Transformer / PINN / fPINN 等 TikZ 语义样式

这部分单独文档见：

- [`beamer-guide.md`](./beamer-guide.md)

### 6. GitHub 自动化

仓库已经配置了 tag push 才触发的 release workflow，以及若干 GitHub Models 自动化流程。

如果你只是日常写讲义，不需要看这部分；如果你维护模板仓库并准备发布版本，需要知道：

- 普通 `push` 不触发 release
- 推送 tag 才会编译 PDF、打包源码、生成 release notes

## 推荐工作流

### 作为讲义作者

1. 从 [`example.tex`](../example.tex) 开始写内容  
2. 需要课程元信息、章节导读或本章导航时看 [`workflow-guide.md`](./workflow-guide.md)  
3. 需要汇报版课件时看 [`beamer-guide.md`](./beamer-guide.md) 和 [`beamer-demo.tex`](../beamer-demo.tex)  
4. 需要插图绕排时看 [`wrapfig-margin-notes.md`](./wrapfig-margin-notes.md)  
5. 需要结构图时从 [`tikz-template-pages.tex`](../tikz-template-pages.tex) 复制  
6. 改完后用 `make example`、`make beamer-demo` 或 `make main` 检查输出

### 作为模板维护者

1. 改 `.cls` / `.sty` 前先确认用户可见接口是否变化  
2. 改文档结构、颜色或字体后，先跑 `make test`  
3. 新增图形样式时，同步更新模板册和对应文档  
4. 调整 Beamer 支持时，同步更新 [`beamer-guide.md`](./beamer-guide.md) 与 [`tests/test-beamer.tex`](../tests/test-beamer.tex)
5. 发布时推送 tag，让 workflow 自动构建 release

## 相关文档

- 文档索引：[`README.md`](./README.md)
- Beamer 支持：[`beamer-guide.md`](./beamer-guide.md)
- 图文绕排与页边批注：[`wrapfig-margin-notes.md`](./wrapfig-margin-notes.md)
- TikZ 模板册说明：[`tikz-template-pages.md`](./tikz-template-pages.md)
