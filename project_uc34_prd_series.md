---
name: UC34 系列 PRD 进展（Case 1-5）
description: MBPTS UC34 进口单证自动化各 Case 的 PRD 交付状态、格式基线与 Case5 关键决策
type: project
---

MBPTS（奔驰零部件）AI Quick Win，UC34=进口单证自动化平台，共 5+ 个 Case。

- PRD 交付目录约定：`c:\MBPTS\docs\Case{N}_PRD\`（Case2 为完整范例：md+pdf+preview.html+drawio+images）；历史初版在 `c:\MBPTS\UC34 PRD初版\`（0921，单场景自包含格式）
- Case5（ASN 自动创建，MBPLAP/X-entry 双支线）PRD v1.0.0 已于 2026-09-29 交付至 `docs\Case5_PRD\`，四项关键决策：命名 MBPLAP=提单号_发票号 / X-entry=PN_日期；边界=产出 DSS 模板为止（开票核对不纳入）；MBPLAP 保留手动批量重提交+17:00 剔除逻辑；邮件直发公邮 asn@mb.cn
- Case2 GLC 线 PRD 深度审查（2026-09-29，PRD Reviewer 流程首单）：交付 `docs\Case2_PRD\UC34-Case2-GLC_PRD_审查报告.md`（P01~P23 诊断）+ `UC34-Case2-GLC_PRD_修订版.md`（未改原 v1.0.0）。关键定版：IES 差异弹窗捕获后不阻断、PDC 未命中建 Other 不阻断、DG 判定改在齐套判断定版、缺 AVIS 挂起票建 Task 走任务详情缺件处理区闭环
- Case2 GLC PRD 表单核对迭代 v1.1.1（2026-09-30）：实物表单在 `c:\MBPTS\Case2_所需表单\`。关键事实：gvShipLog 导出 16 列含 PDC/ETA/Vessel/Voyage/BOL(=MBZ,1..n,一箱多行)；发票导出 27 列含 Others(FOB 填入列)与 price difference；BL 模板 Container No./Seal 同来自提单 MARKS AND NUMBERS(16)区需拆分；BL.xlsx 注释 Load/VOL 来源疑反
- Case2 GLC PRD v1.1.3（2026-09-30）：新增 7.4 节点实现规格（7 节点×输入/子步骤/输出/检查点/失败处理+G1 齐套/G2 质量/G3 绿灯 3 闸口）；Task 创建时机=收单即建；概要设计 3 项技术决策 D1 IES 交互方式/D2 大表回写通道/D3 归档写入通道显式列为范围外阻塞项；OPEN 增至 23 项（G23=OCR 置信度阈值建议 0.85）
- Case2 GLC PRD v1.2.4（2026-10-08）：6.2 主时序图末尾补简化"人工重跑"opt 分支（5 步，标注判定链详见 6.2.1）；用户确认"主图简化引用+细节独立成节"的图组织方式
- Case2 GLC PRD v1.2.3（2026-10-08）：新增 6.2.1 重跑交互时序（统一判定链流程图+mermaid 时序+8 条关键点：双判定/快照时点/修正携带/检查点输出沿用/同票互斥幂等/终态重置/L 列覆盖边界 OPEN-G28）；R7.5 引用；OPEN 增至 28 项
- Case2 GLC PRD v1.2.2（2026-10-08）：页面细节 8 项全量——新增 7.6 通用规格（表单控件/全局文案/权限×状态×操作总矩阵/展示规范/边界并发）、S1-S3 交互序列、Run 对比视图（OPEN-G26）、附录 A-1 Demo 偏差对照表；OPEN 增至 27 项；注意 v1.2.1 曾误删"第八部分"标题，v1.2.2 已修复
- Case2 GLC PRD v1.2.1（2026-10-08）：新增 7.5 性能与数据量级预期（周 100 票/峰值 300 假设挂 OPEN-G8；分页面性能验收口径；节点耗时预算+峰值批量测算，结论=RPA 任何并行度均不达 <2h，D1 必须优先 IES 接口通道；新增"IES 并发会话上限"待确认并入 D1）
- Case2 GLC PRD v1.2.0（2026-10-08）：页面级实质性扩写（用户明确要求"Demo 仅作形态参照、以业务流程为准、非文字润色"）：7.3.1~7.3.7 每页补齐进入条件/字段表含业务原因/按钮显示×角色矩阵/系统处理与反馈/空态异常；任务中心新增运行周/PDC/DG 筛选（OPEN-G24）+异常摘要列；工作台加调度信息条+手动补跑按钮（OPEN-G25）；8.2 加 /api/schedule/trigger 与"页面-操作-接口映射"表；6.3 加 J13/J14；OPEN 增至 25 项
- Case2 GLC PRD 真实票核对迭代 v1.1.2（2026-09-30，票 400759 全套实物）：**AVIS 模板取数双口径冲突**——GLC 标注版 AVIS 显示 7 列全取自 AVIS PDF（Container-No 去空格、VOL 合计行÷1000、欧式逗号小数），NAM 样本注释显示前 5 列取 gvShipLog，并列待业务定夺（OPEN-G21）；AVIS "Arrival"=目的港名非日期（F-08 删除，大表 D 列填港名）；BL 号以提单 SEA WAYBILL NO. 为准（自带 OOLU，BOOKING NO./AVIS 上无前缀）；BL 模板 B 列=AVIS No. 非 DOCUMENT NO（OPEN-G22）；单箱 68 MBZ 实例、一个 AVIS 可含多箱；Shippers_Decl 实物=27 页 IMO 申报单（UN 3268 安全气囊）。OPEN 增至 22 项。PDF 文本提取遇 CID 子集字体时改用 WinRT `Windows.Data.Pdf` 渲染 PNG 后读图（本机无 python/poppler）

**Why:** 后续 Case1/3/4 重写或 Case5 迭代时需保持同一格式与决策口径，避免与历史初版分叉。
**How to apply:** 撰写 UC34 系列 PRD 时沿用 prd-generator skill 流程 + Case2/Case5 目录结构；涉及 Case5 决策时以上述四项为准；BRD 全量版（0922 类）与梳理版冲突时先向用户澄清，不自行取舍。
