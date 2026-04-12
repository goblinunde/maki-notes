# 图文绕排与页边批注

`maki-notes` 现在提供一组轻量的图文绕排与页边批注接口，适合在数学讲义里处理“图不想独占一整行，但又需要和正文紧密联动”的场景。

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

## 使用注意

- `wrapfig` 对分页和连续绕排块比较敏感；如果两个绕排块靠得太近，可以在中间插入普通段落，必要时用 `\clearpage`
- 图宽通常控制在 `0.32\textwidth` 到 `0.40\textwidth` 更稳妥
- 绕排块前后最好都有完整段落，避免紧贴章节标题或列表环境开头
- 如果图形高度变化很大，可以显式传入 `[<行数>]` 来微调绕排效果

## 参考文件

- 示例文档：[`example.tex`](../example.tex)
- 整合测试：[`tests/test-wrap-layout.tex`](../tests/test-wrap-layout.tex)
- 样式实现：[`maki-notes.sty`](../maki-notes.sty)
