# 工作记忆：MBPTS UC34 Case 5 PRD（2026-09-29）

## 交付
- 主交付：`c:\MBPTS\docs\Case5_PRD\` — UC34-Case5_PRD.md / .pdf / .preview.html、UC34-Case5_业务流程图.html（0928 源复制）、UC34-Case5_需求澄清文档.md、requirements_plan.md、design_plan.md、images\（9 页原型截图 + 2 张支线流程图截图）
- 副本：`C:\Users\mintli\OneDrive - Deloitte (CN)\Documents\Case5_PRD\`（18 个文件）

## 关键决策（用户确认）
- Q1：命名 MBPLAP=「提单号_发票号」、X-entry=「PN_日期」（0927 梳理版 MBPLAP 段的「PN_日期」为笔误）
- Q2：开票通知单核对不纳入，平台边界=产出 DSS 模板+下载/归档为止
- Q3：MBPLAP 保留手动批量重提交（随下次定时）+ 17:00 剔除 12:00 已运行分单号
- Q4：X-entry 邮件直发公邮 asn@mb.cn，不做转发

## 流程记录
- 走 prd-generator skill：Stage1 澄清 4 问全 A → Stage2 设计审批通过 → Stage3 PRD
- 原型基线 = 用户提供的 case5页面demo 9 页（未重造原型）；流程图基线 = 0928 HTML 泳道图（未重绘 drawio，用户批准）
- 截图/PDF 用 skill 内置 puppeteer（C:\Users\mintli\.codebuddy\skills\prd-generator\node_modules）
