# 长期记忆

## 工作区与仓库约定

- `c:\Memory` 是本机长期工作记忆目录，同时是一个 git 仓库，**已关联远程 `origin = https://github.com/Mint-lxy/Memory.git`（private，分支 `main`）**。工作记忆文件写入 `.codebuddy/memory/` 后，需 `git add` + `commit` + `push` 才能在线上仓库可见（2026-09-14 建立）。
- 用户此前误以为"提交了仓库里就有"：该仓库原先**没有配置任何 remote**，且 GitHub 上是空库；根因是 commit ≠ push。以后写完记忆文件应顺手推送。
- 文档类交付物放 `C:\Users\mintli\OneDrive - Deloitte (CN)\Documents`；未经允许不改动工作区项目；交付物偏好带图片示例。

## 相关仓库速查

| 本地路径 | 远程 | 备注 |
|---|---|---|
| `c:\Memory` | `github.com/Mint-lxy/Memory`（private） | 工作记忆仓库，分支 main |
| `C:\Users\mintli\Downloads\China AI portal` | `github.com/Mint-lxy/China-AI-Portal` | GRC AI Agent Portal 静态原型（knowledge/build/marketplace/quickly guide 页面） |
| `C:\Users\mintli\Downloads\grc-spec-hub` | `mercedes-benz.ghe.com:china/grc-spec-hub` | spec/契约/记忆枢纽，多特性分支并行 |

## 工具环境

- **提交必须带 `-m`**：本机环境变量 `EDITOR=cat`（`VISUAL` 为空），无 `-m` 的 `git commit` 会执行 `cat` 读 stdin 并**永久挂起**（表现为"提交半天没成功"）。已在 `c:\Memory` 设 `core.editor = "code --wait"` 兜底；其它仓库若出现同样症状，先 `git var GIT_EDITOR` 确认，再用 `git commit -m` 或 `git config core.editor "code --wait"`。
- 判断卡死：`Get-CimInstance Win32_Process -Filter "name='git.exe'"` 看命令行；`.git/COMMIT_EDITMSG` 若仍是模板注释即为等待编辑器。清理：`Stop-Process -Id <pid> -Force`，必要时删 `.git/index.lock`（索引已暂存内容不会丢）。

- 本机 PowerShell（部分命令如 `&`、`@{u}`、`(if ...)` 会解析失败，用 `;` 分隔、`Select-Object` 可用）。
- Python 位于 `C:\Users\mintli\.workbuddy\binaries\python\versions\3.14.3\python.exe`（含 openpyxl）。
- Git 凭据由 `credential.helper=manager` 管理，访问 GitHub/GHE 无需手动输密码。
