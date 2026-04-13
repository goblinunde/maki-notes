# 研究写作工作台

这一页集中说明 `maki-notes` 新增的“研究写作层”。它解决的不是课堂讲义导读，而是更接近数学研究日常的几类需求：

- 给长期研究笔记补项目级元信息
- 给每个条目补主题、来源、目标和下一步
- 区分“可引用的数学对象”和“过程性研究记录”
- 显式维护符号表与开放问题表

第一期目标是把模板用成“研究笔记工作台”，而不是立刻替代正式投稿模板。

## 推荐使用顺序

最推荐的写法是：

```tex
\SetResearchInfo{
  project={紧算子与谱结构},
  area={泛函分析},
  author={Maki},
  status={working draft},
  updated={2026-04-13},
  tags={compact operator, spectrum}
}

\chapter{紧算子谱笔记}

\SetEntryInfo{
  topic={Riesz--Schauder 结构},
  source={Reed--Simon I},
  sourcekey={reed-simon-1},
  updated={2026-04-13},
  tags={compact operator, Fredholm},
  objective={整理非零谱离散性的证明骨架}
}

\MakeEntryGuide{
  summary={当前条目整理紧算子非零谱离散性的证明结构。},
  dependencies={Fredholm alternative; compact perturbation},
  targets={补全非零谱特征值有限重数部分},
  blockers={resolvent 紧性的引理链还不够紧凑},
  nextsteps={核对 Kato 的表述; 补 lemma 的引用位置}
}
```

然后在正文里继续写：

```tex
\DeclareSymbol{$\sigma(T)$}{算子 $T$ 的谱}

\begin{question}[更短证明链]
能否不调用最完整的 Fredholm alternative,
直接说明非零谱只能由有限重特征值组成？
\end{question}

\begin{idea}
先把 resolvent identity 写成局部形式，再决定是否需要更强的 Fredholm machinery。
\end{idea}
```

## 1. 项目级元信息

命令：

```tex
\SetResearchInfo{...}
```

支持的键：

- `project`
- `area`
- `author`
- `collaborators`
- `status`
- `created`
- `updated`
- `tags`

这些字段主要进入：

- 页眉中的项目名 / 状态 / 更新时间
- 条目导引块顶部信息

如果你不写这层，模板仍会回退到原有的讲义标题和作者信息。

## 2. 条目级元信息

命令：

```tex
\SetEntryInfo{...}
```

支持的键：

- `topic`
- `source`
- `sourcekey`
- `updated`
- `tags`
- `objective`

使用约定：

- `\SetEntryInfo` 作用于当前条目上下文
- 它不会自动绑定到 `\chapter` 或 `\section`
- 每开始一个新条目，建议重新调用一次，避免笔记上下文混乱

## 3. 条目导引块

命令：

```tex
\MakeEntryGuide{...}
```

支持的键：

- `summary`
- `dependencies`
- `targets`
- `blockers`
- `nextsteps`

导引块默认会整合：

- 项目名、方向、来源、状态、更新时间、标签
- 条目目标
- 摘要
- 依赖
- 当前目标
- 当前障碍
- 下一步

其中未填写的区块会自动省略。

和讲义里的 `\MakeChapterGuide` 不同，这里不会另起整页，而是作为正文中的全宽工作块出现，更适合研究笔记连续书写。

## 4. 研究语义环境

第一期把环境分成两类。

### 可编号、可引用的对象

- `notation`
- `question`
- `conjecture`
- `claim`

最常见写法：

```tex
\begin{claim}[非零谱候选]
\label{clm:nonzero-spectrum}
若 $\lambda \neq 0$ 且 $\lambda \in \sigma(T)$,
则它应表现出离散谱点的行为。
\end{claim}
```

这些环境都支持 `\label` / `\ref`。

### 过程性研究记录

- `remark`
- `proofsketch`
- `idea`
- `obstacle`
- `nextstep`

最常见写法：

```tex
\begin{proofsketch}
先把有限秩逼近与局部可逆性拆成两步, 再决定是否需要完整 Fredholm 备选定理。
\end{proofsketch}

\begin{obstacle}
当前还缺一个足够短的引理链把 resolvent 分析接到有限秩逼近上。
\end{obstacle}
```

这些环境默认不编号，更适合写研究过程而不是最终定稿对象。

## 5. 符号表

命令：

```tex
\DeclareSymbol{$\sigma(T)$}{算子 $T$ 的谱}
\DeclareSymbol{$\rho(T)$}{算子 $T$ 的 resolvent set}
```

输出命令：

```tex
\PrintSymbolIndex
```

当前策略是：

- 采用显式登记，不自动从公式抽取
- 按声明顺序输出
- 不做自动分类和字母排序

这种策略更稳，因为数学公式里的自动语义抽取很容易误判。

## 6. 开放问题表

输出命令：

```tex
\PrintOpenProblemIndex
```

当前版本会自动汇总：

- `question`
- `conjecture`

每条记录至少会显示：

- 类型
- 编号
- 可选标题
- 页码

如果你只是临时写想法而不希望进入开放问题表，就不要把它写成 `question` 或 `conjecture`。

## 7. 推荐组织方式

- 一个研究项目先写一次 `\SetResearchInfo`
- 每个具体条目都写一次 `\SetEntryInfo` 和 `\MakeEntryGuide`
- 关键对象用 `question`、`conjecture`、`claim`
- 过程记录用 `idea`、`obstacle`、`nextstep`
- 重要符号显式登记
- 在章末、附录或全文末尾统一输出符号表和开放问题表

## 8. 与正式论文类的边界

这层主要服务于：

- 研究笔记
- 读论文摘录
- 论文成稿前的结构化草稿

它当前还不打算替代：

- 期刊 / 会议投稿模板
- 完整 bibliography 工作流
- 带摘要、MSC、作者脚注、审稿模式的独立论文类

如果你已经进入正式投稿阶段，最终仍然应该切回目标期刊或会议自己的类文件；但在那之前，这一层更适合把“问题、对象、符号、障碍”整理清楚。
