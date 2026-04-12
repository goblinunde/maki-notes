# TikZ 模板册说明

[`tikz-template-pages.tex`](../tikz-template-pages.tex) 是仓库里的 TikZ 模板册入口，定位不是测试，而是“可以直接复制改写”的成品页集合。

它适合两类使用方式：

- 从中挑一页，直接复制到讲义、论文附录或技术报告里
- 先保留语义样式名，只替换节点文字、层数、尺寸和说明框

它和 [`tests/test-tikz-styles.tex`](../tests/test-tikz-styles.tex) 的定位不同：

- `tikz-template-pages.tex`
  偏模板册，强调“拿来就改”
- `tests/test-tikz-styles.tex`
  偏回归验证，强调“样式 key 仍然可编译”

## 当前模板册结构

- 深度学习模板页
  包含 `Transformer`、`CNN`、`ResNet` 三类结构图
- 数学与拓扑模板页
  包含交换图、流形/潜空间示意、基本域到环面
- 通用讲义图形模板页
  包含流程图、时间轴、条件事件/概率图、图论与网络结构图

## 使用方式

### 方式一：直接复制整页结构

最稳妥的方式是从模板册里复制整张 `tikzpicture`，然后只改：

- 节点文字
- 节点数量
- 个别坐标
- 注释框内容

这种方式最适合第一次改图，因为样式名、连线类型和颜色语义都已经是稳定的。

### 方式二：只复用语义样式

如果你已经有自己的 TikZ 结构，只想复用本模板的风格，可以直接用样式名，例如：

```tex
\begin{tikzpicture}
  \node[flow process] (a) at (0,0) {步骤 A};
  \node[flow decision] (b) at (2.8,0) {是否继续?};
  \draw[flow arrow] (a) -- (b);
\end{tikzpicture}
```

这样做的好处是：

- 换 `theme=` 时，整张图会自动跟着变
- 不需要在图里写死颜色
- 不需要每张图重复定义节点样式

## 新增页面索引

### 流程图模板

- 文件位置：[`tikz-template-pages.tex`](../tikz-template-pages.tex)
- 模板入口：`流程图模板`
- 主要样式：`flow terminal`、`flow process`、`flow decision`、`flow io`、`flow arrow`
- 适合内容：算法步骤、证明路线、实验流水线、处理链路
- 修改时优先调整：节点顺序、分支数、注释框文案
- 不建议先改：节点颜色和箭头线型，因为这些已经被主题语义接管

### 时间轴模板

- 文件位置：[`tikz-template-pages.tex`](../tikz-template-pages.tex)
- 模板入口：`时间轴模板`
- 主要样式：`timeline axis`、`timeline event`、`timeline milestone`、`timeline span`
- 适合内容：课程安排、项目里程碑、版本演化、历史脉络
- 修改时优先调整：刻度标签、阶段跨度、里程碑文案
- 常见替换方式：周次改成章节、年份改成版本号、圆点改成关键提交节点

### 概率与条件事件模板

- 文件位置：[`tikz-template-pages.tex`](../tikz-template-pages.tex)
- 模板入口：`概率与条件事件模板`
- 主要样式：`prob universe`、`prob event`、`prob event alt`、`prob condition`、`prob outcome`
- 适合内容：样本空间裁剪、条件概率、集合关系、过滤过程
- 修改时优先调整：区域位置、标签、条件边界、样本点分布
- 适合教学场景：条件概率、事件互斥、观测后样本空间更新

### 图论与网络结构模板

- 文件位置：[`tikz-template-pages.tex`](../tikz-template-pages.tex)
- 模板入口：`图论与网络结构模板`
- 主要样式：`graph node`、`graph node accent`、`graph edge`、`graph edge cut`、`graph walk`
- 适合内容：最短路、最小割、网络流、图搜索、关系结构图
- 修改时优先调整：节点位置、边权、强调路径、搜索轨迹
- 适合同一张图承载两层信息：静态结构 + 算法过程

## 主题与模板册的关系

模板册里的图不会手写某个固定主题的颜色，它们依赖 [`maki-notes.sty`](../maki-notes.sty) 里的语义色位。

这意味着：

- 改 `theme=default` 到 `theme=forest`，模板页会整体换色
- 不需要逐个改节点颜色
- 同一个图结构可以在不同课程或文档里共用

如果你要试主题效果，最简单的办法是直接改：

```tex
\documentclass[a4paper,12pt,oneside,theme=graphite]{maki-notes}
```

## 修改策略

### 最推荐的改法

1. 先复制模板页中的整张图  
2. 先改标签和说明框  
3. 再改节点数量和相对位置  
4. 最后才改尺寸、缩放或版面布局

### 不推荐的改法

- 一开始就把所有坐标打散重写
- 在每张图里单独写颜色
- 把语义样式换成一次性临时参数

这些做法短期看灵活，长期会让图之间越来越不像同一套模板。

## 从模板册到正式文档时建议保留什么

- 样式名
- 节点命名
- 语义化注释框
- 主要布局关系

可以自由修改的通常是：

- 标签文案
- 图尺寸
- 局部坐标
- 是否保留某条支路或某类说明

## 验证与维护

如果你新增了新的语义样式族或改了现有样式，建议同步检查：

- [`tikz-template-pages.tex`](../tikz-template-pages.tex)
  模板册仍然适合复制使用
- [`tests/test-tikz-styles.tex`](../tests/test-tikz-styles.tex)
  样式 key 仍然能编译
- [`README.md`](../README.md)
  样式族列表和模板册索引仍然准确

## 使用建议

- 优先保留样式名，先改文字和节点位置，再改颜色或线型
- 如果只是换主题，优先通过 `\documentclass[...,theme=...]{maki-notes}` 切换，不要在图里手写颜色
- 如果要验证某组样式是否仍可编译，先看 [`tests/test-tikz-styles.tex`](../tests/test-tikz-styles.tex)
- 如果要发布模板册，直接执行 `make tikz-templates`

## 相关文件

- 文档索引：[`README.md`](./README.md)
- 模板总览：[`template-guide.md`](./template-guide.md)
- 模板册源码：[`tikz-template-pages.tex`](../tikz-template-pages.tex)
- 样式测试：[`tests/test-tikz-styles.tex`](../tests/test-tikz-styles.tex)
- 样式实现：[`maki-notes.sty`](../maki-notes.sty)
