#import "/page.typ": *
#import "meta.typ": desc, title
#set text(lang: "zh")
#show: conf.with(title: title, desc: desc)

debugfs 是 Linux 内核提供的调试文件系统, 把驱动的内部状态和调试操作做成文件接口.
AMDGPU 的节点通常位于 `/sys/kernel/debug/dri/N/`, 需要 root 权限访问. 其中
`name` 用于确认 GPU, `amdgpu_gca_config` 提供计算资源规模等硬件配置,
`amdgpu_regs` 则允许读取寄存器, 也就是硬件保存状态和配置的存储单元.

可直接 cat 的状态信息包括 `name` 和 `amdgpu_pm_info`.

此外, #link(
  "https://docs.kernel.org/gpu/amdgpu/debugfs.html",
)[debugfs] 还能提供温度, 功率, 固件和任务队列等信息..

MI100 有 8 个 SE (Shader Engine, 着色器引擎), 编号 0-7. 每个 SE 有 1 个 SH
(Shader Array, 着色器阵列), 包含 16 个 CU (Compute Unit, 执行计算的单元), 编号
0-15. 每卡共有 128 个 CU 位置, 本次样本每个 SE 禁用 1 个, 实际启用 120 个.

通过 `amdgpu_regs` 按 SE 读取 `CC_GC_SHADER_ARRAY_CONFIG` (底层禁用配置) 和
`GC_USER_SHADER_ARRAY_CONFIG` (用户额外禁用配置), 就能得到禁用位图. 按#link(
  "https://github.com/torvalds/linux/blob/v6.12/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c",
)[驱动逻辑], 将两个值按位或, 再取高 16 位: 从最低位开始编号, bit $i$ 为 1 表示
CU$i$ 被禁用. `0x` 表示十六进制, 例如 `0x00200001` 的高 16 位是 `0x0020`, 即 bit
5 为 1, 表示禁用 CU5.

#let cards = (
  csv("cu-disabled.csv").slice(1).map(row => row.slice(1).map(std.int))
)
#let counts = range(16).map(cu => range(8).map(se => (
  cards.filter(card => card.at(se) == cu).len()
)))

#let mesh = lq.colormesh(range(8), range(16), counts)
#figure(
  canvas(grid(
    columns: (auto, auto),
    column-gutter: 6mm,
    align: top,
    lq.diagram(
      xlabel: [SE 编号],
      ylabel: [禁用 CU 编号],
      xaxis: (ticks: range(8), subticks: none, mirror: none),
      yaxis: (ticks: range(16), subticks: none, mirror: none),
      ..counts
        .enumerate()
        .map(((cu, row)) => row
          .enumerate()
          .map(((se, n)) => (
            lq.rect(
              se,
              cu,
              width: 1,
              height: 1,
              align: center + horizon,
              fill: mesh.color.at(cu * 8 + se),
              inset: 0pt,
              if n > 0 {
                align(center + horizon, text(
                  fill: if n >= 14 { black } else { white },
                  str(n),
                ))
              },
            )
          )))
        .flatten(),
    ),
    lq.colorbar(
      mesh,
      label: [禁用该位置的卡数],
      yaxis: (
        ticks: (0, 5, 10, 15, 20, 25, 30, 33),
        subticks: none,
        mirror: none,
      ),
    ),
  )),
  caption: [#cards.len() 张 MI100 的 CU 禁用位置统计.],
)
