# Font And Theme Presets Design

## Goal

为 `maki-notes` 增加通过 `\documentclass[...]` 传入的模板级类选项：

- `fontpreset=common|auto|windows|macos|linux`
- `theme=default|ocean|forest|graphite`

默认行为保持稳定：

- `fontpreset=common`
- `theme=default`

同时在 README 中明确说明 `maki-notes.cls` 与 `maki-notes.sty` 的关系：两者是同一套讲义模板的两层，而不是完全解耦的通用组件。

## Design Decisions

### Class Option Layer

- 在 `maki-notes.cls` 中解析 `fontpreset` 与 `theme`
- 未识别的其他类选项继续透传给 `ctexbook`
- 解析后的值通过宏暴露给 `maki-notes.sty`
- 如果用户显式传入不支持的值，由 `maki-notes.sty` 抛出清晰错误，列出可用枚举值

### Font Strategy

- 拉丁文字体统一改为更接近 Palatino 数学风格的正文栈，避免当前 `mathpazo` 与 `Latin Modern Roman` 的不一致
- 默认 `common` 预设使用 TeX Live 自带或稳定可用的字体组合，优先保证跨平台可编译
- `windows`、`macos`、`linux` 预设优先选取各平台常见中文字体
- 如果目标平台字体不存在，则按角色回退到 `common`
- `auto` 不依赖操作系统判断，而是按已安装字体的可用性自动落到最接近的预设

### Theme Strategy

- 保留现有语义色位名称，例如 `LogicColor`、`DefColor`、`ExColor`、`NoteColor`
- 各主题只修改语义色位的 RGB 值，不改现有环境、TikZ 样式和公开接口
- `default` 完全保留当前仓库已有配色
- `ocean`、`forest`、`graphite` 提供额外视觉方向，但不引入第二套 API

### Documentation And Tests

- README 增加：
  - `.cls + .sty` 是一套模板两层结构的说明
  - 新类选项的写法、默认值、回退行为
  - 主题列表
- 现有 `tests/test-basic.tex` 扩展为类选项兼容测试，避免新增过多零散测试文件
- 验证步骤包含：
  - 在实现前确认带新类选项的测试文档编译失败
  - 在实现后确认测试文档与示例文档编译通过

## Files

- `maki-notes.cls`
- `maki-notes.sty`
- `tests/test-basic.tex`
- `README.md`
- `docs/superpowers/plans/2026-04-12-font-theme-presets.md`

## Self-Review

- 选项归属明确：类选项只在 `.cls` 解析，实际应用在 `.sty`
- 默认行为明确：不写选项时仍应稳定编译
- 回退行为明确：平台字体缺失时回退到 `common`
- 主题切换不改 API：现有示例和环境无需改写
