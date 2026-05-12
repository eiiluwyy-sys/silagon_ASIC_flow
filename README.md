# SiLagoNN ASIC Flow 项目展示

这是一个面向求职展示整理过的 ASIC/FPGA 项目仓库，核心内容围绕 SiLagoNN 的 DRRA 风格加速器实现流程展开。仓库结构按“先看结果，再看流程，最后看原始证据”的思路组织，方便招聘方或面试官快速理解项目价值。

## 项目概览

- **设计内容：** 基于 VHDL 的 DRRA 加速器 wrapper 及相关计算 / 存储模块 RTL
- **流程内容：** RTL 仿真、平坦综合（flat synthesis）、分层综合（bottom-up synthesis）、物理设计结果整理
- **使用工具：** ModelSim / Questa 仿真脚本、Synopsys Design Compiler Tcl 流程、物理设计交接与结果文件
- **展示重点：** RTL 集成、综合流程自动化、层次化实现对比、PPA 分析与结果归档

## 关键结果

### Task 2：Flat Logic Synthesis

| 时钟周期 (ns) | 总功耗 (mW) | 单元面积 (um^2) | Slack (ps) |
| --- | ---: | ---: | ---: |
| 20 | 10.4133 | 358652 | 20.10 |
| 10 | 20.6254 | 359511 | 37.47 |
| 8 | 25.9535 | 365373 | 3.23 |
| 6 | 34.4214 | 389591 | 0.10 |

### Task 3：Bottom-Up Logic Synthesis

| 时钟周期 (ns) | 总功耗 (mW) | 单元面积 (um^2) | Slack (ps) |
| --- | ---: | ---: | ---: |
| 20 | 10.4048 | 363814 | 9.22 |
| 10 | 20.6061 | 364621 | 8.61 |
| 8 | 26.8799 | 392192 | 0.12 |
| 6 | 35.3253 | 394994 | -209.41 |

### Task 4：逻辑综合与物理综合对比

| 阶段 | 总功耗 (mW) | 单元面积 (um^2) | Slack (ps) |
| --- | ---: | ---: | ---: |
| Logic Synthesis | 10.4048 | 363814 | 29.24 |
| Physical Synthesis | 80.4640 | 381986 | -280.85 |

## 仓库结构

| 路径 | 说明 |
| --- | --- |
| `rtl/` | 主要 RTL 源码、层次结构文件、仿真入口脚本 |
| `tb/` | 独立测试平台与测试相关文件 |
| `syn/` | Design Compiler 综合脚本、PPA 汇总、报告与交接数据库 |
| `phy/` | 物理设计脚本、截图、报告与历史证据 |
| `docs/` | 面向展示的说明文档、流程索引、项目介绍 |
| `assets/` | 答辩材料、项目简介 PDF、图片资源 |
| `references/` | 架构辅助文件、接口快照、课程侧参考资料 |

## 推荐阅读顺序

1. `docs/FLOW_INDEX.md`
2. `syn/rpt/summary_tables/task2_flat_summary.md`
3. `syn/rpt/summary_tables/task3_bottomup_summary.md`
4. `phy/rpt/task4_historical_summary/README.md`
5. `docs/resume_project_intro.md`

## 运行方式

在仓库根目录下进行 RTL 仿真：

```bash
cd rtl
./START_SIMULATION.sh
```

在仓库根目录下运行综合：

```bash
./syn/run_synthesis.sh flat 20.0
./syn/run_synthesis.sh bottomup 20.0
```

## 说明

- 仓库中保留了一部分历史运行结果，目的是支持面试时对结果来源和流程演化进行追溯说明。
- 部分综合输出文件较大，GitHub 可以接受，但会给出大文件警告。
- 本地仿真缓存、临时 transcript、工具生成的 scratch 文件已尽量通过 `.gitignore` 排除。
