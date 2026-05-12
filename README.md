# projectv1 — SiLagoNN ASIC/FPGA 设计流程展示

面向求职与作品集展示的硬件设计仓库：覆盖 **RTL 仿真 → 逻辑综合（flat / bottom-up）→ 物理综合与相关脚本/报告**，体现从 RTL 到后端工具链的完整工程化能力。

*English:* Portfolio-style ASIC/FPGA flow demo (RTL sim, DC synthesis variants, physical flow scripts, reports, and archived run artifacts).

## 亮点（便于简历 / 面试口述）

- 可复现的脚本入口与流程索引（见下方 `FLOW_INDEX.md`）。
- 保留典型 PPA 报告、证据映射与历史归档，便于说明设计决策与结果对比。
- 工具链侧：Synopsys Design Compiler、物理相关 Tcl/脚本与目录约定清晰。

## 仓库结构

| 路径 | 说明 |
|------|------|
| `Project_2025_intro.pdf` | 项目背景与介绍材料（PDF） |
| `SiLagoNN_main_project/` | 主工程：RTL、仿真、综合、物理脚本、数据与报告 |

**流程与任务入口（权威索引）：** `SiLagoNN_main_project/FLOW_INDEX.md`

## 已做的整理（面向公开展示）

- **`related_lectures/`**（课件、样卷、题库等）已从 Git 跟踪中移除，并写入 `.gitignore`：不增加 clone 体积，也避免公开仓库里出现「考试资料」观感。你本机若仍保留该文件夹，可继续使用，只是不会再被推送到 GitHub。
- **`command.log`**（根目录与 `syn/`）不再纳入版本库，属可再生成日志。

若你希望连 `PRESENTATION_CRAM_GUIDE.md`、`REEXAM_MAPPING.md` 等明显偏课程备忘的文件也一并隐藏，可自行删除或移到仅本地的备份；当前保留是因为其中仍有流程速查价值，且不影响对外第一印象。

## 体积说明

仓库含综合 `db`、`archive` 等较大目录，首次 clone 会较慢；若仅浏览脚本与 RTL，可优先阅读 `FLOW_INDEX.md` 与 `syn/scr/`、`phy/scr/`。

## 克隆与本机开发

```bash
git clone https://github.com/eiiluwyy-sys/projectv1.git
cd projectv1
```

维护者在本机推送：

```bash
git remote add origin https://github.com/eiiluwyy-sys/projectv1.git   # 若尚未添加
git push -u origin main
```
