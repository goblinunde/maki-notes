# 数学讲义工作流导读

这一页集中说明 `maki-notes` 新增的“讲义写作工作流层”。它解决的不是基础排版，而是这些更接近真实备课与写讲义的需求：

- 在封面之外统一管理课程、讲次、日期等元信息
- 在总目录之外，为每章增加独立的整页导读
- 自动生成当前章的局部导航
- 用更贴合数学讲义语境的块来写“核心公式”“常见误区”“方法提要”“考试关注”

## 推荐使用顺序

每一章最推荐的写法是：

```tex
\SetCourseInfo{
  course={高等数学},
  term={2026 春},
  audience={考研数学},
  instructor={Maki},
  lecture={第 3 讲},
  date={2026-04-13}
}

\SetChapterInfo{
  subtitle={从定义到连续性},
  lecture={第 1 讲},
  date={2026-04-13},
  keywords={极限, 连续, 夹逼准则},
  prereq={函数与实数基础},
  goals={理解极限定义; 会判断连续性; 会使用夹逼准则}
}

\chapter{极限与连续}
\MakeChapterGuide{
  route={定义 -> 性质 -> 计算 -> 连续},
  formulas={
    \[
      \lim_{x \to x_0} f(x) = A
    \]
  },
  pitfalls={连续不必可导; 去心邻域条件不能漏写},
  methods={夹逼, 等价无穷小, 代数变形},
  examfocus={极限定义判断题, 连续性与分段函数}
}
```

## 1. 课程元信息

命令：

```tex
\SetCourseInfo{...}
```

支持的键：

- `course`
- `term`
- `audience`
- `instructor`
- `lecture`
- `date`

这些字段会进入：

- 章节导读页顶部信息
- 页眉中的课程名 / 讲次 / 日期

如果你不写 `\SetCourseInfo`，旧文档仍然可以继续使用 `\LectureNotesTitle` 和 `\AuthorInfo`。

## 2. 章节元信息

命令：

```tex
\SetChapterInfo{...}
```

支持的键：

- `subtitle`
- `lecture`
- `date`
- `keywords`
- `prereq`
- `goals`

使用约定：

- `\SetChapterInfo` 作用于“下一个 `\chapter`”
- 章节级 `lecture`、`date` 会覆盖课程级同名字段
- 如果下一章不再调用 `\SetChapterInfo`，上一章的专属信息不会泄漏过去

## 3. 章节导读页

命令：

```tex
\MakeChapterGuide{...}
```

支持的键：

- `route`
- `formulas`
- `pitfalls`
- `methods`
- `examfocus`

导读页默认会渲染这些区域：

- 章号与章标题
- 副标题
- 课程 / 学期 / 对象 / 授课 / 讲次 / 日期
- 先修要求
- 学习目标
- 关键词
- 本章路线
- 核心公式
- 方法提要
- 常见误区
- 考试关注
- 本章导航

其中未填写的区块会自动省略。

## 4. 本章导航

`maki-notes` 现在会在导读页底部生成当前章的局部导航。它和总目录不同：

- 总目录回答“整本讲义现在写到了哪里”
- 本章导航回答“这一章内部怎么展开”

当前版本默认只显示本章的 `section`，不展开 `subsection`。

注意：

- 章内导航依赖 `.toc` 信息
- 第一次编译后通常需要再编译一次，导航才会完整出现
- 仓库默认使用 `latexmk`，所以一般会自动处理多轮编译

## 5. 数学讲义专用块

新增了 4 个不编号环境：

- `keyformula`
- `pitfall`
- `methodnote`
- `examfocus`

最常见写法：

```tex
\begin{keyformula}
\[
  \lim_{x \to x_0} f(x) = A
\]
\end{keyformula}

\begin{pitfall}[易错点]
连续不等于可导，分段点还要单独检查左右极限与函数值。
\end{pitfall}

\begin{methodnote}
夹逼、代数变形与等价无穷小通常要配合使用。
\end{methodnote}

\begin{examfocus}
分段函数在分界点的连续性与可导性是高频考点。
\end{examfocus}
```

如果你不给可选标题，它们会分别使用默认标题：

- `核心公式`
- `常见误区`
- `方法提要`
- `考试关注`

## 6. 与旧接口的关系

这一层是增量能力，不是重写旧模板。也就是说：

- 旧的盒子环境、页边批注、TikZ 样式都还能继续用
- 不使用新命令时，文档仍按旧方式编译
- 新工作流层更适合“课程化、讲次化、章节导读更专业”的数学讲义

## 7. 建议写法

- 每章都写 `\SetChapterInfo` 与 `\MakeChapterGuide`，这样整套讲义会更一致
- 把“学习目标”写成教学动作，而不是纯名词堆叠
- 把“本章路线”写成学习路径，而不是复制目录
- 把“常见误区”单独写出来，不要全部塞进普通 `note`

如果你想看一份真实示例，可以直接参考：

- [`example.tex`](../example.tex)
- [`tests/test-workflow-guide.tex`](../tests/test-workflow-guide.tex)
