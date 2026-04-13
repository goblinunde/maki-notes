# TikZ 模板册说明

[`tikz-template-pages.tex`](../tikz-template-pages.tex) 是仓库里的 TikZ 模板册入口，定位不是测试，而是“可以直接复制改写”的成品页集合。

如果你要找的是“某个样式名到底怎么写、最小可复制代码长什么样、渲染出来是什么样”，请直接看配套的 [`tikz-example.tex`](../tikz-example.tex)。它和模板册不是竞争关系，而是两个互补入口：

- `tikz-template-pages.tex`
  偏成品页，强调“拿来就改”
- `tikz-example.tex`
  偏源码手册，强调“按样式名查源码 + 看实际渲染”

它适合两类使用方式：

- 从中挑一页，直接复制到讲义、论文附录或技术报告里
- 先保留语义样式名，只替换节点文字、层数、尺寸和说明框

它和 [`tests/test-tikz-styles.tex`](../tests/test-tikz-styles.tex) 的定位也不同：

- `tikz-template-pages.tex`
  偏模板册，强调“拿来就改”
- `tikz-example.tex`
  偏源码手册，强调“当前公开样式都要有示例”
- `tests/test-tikz-styles.tex`
  偏回归验证，强调“样式 key 仍然可编译”

## 当前模板册结构

- 深度学习模板页
  包含 `Transformer`、`CNN`、`ResNet`、`PINN`、`fPINN` 五类结构图
- 数学与拓扑模板页
  包含交换图、pullback、球面、局部流形图、流形/潜空间示意、傅里叶变换、基本域到环面
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

### Transformer 编码器模板

- 文件位置：[`tikz-template-pages.tex`](../tikz-template-pages.tex)
- 模板入口：`Transformer 编码器模板`
- 主要样式：`transformer token`、`transformer pos`、`transformer attention block`、`transformer norm`、`transformer ffn`、`transformer residual`
- 适合内容：自注意力结构、编码器块、层归一化与残差连接
- 修改时优先调整：token 数量、block 文案、头数示意、输出记忆块数量
- 建议写法：把结构角色写进样式名, 不要再用一组临时矩形同时扮演 token、attention 和 norm

### PINN 结构模板

- 文件位置：[`tikz-template-pages.tex`](../tikz-template-pages.tex)
- 模板入口：`PINN 结构模板`
- 主要样式：`pinn domain`、`pinn coordinate`、`pinn field`、`pinn physics`、`pinn boundary`、`pinn initial`、`pinn total`
- 适合内容：Physics-Informed Neural Network、PDE 约束训练、边界/初值损失拆分
- 修改时优先调整：采样域大小、损失分支数、PDE 文案、是否保留观测数据分支
- 适合教学场景：科学机器学习、偏微分方程数值解、逆问题与参数识别

### fPINN 结构模板

- 文件位置：[`tikz-template-pages.tex`](../tikz-template-pages.tex)
- 模板入口：`fPINN 结构模板`
- 主要样式：`fpinn operator`、`fpinn quadrature`、`fpinn stencil`、`fpinn memory`、`fpinn branch`、`fpinn history`
- 适合内容：fractional PINN、分数阶扩散、带记忆核或非局部算子的 PINN 结构
- 修改时优先调整：非局部分支数量、历史积分节点、离散模板说明、损失汇总位置
- 说明：这里默认把 `fPINN` 解释为 fractional PINN
- 推荐做法：把“非局部物理分支”单独框出来, 这样后续换成 Caputo、Riesz 或 G-L 离散时不用重排整张图

### 交换图与 pullback 模板

- 文件位置：[`tikz-template-pages.tex`](../tikz-template-pages.tex)
- 模板入口：`交换图与 pullback 模板`
- 主要样式：`diag object accent`、`diag object muted`、`diag morphism natural`、`diag morphism curve`、`diag 2cell`
- 适合内容：pullback、pushout、自然变换、泛性质草图
- 修改时优先调整：对象名、箭头标签、强调对象和二维单元位置
- 适合的写法：把“核心对象”放进 `diag object accent`，把背景范畴或环境对象放进 `diag object muted`

### 三维球面与切平面模板

- 文件位置：[`tikz-template-pages.tex`](../tikz-template-pages.tex)
- 模板入口：`三维球面与切平面模板`
- 主要样式：`sphere shell`、`sphere hidden`、`sphere equator`、`sphere latitude`、`sphere tangent plane`、`sphere vector`
- 适合内容：球面局部几何、经纬线、法向/径向向量、切平面示意
- 修改时优先调整：球半径、点位置、切平面朝向、标注文字
- 适合教学场景：微分几何导入、向量分析、球坐标和曲面上的局部线性化

### 局部流形图与坐标图模板

- 文件位置：[`tikz-template-pages.tex`](../tikz-template-pages.tex)
- 模板入口：`局部流形图与坐标图模板`
- 主要样式：`manifold patch`、`manifold geodesic`、`manifold tangent`、`manifold chart`、`manifold point`、`manifold map accent`
- 适合内容：局部 chart、测地线、切平面、流形上的点与坐标映射
- 修改时优先调整：patch 外形、局部图位置、测地线路径、映射标签
- 和 `流形与潜空间示意模板` 的区别：这一页偏微分几何, 后者偏机器学习里的 manifold hypothesis

### 傅里叶变换模板

- 文件位置：[`tikz-template-pages.tex`](../tikz-template-pages.tex)
- 模板入口：`傅里叶变换模板`
- 主要样式：`fourier axis`、`fourier signal`、`fourier spectrum`、`fourier guide`、`fourier marker`、`fourier window`
- 适合内容：时域/频域并排示意、矩形窗与 sinc 谱、信号处理导论
- 修改时优先调整：时域波形、频域函数、关键频率标记、变换箭头文案
- 常见改法：把矩形窗换成高斯、余弦包络、离散脉冲列，保留左右并排结构不变

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

### 方式三：先在源码手册里查单个样式

如果你不是要整页复制，而是只想确认某个样式：

- 名字是什么
- 最小例子怎么写
- 渲染后的观感如何

那就先打开 [`tikz-example.tex`](../tikz-example.tex)。

它适合这几类工作流：

- 我知道自己要 `transformer cross block`，但忘了最小写法
- 我想看 `pinn loss` / `fpinn branch` / `flow node` 这些新增样式分别长什么样
- 我准备继续扩展 `.sty`，需要一份“源码 + 渲染”式的回归手册

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
- 如果要编译源码手册，直接执行 `make tikz-example`

## 相关文件

- 文档索引：[`README.md`](./README.md)
- 模板总览：[`template-guide.md`](./template-guide.md)
- 模板册源码：[`tikz-template-pages.tex`](../tikz-template-pages.tex)
- 源码手册：[`tikz-example.tex`](../tikz-example.tex)
- 样式测试：[`tests/test-tikz-styles.tex`](../tests/test-tikz-styles.tex)
- 样式实现：[`maki-notes.sty`](../maki-notes.sty)
