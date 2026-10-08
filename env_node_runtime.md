---
name: 本机运行时环境（node/pandoc/python）
description: c-MBPTS 工作区可用工具链：node 22 在 .workbuddy 目录、无 pandoc/python、prd-generator skill 自带 puppeteer
type: reference
---

本机 shell（PowerShell）默认 PATH 中**没有** node / pandoc / python。

- node v22.22.2：`C:\Users\mintli\.workbuddy\binaries\node\versions\22.22.2-2\node.exe`（`current` 目录可能不是可用链接，用 versions 下的实际路径）
- puppeteer：`C:\Users\mintli\.codebuddy\skills\prd-generator\node_modules`（截图/打印 PDF 可用，require 时用绝对路径 join）
- docx 文本提取：无 pandoc/python 时，用 PowerShell `System.IO.Compression` 解压 docx 读 `word/document.xml` 再剥 XML 标签（`</w:p>`→换行、`</w:tc>`→Tab）
- install_binary 工具装 node 会因 EPERM rename 失败，但 `.workbuddy\binaries\node\versions\` 下已有可用的 22.22.2-2
