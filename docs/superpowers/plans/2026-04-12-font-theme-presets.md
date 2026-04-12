# Font And Theme Presets Plan

## File Responsibilities

- `tests/test-basic.tex`: 先改成带 `fontpreset` 和 `theme` 的类选项兼容测试，作为 TDD 的红灯入口。
- `maki-notes.cls`: 解析 `fontpreset` 与 `theme` 类选项，并把结果传给样式层。
- `maki-notes.sty`: 应用字体预设与主题预设，处理无效值报错和平台字体回退。
- `README.md`: 说明 `.cls + .sty` 的配套关系，以及新类选项的默认值、可选值和示例。

## Execution Checklist

- [ ] 先修改 `tests/test-basic.tex`，让它引用新的类选项。
  Command: `latexmk -pdf -interaction=nonstopmode -file-line-error tests/test-basic.tex`
  Expected: 当前实现下编译失败，原因是 `fontpreset=...` 或 `theme=...` 尚未被 `maki-notes` 识别。
- [ ] 在 `maki-notes.cls` 中加入类选项解析。
  Command: `rg -n "fontpreset|theme|ProcessKeyvalOptions|DeclareStringOption" maki-notes.cls`
  Expected: 类选项与默认值已定义，未知选项继续透传给 `ctexbook`。
- [ ] 在 `maki-notes.sty` 中加入字体预设与主题预设系统。
  Command: `rg -n "MakiFontPreset|MakiTheme|ocean|forest|graphite|SimSun|Songti SC|Noto Serif CJK SC" maki-notes.sty`
  Expected: 可见预设分发逻辑、平台字体回退逻辑和主题色位定义。
- [ ] 更新 `README.md`，补充 `.cls + .sty` 配套关系与新类选项说明。
  Command: `rg -n "fontpreset|theme|graphite|forest|ocean|cls|sty" README.md`
  Expected: README 出现类选项说明、示例和结构关系说明。
- [ ] 重新编译测试与示例文档。
  Commands:
    - `latexmk -pdf -interaction=nonstopmode -file-line-error tests/test-basic.tex`
    - `latexmk -pdf -interaction=nonstopmode -file-line-error tests/test-wrap-layout.tex`
    - `latexmk -pdf -interaction=nonstopmode -file-line-error example.tex`
  Expected: 三条命令都返回 `0`。
- [ ] 运行仓库测试入口确认未破坏现有流程。
  Command: `make test`
  Expected: 返回 `0`。
- [ ] 尝试提交改动；如果 `.git` 仍不可写，保留精确报错给用户。
  Commands:
    - `git add ...`
    - `git commit -m "Add font and theme presets"`
    - `git push origin main`
  Expected: 成功提交，或得到明确的沙箱限制错误。
