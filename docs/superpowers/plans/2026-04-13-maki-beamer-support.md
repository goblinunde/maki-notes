# Maki Beamer Support Plan

目标：在当前 `maki-notes` 项目基础上新增一套可编译、可发布、可维护的 Beamer 支持。新支持以 `beamer-example/` 里的 Durham 风格为参考，但视觉语义、主题色、TikZ 样式与数学内容层继续复用 `maki-notes.sty` 的设计体系。

## 文件职责

- `maki-notes.sty`
  提炼 beamer 与 notes 共享的公共样式层，并隔离 `geometry`、`fancyhdr`、`wrapfig`、边注、按 `chapter` 编号等 notes 专属逻辑。
- `maki-beamer.cls`
  新的 Beamer 文档类入口，负责类选项、字体/主题选项透传、载入公共样式层、应用 Maki Beamer 主题。
- `beamerthememaki.sty`
  参考 `beamer-example/beamerthemedurham*.sty` 实现 Maki 的 Beamer 主题，包括 title page、outline frame、headline、block 色彩和页脚编号。
- `beamer-demo.tex`
  仓库内的完整 Beamer 示例，展示标题页、目录页、数学块、TikZ 图形和主题色的组合使用。
- `tests/test-beamer.tex`
  最小回归测试，验证 `maki-beamer.cls`、公共数学命令、盒子环境和 TikZ 样式在 beamer 下能正常编译。
- `Makefile`
  新增 Beamer 示例与测试目标，纳入清理规则。
- `.github/workflows/release.yml`
  把 Beamer 示例纳入 release 构建和发布资产。
- `README.md`
  说明新的 Beamer 支持、构建命令和 release 资产。
- `docs/README.md`
  把 Beamer 文档入口纳入文档索引。
- `docs/beamer-guide.md`
  说明 `maki-beamer.cls` 的接口、设计来源、建议写法与与 `maki-notes` 的关系。

## 任务 1：写最小 failing beamer 测试

- 文件：
  - `tests/test-beamer.tex`
- 内容：
  - 创建一个最小 Beamer 文档：
    - `\documentclass[a4paper]{maki-beamer}` 改为合理的 beamer 用法，例如 `\documentclass[aspectratio=169]{maki-beamer}`
    - 设置 `\title`、`\subtitle`、`\author`、`\institute`、`\date`
    - 一页 `\maketitle`
    - 一页 `\makeoutline`
    - 一页包含 `definition` / `note` / `keyformula` 中至少一个在 beamer 下需要工作的块
    - 一页包含最小 TikZ 语义样式，例如 `transformer block` 或 `maki annotation`
- 失败验证命令：
  - `latexmk -pdf -interaction=nonstopmode -file-line-error tests/test-beamer.tex`
- 预期：
  - 因为 `maki-beamer.cls` 尚不存在而失败，或因为 `maki-notes.sty` 中 notes 专属逻辑和 beamer 冲突而失败。

## 任务 2：隔离公共样式层与 notes 专属层

- 文件：
  - `maki-notes.sty`
- 修改：
  - 增加环境探测，例如判断当前是否运行在 beamer 类下。
  - 将以下内容保留为公共层：
    - 颜色主题
    - 字体 preset 选择
    - 数学命令
    - `tcolorbox` 公共视觉风格
    - TikZ / PGFPlots 语义样式
  - 将以下内容改为仅 notes 模式启用：
    - `geometry`
    - `fancyhdr`
    - `capt-of` / `caption` / `subcaption`
    - `wrapfig`
    - `marginnote`
    - chapter guide、chapter navigation、页边批注
    - `chapter` 相关计数器与 hooks
  - 为 beamer 模式提供安全退化：
    - `keyformula` / `pitfall` / `methodnote` / `examfocus` 可以继续用
    - `definition` / `theorem` / `example` 系列环境如果依赖 `chapter`，要切换为 frame/section 友好的编号或无编号版本
- 先验证失败：
  - 运行任务 1 的测试，确认当前失败信息与预期一致
- 最小实现后验证：
  - 再跑 `latexmk -pdf -interaction=nonstopmode -file-line-error tests/test-beamer.tex`
- 预期：
  - 失败原因从“样式层冲突”收敛到“类或主题不存在”。

## 任务 3：实现 `maki-beamer.cls`

- 文件：
  - `maki-beamer.cls`
- 内容：
  - 参考 `beamer-example/durhambeamerzh.cls`
  - 支持至少这些类选项：
    - `fontpreset`
    - `theme`
    - `plain`
    - `invert`
    - `accessibility`
  - 载入基础类：
    - 优先 `ctexbeamer`，并保持 `fontset=none`
  - 定义或兼容这些入口：
    - `\MakeTitlePage`
    - `\makeoutline`
  - 载入：
    - `maki-notes`
    - `beamerthememaki`
- 红灯验证：
  - `latexmk -pdf -interaction=nonstopmode -file-line-error tests/test-beamer.tex`
- 预期：
  - 编译继续失败，但进入主题或视觉层缺失阶段，而不是类缺失。

## 任务 4：实现 `beamerthememaki.sty`

- 文件：
  - `beamerthememaki.sty`
- 内容：
  - 参考 `beamer-example/beamerthemedurham.sty` 与 `beamerthemedurhamzh.sty`
  - 用 `LogicColor` 作为主主题色，保持与 `maki-notes` 的主题联动
  - 实现：
    - title page
    - outline frame
    - headline navigation
    - page number footline
    - block / alerted block / example block 色彩
    - itemize 样式
  - 不照搬 Durham 名字，统一改成 `Maki...` 前缀
  - 避免引入与现有字体 preset 冲突的强制字体包
- 验证命令：
  - `latexmk -pdf -interaction=nonstopmode -file-line-error tests/test-beamer.tex`
- 预期：
  - `tests/test-beamer.tex` 首次完整通过。

## 任务 5：补全 Beamer 示例文档

- 文件：
  - `beamer-demo.tex`
- 内容：
  - 至少包含：
    - 标题页
    - 目录页
    - 一页数学讲义块示例
    - 一页 TikZ 结构图示例
    - 一页主题色/box 组合示例
    - appendix 或总结页
  - 标题和正文用中文，接口名保持英文
- 验证命令：
  - `latexmk -pdf -interaction=nonstopmode -file-line-error beamer-demo.tex`
- 预期：
  - 示例文档通过，并能体现参考设计语言。

## 任务 6：接入构建、发布与文档

- 文件：
  - `Makefile`
  - `.github/workflows/release.yml`
  - `README.md`
  - `docs/README.md`
  - `docs/beamer-guide.md`
- 修改：
  - `Makefile`
    - 增加 `beamer-demo` 目标
    - 增加 `tests/test-beamer.tex` 到测试目标
    - 增加清理规则
  - `release.yml`
    - 编译 `beamer-demo.tex`
    - 增加 `tests/test-beamer.tex`
    - 发布 `maki-notes-<tag>-beamer-demo.pdf`
  - `README.md`
    - 说明 Beamer 支持与构建命令
  - `docs/README.md`
    - 加入 Beamer 文档入口
  - `docs/beamer-guide.md`
    - 说明：
      - `maki-beamer.cls` 的接口
      - 主题选项
      - 与 `maki-notes.sty` 的共享关系
      - 推荐目录页、标题页和 frame 写法
- 验证命令：
  - `make -B beamer-demo`
  - `latexmk -pdf -interaction=nonstopmode -file-line-error tests/test-beamer.tex`
  - `ruby -e 'require "yaml"; YAML.load_file(".github/workflows/release.yml"); puts "yaml-ok"'`

## 任务 7：最终验证与提交

- 全量验证命令：
  - `make -B beamer-demo`
  - `latexmk -pdf -interaction=nonstopmode -file-line-error tests/test-beamer.tex`
  - `make -B tikz-example`
- 差异检查：
  - `git diff -- maki-notes.sty maki-beamer.cls beamerthememaki.sty beamer-demo.tex tests/test-beamer.tex Makefile .github/workflows/release.yml README.md docs/README.md docs/beamer-guide.md`
- 预期：
  - Beamer 功能新增不会破坏当前 TikZ 手册和既有 release workflow。
