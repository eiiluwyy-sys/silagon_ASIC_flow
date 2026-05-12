# 正确运行仿真的方法

## ⚠️ 重要：工作目录问题

testbench 需要读取 `instruction.bin` 文件，它会在**当前工作目录**中查找。

## ✅ 方法1：从 testbench 目录运行（推荐）

```bash
# 1. 切换到 testbench 目录
cd ../tb/vec_add

# 2. 启动仿真（需要指定库路径）
vsim -suppress 1549 -voptargs=+acc -L ../../rtl/work work.testbench

# 3. 在QuestaSim中运行波形脚本
# 需要修改路径，因为现在在 testbench 目录
set DPU_PATH {/testbench/DUT/MTRF_COLS(0)/MTRF_ROWS(0)/if_drra_top_l_corner/Silago_top_l_corner_inst/SILEGO_cell/MTRF_cell/dpu_gen}
add wave -radix decimal $DPU_PATH/dpu_out_0
add wave -radix decimal $DPU_PATH/dpu_out_1
run 10000ns
```

## ✅ 方法2：复制 instruction.bin 到 rtl 目录（最简单）

```bash
# 在 rtl 目录下
cd rtl
copy ..\tb\vec_add\instruction.bin .

# 然后正常运行
vsim -do simulate_working.do work.testbench
```

## ✅ 方法3：使用绝对路径修改 testbench（不推荐）

如果需要，可以修改 testbench.vhd 中的文件路径，但这不是推荐的方法。

## 🎯 推荐流程

**最简单的方法：**

```bash
# 1. 编译（在 rtl 目录）
cd rtl
vsim -c -do compile_video.do

# 2. 复制 instruction.bin
copy ..\tb\vec_add\instruction.bin .

# 3. 仿真（在 rtl 目录）
vsim -do simulate_working.do work.testbench
```

这样就不需要切换目录了！


