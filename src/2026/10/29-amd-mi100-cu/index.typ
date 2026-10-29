#import "/page.typ": *
#import "meta.typ": desc, title
#set text(lang: "zh")
#show: conf.with(title: title, desc: desc)

SE (Shader Engine, 着色器引擎) 是 GPU 内部的一组计算资源, 一个 SE 可以包含多个
CU (Compute Unit, 计算单元). MI100 的驱动配置为 8 个 SE, 编号 `SE[0-7]`. 每个 SE
有 1 个 SH (Shader Array, 着色器阵列), 其中有 16 个 CU 位置, 逻辑编号为
`CU[0–15]`. 因此每卡有 $8 times 16 = 128$ 个 CU 位置.

但是 AMD 会禁用它们当中的 8 个, 留给用户 120 个.

#let cards = csv("cu-disabled.csv").slice(1).map(row => row.slice(1).map(std.int))
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
        .map(((cu, row)) => row.enumerate().map(((se, n)) => (
          lq.rect(
            se,
            cu,
            width: 1,
            height: 1,
            align: center + horizon,
            fill: mesh.color.at(cu * 8 + se),
            inset: 0pt,
            if n > 0 {
              align(center + horizon, text(fill: if n >= 14 { black } else { white }, str(n)))
            },
          )
        )))
        .flatten(),
    ),
    lq.colorbar(
      mesh,
      label: [禁用该位置的卡数],
      yaxis: (ticks: (0, 5, 10, 15, 20, 25, 27), subticks: none, mirror: none),
    ),
  )),
  caption: [54 张 MI100 的 CU 禁用位置统计.],
)
