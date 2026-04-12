# 图文绕排与页边批注

`maki-notes` 现在提供一组轻量的图文绕排与页边批注接口，适合在数学讲义里处理“图不想独占一整行，但又需要和正文紧密联动”的场景。

这套接口的目标不是取代普通浮动体，而是解决下面这类版面问题：

- 图很小，但如果单独占一整行会打断阅读节奏
- 正文正在解释某张图，希望读者边看图边看文字
- 图题说明较长，不想压缩图本体高度
- 某条提醒只想放在页边，而不想挤进正文主叙事层

这组接口延续了模板现有的视觉语言：

- 正文仍然是主叙事层
- 图可以贴左侧或右侧并自动绕排
- 图题既可以放在图下，也可以放到页边
- 页边批注不使用完整方框，只保留细色线、小字号和少量留白

## 可用接口

- `leftfiguretext[<行数>]{<宽度>}`
  左图右文的绕排环境。
- `rightfiguretext[<行数>]{<宽度>}`
  右图左文的绕排环境。
- `wrapcaption{...}`
  在绕排图形下方放普通图题。
- `sidecaption{...}`
  把图题放到页边。
- `sidecaptionof{<type>}{...}`
  给任意计数器类型生成页边题注，例如 `table`。
- `sidenote{...}`
  无标题页边批注。
- `marginremark[标题]{...}`
  带可选标题的页边批注。

其中可选参数 `<行数>` 会直接传给 `wrapfig`，用于手动指定绕排行数。默认情况下可以省略；如果图较高、正文较短，或连续放置多个绕排块时，再按需要显式补上。

## 先选哪一种版式

如果你不确定该用哪组接口，可以按这个规则判断：

- 图是正文解释的一部分，而且宽度不大
  优先用 `leftfiguretext` 或 `rightfiguretext`
- 图题只是编号和短说明
  优先用 `wrapcaption`
- 图题更像补充解释、提醒或旁白
  优先用 `sidecaption`
- 只是想插一条边上的短说明，不需要图
  用 `sidenote` 或 `marginremark`

## 宽度与绕排行数的经验值

这组接口底层仍然依赖 `wrapfig`，所以版面是否稳定和图宽、图高有直接关系。常见经验如下：

- `0.32\textwidth` 到 `0.36\textwidth`
  最稳，适合大多数讲义插图。
- `0.36\textwidth` 到 `0.40\textwidth`
  适合稍复杂的图，但要保证旁边正文足够连续。
- 超过 `0.40\textwidth`
  往往不如改成普通整行图。

如果图比较高，可以显式写行数，例如：

```tex
\begin{rightfiguretext}[14]{0.38\textwidth}
  ...
\end{rightfiguretext}
```

这样 `wrapfig` 在分页时更容易保持稳定。

## 右图左文

```tex
\begin{rightfiguretext}{0.36\textwidth}
  \centering
  \includegraphics[width=\linewidth]{figures/conditional-probability.pdf}
  \sidecaption{图题放到页边，适合提示性较强的说明。}
\end{rightfiguretext}

这一段正文会自动绕排到图的左侧。
\sidenote{这里可以补一条很短的旁注。}
```

这种布局适合：

- 条件概率与集合裁剪
- 几何构型示意
- 局部流程图、网络拓扑图
- 正文需要边看图边解释的讲义段落

## 左图右文

```tex
\begin{leftfiguretext}{0.34\textwidth}
  \centering
  \begin{tikzpicture}
    % 你的图形代码
  \end{tikzpicture}
  \wrapcaption{图题保留在图下，维持传统阅读习惯。}
\end{leftfiguretext}

这一段正文会自动绕排到图的右侧。
\marginremark[提示]{页边批注适合放补充提醒，而不是主结论。}
```

这种布局通常适合小节起始处，图先进入视野，正文从右侧展开，阅读节奏会更自然。

## 常见组合

### 绕排图 + 页边题注

适合“图本身不大，但解释性文字稍长”的情况：

```tex
\begin{rightfiguretext}{0.35\textwidth}
  \centering
  \begin{tikzpicture}
    % 图形主体
  \end{tikzpicture}
  \sidecaption{把补充说明移到页边，避免图下说明过长。}
\end{rightfiguretext}
```

### 绕排图 + 图下题注 + 页边批注

适合“图题保留标准形式，但还想放一条教学提醒”的情况：

```tex
\begin{leftfiguretext}{0.34\textwidth}
  \centering
  \includegraphics[width=\linewidth]{figures/demo.pdf}
  \wrapcaption{标准图题。}
\end{leftfiguretext}

\marginremark[提醒]{这里的阴影区域不是补集。}
```

### 只有页边批注

适合正文中的短提醒、局部定义说明或阅读指引：

```tex
\sidenote{这里只讨论事件已经被观测到之后的样本空间。}
```

## 图下题注与侧题注怎么选

- `\wrapcaption{...}` 适合简短、标准的图题
- `\sidecaption{...}` 适合稍长的说明性图题，尤其适合不想压缩图形高度时
- `\sidecaptionof{table}{...}` 可以把表题也移到页边，但建议只用于较小的表

如果图题已经承担了大量解释任务，优先放页边；如果图题只是标记对象和编号，放图下更稳妥。

## 页边批注的建议用法

- 放简短提醒，例如“这里只观察事件 A 已发生后的样本空间”
- 放阅读提示，例如“不要把阴影区域误看成补集”
- 放旁支说明，而不是主定理、主结论或长段证明

不建议把页边批注写得过长。超过数行后，建议改回正文、脚注，或单独用盒子环境承载。

## 常见排版问题

### 1. 图和下一段正文发生碰撞

常见原因：

- 两个绕排块挨得太近
- 图过高，但正文不足以包住它
- 紧贴章节标题或列表环境开始位置

处理方式：

- 在两个绕排块之间插入普通段落
- 显式增加 `[<行数>]`
- 必要时用 `\clearpage`

### 2. 页边批注太长，视觉上抢戏

页边批注的定位是“旁白层”，不是第二正文层。过长时建议：

- 改写成更短的提醒
- 挪回正文
- 改成定义/注释盒子环境

### 3. 图太宽，导致正文列过窄

如果图已经接近半栏宽，绕排往往得不偿失。这个时候更建议：

- 改成整行图
- 用普通 `figure` 或单独居中图

## 推荐工作流

1. 先决定图是否真的需要绕排，而不是默认所有小图都绕排  
2. 先选 `leftfiguretext` 或 `rightfiguretext`  
3. 再决定图题放图下还是页边  
4. 最后才微调 `[<行数>]` 和宽度  
5. 改完后对照 [`tests/test-wrap-layout.tex`](../tests/test-wrap-layout.tex) 的做法检查版面

## 使用注意

- `wrapfig` 对分页和连续绕排块比较敏感；如果两个绕排块靠得太近，可以在中间插入普通段落，必要时用 `\clearpage`
- 图宽通常控制在 `0.32\textwidth` 到 `0.40\textwidth` 更稳妥
- 绕排块前后最好都有完整段落，避免紧贴章节标题或列表环境开头
- 如果图形高度变化很大，可以显式传入 `[<行数>]` 来微调绕排效果

## 参考文件

- 示例文档：[`example.tex`](../example.tex)
- 整合测试：[`tests/test-wrap-layout.tex`](../tests/test-wrap-layout.tex)
- 样式实现：[`maki-notes.sty`](../maki-notes.sty)
