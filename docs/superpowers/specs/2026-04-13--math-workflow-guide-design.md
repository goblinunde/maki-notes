# Math Workflow Guide Design

## Goal

把 `maki-notes` 从“数学讲义排版模板”继续推进为“数学讲义写作工作流模板”，第一期聚焦两件事：

- 课程元信息层：统一管理课程、学期、授课对象、授课人、讲次、日期等信息
- 专业章节导读层：在总目录之外，为每章提供单独的整页导读与章内导航

本期不处理学生版/教师版答案切换，也不做定理索引、公式索引或章末答案册。

## Scope

### In Scope

- 新增课程级元信息命令
- 新增章节级元信息命令
- 新增整页章节导读页
- 新增当前章局部导航块
- 新增若干数学讲义专用信息块环境
- 在页眉和导读页中复用课程/章节元信息
- 更新 README 与 `docs/` 用户文档
- 增加回归测试

### Out Of Scope

- 学生版/教师版答案开关
- 题目难度、知识点、来源标签系统
- 自动生成定理/公式/习题索引
- 章末复习页、作业页、答案页
- 自动从正文语义中推断导读内容

## Design Decisions

### Overall Strategy

- 接口名保持英文，渲染出来的标题保持中文
- 章节导读采用“整页导读”而不是“章标题下导读区”
- 导读信息采用“作者显式填写 + 模板自动排版”的半自动策略
- 当前总目录继续保留，章节导读和局部导航是补充层，不替代 `\tableofcontents`

### Compatibility Strategy

- 保持现有 `\LectureNotesTitle`、`\AuthorInfo`、`\CoverTitle`、`\CoverAuthorBlock`、`\CoverFooterBlock` 可继续使用
- 新增元信息层以“补充和提供默认值”为主，不强制用户改写现有文档
- 如果用户完全不使用新接口，现有示例文档和测试文档应保持行为不变

### Chapter Guide Strategy

- 章节导读页不自动插入，采用显式命令生成，避免每章都被强制打断
- 典型写法是：
  1. `\SetChapterInfo{...}`
  2. `\chapter{...}`
  3. `\MakeChapterGuide{...}`
- `\chapter{...}` 仍负责正式章节标题和编号
- `\MakeChapterGuide` 负责生成导读页，并基于当前章编号和标题渲染导航信息

这种设计比“自动检测到章节就强制插一页”更稳，也更适合部分章节需要导读、部分章节不需要导读的真实讲义写作场景。

## User-Facing API

### Course Metadata

新增命令：

```tex
\SetCourseInfo{
  course={高等数学},
  term={2026 春},
  audience={考研数学},
  instructor={Maki},
  lecture={第 3 讲},
  date={2026-04-13}
}
```

首期支持的键：

- `course`
- `term`
- `audience`
- `instructor`
- `lecture`
- `date`

行为约定：

- 这些字段用于导读页顶部信息行
- 页眉可读取其中的课程名、讲次和日期
- 如果用户没有单独设置某字段，则对应位置留空或回退到现有宏

### Chapter Metadata

新增命令：

```tex
\SetChapterInfo{
  subtitle={从定义到连续性},
  lecture={第 3 讲},
  date={2026-04-13},
  keywords={极限, 连续, 夹逼准则},
  prereq={函数与实数基础},
  goals={理解极限定义; 会判断连续性; 会使用夹逼准则}
}
```

首期支持的键：

- `subtitle`
- `lecture`
- `date`
- `keywords`
- `prereq`
- `goals`

行为约定：

- `\SetChapterInfo` 作用于“下一个 `\chapter` 及其后续导读页”
- `lecture` 与 `date` 可覆盖课程级同名字段
- 章节标题本身直接取当前 `\chapter{...}` 的标题，不要求用户重复填写 `topic`
- 章节级字段在绑定到当前章后不再继续泄漏到下一章；如果下一章未重新设置，则其专属字段按空值处理，只回退课程级字段

### Chapter Guide Page

新增命令：

```tex
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

首期支持的键：

- `route`
- `formulas`
- `pitfalls`
- `methods`
- `examfocus`

行为约定：

- `\MakeChapterGuide` 在当前章标题之后另起一页，生成整页导读
- 导读页固定使用中文标题，例如：
  - `本讲主题`
  - `先修要求`
  - `学习目标`
  - `关键词`
  - `本章路线`
  - `核心公式`
  - `方法提要`
  - `常见误区`
  - `考试关注`
  - `本章导航`
- 用户不填写的块不渲染，避免空框占位

### Math Workflow Blocks

新增 4 个轻量环境：

- `keyformula`
- `pitfall`
- `methodnote`
- `examfocus`

示例：

```tex
\begin{pitfall}[易错点]
连续不等于可导，分段点还要单独检查左右极限与函数值。
\end{pitfall}
```

设计目的：

- 在正文中复用与导读页一致的教学语义
- 避免作者把“方法提醒”“考试提醒”“易错点”都挤进通用 `note`

这些环境首期不编号，采用与现有盒子体系一致的 `tcolorbox` 视觉语言。

## Page Structure

### Guide Page Layout

整页导读建议分为 3 个区块：

1. 顶部信息区
- 章节编号与章标题
- 章节副标题
- 课程/讲次/日期信息

2. 中部教学信息区
- 先修要求
- 学习目标
- 关键词
- 本章路线

3. 下部专业导航区
- 核心公式
- 方法提要
- 常见误区
- 考试关注
- 本章导航

布局原则：

- 导读页视觉上要明显区别于普通正文页
- 保留当前模板色彩体系，不另起一套风格
- 不依赖大面积装饰图形，重点在信息组织清晰

### Local Navigation

- 局部导航只展示当前章的 `section`
- 首期不展开 `subsection`
- 局部导航应直接从 `.toc` 信息中读取，而不是要求作者手写列表
- 若当前章尚无 section，导航块自动省略

实现上优先选择稳定的局部目录方案，而不是自行重写目录解析逻辑。

## Implementation Notes

### Metadata Parsing

- 复用 `tikz/pgfkeys` 提供的 key-value 机制实现 `\SetCourseInfo`、`\SetChapterInfo` 和 `\MakeChapterGuide`
- 不新增一套自定义解析 DSL
- 所有字段都存入显式命名的内部宏，避免临时 token 列表难维护

### Integration With Existing Title Macros

- `\SetCourseInfo` 不删除现有封面宏
- 现有封面仍可由 `\CoverTitle`、`\CoverAuthorBlock`、`\CoverFooterBlock` 独立控制
- 新元信息优先服务于导读页和页眉
- 对封面的联动只做温和回退，不强制覆盖用户已有设置

### Header Strategy

- 默认继续保留当前页眉结构
- 但当课程/章节元信息存在时，允许页眉读取更具体的信息：
  - 左侧优先显示课程名或讲义标题
  - 右侧优先显示当前讲次/日期；若缺失则回退到 `\AuthorInfo`

这一策略既能提升教学语义，也不会破坏旧文档的兼容性。

### Guide Invocation Model

- `\SetChapterInfo` 负责准备当前章元信息
- `\chapter{...}` 负责更新章标题和计数器
- `\chapter{...}` 发生后，待消费的章节元信息即绑定到当前章，并清空“待下一章使用”的缓存
- `\MakeChapterGuide` 在当前上下文中读取：
  - 当前章编号
  - 当前章标题
  - 已缓存的章节元信息
  - 课程级元信息
  - 当前章局部目录

### Styling Strategy

- 导读页与数学专用块继续基于 `tcolorbox`
- 使用现有语义色位，例如 `LogicColor`、`DefColor`、`ExColor`、`NoteColor`
- 不引入与主题系统割裂的新颜色命名

## Documentation

需要更新或新增：

- `README.md`
- `docs/README.md`
- `docs/template-guide.md`
- 新增 `docs/workflow-guide.md`
- `example.tex`
- 视实现情况补充 `document2.tex`

其中 `docs/workflow-guide.md` 负责集中说明：

- 课程元信息怎么写
- 章节导读怎么写
- 本章导航如何生成
- 数学专用信息块怎么使用

## Testing

新增一份工作流测试文档，建议命名为：

- `tests/test-workflow-guide.tex`

测试覆盖至少包括：

- `\SetCourseInfo` 基本字段解析
- `\SetChapterInfo` 与 `\chapter` 的联动
- `\MakeChapterGuide` 生成整页导读
- 当前章局部导航生成
- 4 个数学专用信息块可正常排版
- 空字段省略不报错
- 不使用新接口时，现有基础测试仍通过

验证步骤应包含：

- `make test`
- 至少一次真实示例文档编译，例如 `make example`

## Files

- `maki-notes.sty`
- `README.md`
- `docs/README.md`
- `docs/template-guide.md`
- `docs/workflow-guide.md`
- `example.tex`
- `tests/test-workflow-guide.tex`

## Future Extensions

当前设计为后续扩展预留基础，但不在本期实现：

- 学生版/教师版答案切换
- 题目元数据系统：难度、来源、知识点、年份
- 章末复习页和作业页
- 紧凑模式导读：章标题下导读区
- 公式索引、定理索引、例题索引

## Self-Review

- 设计重心明确：先解决课程元信息和章节导读，而不是一次性把整套教材系统做满
- 公开接口克制：只有 3 个主命令和 4 个轻量环境，学习成本可控
- 兼容策略明确：旧文档不需要改写，新接口是增量能力
- “整页导读”已固定为第一期默认形态，没有把两种模式一起塞进首版
- 自动化边界明确：模板负责结构化排版，不负责替作者猜教学内容
