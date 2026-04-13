# 文档索引

`docs/` 目录用于放用户视角的模板说明，而不是开发过程里的实现草稿。这里的文档重点回答 5 类问题：

- 这个模板整体怎么用
- 类选项、主题和字体预设怎么选
- 课程元信息、章节导读和本章导航怎么写
- 研究笔记、开放问题和符号表怎么整理
- 演示文稿怎么和讲义共享一套设计层
- 图文绕排、页边批注怎么排
- TikZ 模板页和预设样式怎么复用

如果你第一次接触 `maki-notes`，推荐按下面顺序阅读。

## 推荐阅读顺序

### 1. 模板总览

- 文件：[`template-guide.md`](./template-guide.md)
- 适合：第一次上手、准备基于本仓库写讲义或改模板的人
- 内容：模板结构、编译方式、类选项、主题/字体预设、主要入口文件、构建与发布约定

### 2. 数学讲义工作流导读

- 文件：[`workflow-guide.md`](./workflow-guide.md)
- 适合：想把模板从“排版模板”用成“课程讲义工作台”的人
- 内容：课程元信息、章节导读页、本章导航、核心公式/误区/方法/考试关注块

### 3. 研究写作工作台

- 文件：[`research-writing-guide.md`](./research-writing-guide.md)
- 适合：想把模板用于长期研究笔记、读论文摘录、开放问题整理和符号表维护的人
- 内容：研究元信息、条目导引、研究语义环境、符号表、开放问题表以及与正式论文类的边界

### 4. Beamer 课件支持

- 文件：[`beamer-guide.md`](./beamer-guide.md)
- 适合：想在当前仓库上直接写课程汇报、专题报告或答辩式课件的人
- 内容：`maki-beamer.cls` 的接口、`layout=` 版式选择、与 `maki-notes.sty` 的共享关系、可复用内容块、与书式讲义的差异

### 5. 图文绕排与页边批注

- 文件：[`wrapfig-margin-notes.md`](./wrapfig-margin-notes.md)
- 适合：正文中需要插图绕排、侧题注、页边批注的人
- 内容：接口说明、推荐用法、图题选择、页边批注策略、常见排版注意事项

### 6. TikZ 模板册与源码手册

- 文件：[`tikz-template-pages.md`](./tikz-template-pages.md)
- 适合：需要直接复用结构图、球面/流形图、交换图、傅里叶图、流程图、时间轴、概率图、图论图的人
- 内容：模板册结构、各页面用途、修改策略、与主题配色的关系、验证入口，以及 [`tikz-example.tex`](../tikz-example.tex) 这份“源码 + 渲染”查阅手册的定位

## 文档与源码的对应关系

- Beamer 入口：[`maki-beamer.cls`](../maki-beamer.cls)
- 模板入口：[`maki-notes.cls`](../maki-notes.cls)
- Beamer 主题：[`beamerthememaki.sty`](../beamerthememaki.sty)
- 模板实现：[`maki-notes.sty`](../maki-notes.sty)
- Beamer 示例：[`beamer-demo.tex`](../beamer-demo.tex)
- 主示例：[`document2.tex`](../document2.tex)
- 简化示例：[`example.tex`](../example.tex)
- TikZ 模板册：[`tikz-template-pages.tex`](../tikz-template-pages.tex)
- TikZ 源码手册：[`tikz-example.tex`](../tikz-example.tex)
- 测试文档：[`tests/`](../tests)

## 当你要做不同类型的修改时

- 改字体或配色预设：先看 [`template-guide.md`](./template-guide.md)
- 改课程元信息、章节导读或本章导航：先看 [`workflow-guide.md`](./workflow-guide.md)
- 改研究元信息、条目导引、符号表或开放问题表：先看 [`research-writing-guide.md`](./research-writing-guide.md)
- 改 Beamer 的 `layout=` 版式或共享 `theme=` 配色：先看 [`beamer-guide.md`](./beamer-guide.md) 与 [`template-guide.md`](./template-guide.md)
- 改图文绕排、侧题注或页边批注：先看 [`wrapfig-margin-notes.md`](./wrapfig-margin-notes.md)
- 改 TikZ 结构图或新增模板页：先看 [`tikz-template-pages.md`](./tikz-template-pages.md)
- 按样式名查源码和最小可复制图例：先看 [`tikz-example.tex`](../tikz-example.tex)
- 验证样式没有被改坏：优先运行 `make test`

## 维护约定

- 用户可见的新功能，优先补到 `docs/`
- 只改公开接口时，至少同步更新对应的专项文档
- 如果新增了新的模板页或新的样式族，除了更新 `README.md`，也要同步更新 [`tikz-template-pages.md`](./tikz-template-pages.md)
- 如果新增了可公开复用的 TikZ 语义样式，也建议同步补到 [`tikz-example.tex`](../tikz-example.tex)
