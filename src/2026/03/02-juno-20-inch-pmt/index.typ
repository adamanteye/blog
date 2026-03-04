#import "/page.typ": *
#import "meta.typ": desc, title
#show: conf.with(title: title, desc: desc)
#set text(lang: "zh")

= 应用场景

江门中微子实验 (JUNO) 的目标是中微子振荡参数和质量顺序.
它探测的主要信号是轻水反应堆反中微子.

中微子与液闪中的氢原子核发生反应 $overline(nu)+p->e^++n$ 称为 IBD (inverse beta
decay), 这是 JUNO 探测器要甄别的信号: 正电子会迅速释放能量并湮灭为 0.511 MeV
的光子, 该即时信号包含了正电子动能和湮灭能. 中子主要和质子结合, 并在约 200
微秒后放出 2.2 MeV 的光子, 产生延迟信号@juno_2022.

JUNO 使用了大量 20-inch PMT (photomultiplier tube)@abusleme_mass_2022 和 3-inch
PMT, 前者也称 Large PMT, 后者 Small PMT.

对于 Large PMT, 其中有 5,000 只滨松 (Hamamatsu Photonics K.K) 的 dynode-PMT,
剩下 12,612 只为北方夜视 (North Night Vision Technology) 的 MCP-PMT. 此外,
还有若干被安装在符合探测器中@abusleme_initial_2025.

#figure(image("pmt-drawing.png"), caption: [20-inch PMT 图例, 左起: 北方夜视,
  滨松@abusleme_mass_2022])

= 工作原理

PMT 的基本过程可概括为: 入射光子在光阴极发生光电效应产生光电子,
光电子在电场作用下被聚焦并加速,
随后在电子倍增结构中发生多次次级电子发射形成电子雪崩,
最终由阳极收集并输出电荷脉冲. 因此, PMT 的输出可以用积分电荷 $Q$
或等效光电子数表征, 并依赖于光阴极量子效率,
电子收集效率以及倍增链的增益与统计涨落.

dynode-PMT 采用多级打拿级 (dynode) 串联倍增. 光电子从光阴极出发,
在聚焦电极和分压器提供的阶梯电位差作用下依次撞击各级打拿级,
每次撞击都会发射若干次级电子并被下一极继续加速, 经过多级后形成指数增长的电子数.
阳极收集末级电子并形成电流脉冲. dynode-PMT 的优势在于工艺成熟, 增益与线性较好,
时间响应较快, 其时间分辨主要受电子光学聚焦与首级倍增统计控制. 同时,
多级倍增带来的增益涨落会体现在单光电子 (SPE) 电荷谱的宽度与低电荷尾部中.

MCP-PMT (microchannel plate PMT) 以微通道板作为倍增结构,
由大量毛细玻璃管构成二维阵列, 每个通道内壁覆有次级电子发射材料,
可视为许多并行的独立电子倍增通道. 在通道两端施加电位差后,
入射电子进入通道并在斜入射几何下多次碰撞管壁, 每次碰撞产生次级电子并继续被加速,
最终在通道末端形成电子云并被阳极收集. MCP
的并行通道结构带来更高的电子收集效率与更大的有效探测面积,
但由于通道内漂移路径分布更宽, 以及工艺与读出结构差异, 其 Transit Time Spread
(TTS) 往往显著大于典型 dynode-PMT. JUNO 采用 MCP-PMT 与 dynode-PMT 并行部署,
在覆盖率, 效率, 寿命与成本等工程约束之间取得平衡.

#figure(image("mcp.png"), caption: [MCP-PMT 工作原理])

= 典型指标

JUNO 实验对 PMT 的性能要求是:

#figure(
  table(
    columns: 3,
    table.header([参数], [滨松], [北方夜视]),
    [QE], [30.3% (> 27%)], [28.5% (> 26.5%)],
    [CE], [95.6], [98% (> 96%)],
    [Gain], [10^7], [10^7],
    [TTS], [2.7 ns (< 3.5 ns)], [12 ns (< 15ns)],
    [HV(for a 10^7 gain)], [2000 V (< 2500 V)], [2500 V (< 2800 V)],
    [Lifetime], [> 20 yrs], [> 25 yrs],
  ),
  caption: [JUNO PMT 性能判据@abusleme_mass_2022],
)

其中, 量子效率 (QE) 描述光阴极将入射光子转换为光电子的概率,
直接影响单位能量的光电子产额与能量分辨. 收集效率 (CE)
描述产生的光电子被有效引导进入倍增结构并被阳极收集的比例, 在大口径 PMT
中与电子光学聚焦结构密切相关, 其与 QE 的乘积常决定有效光电转换效率. 增益 (Gain)
表示每个光电子最终在阳极形成的电子数, JUNO 选择 $10^7$ 作为工作点,
使得单光电子信号高于电子学噪声并便于稳定触发与电荷测量;
同时过高增益会加速老化并带来非线性风险, 因此需要在噪声裕度与寿命之间折中.

Transit Time Spread (TTS) 则刻画同样的光电子从光阴极到阳极的渡越时间涨落,
它决定了击中时间的本征分辨, 进而影响顶点重建, 时间窗口符合以及背景抑制能力.
dynode-PMT 通常具有更小的 TTS, 而 MCP-PMT 的 TTS
较大但可通过统计上大量通道的冗余命中进行补偿.

= 标定

在 JUNO 中, 每个 PMT 的波形最终都会被积分得到一个电荷量 $Q$ (或 ADC channel),
用于估计该 PMT 在一次事件中记录到的光电子数. 由于 PMT 的倍增链是随机变量的加和,
同样的 1 个光电子并不会产生完全固定的电荷, 而是形成一个单光电子 (SPE)
电荷量概率分布. 同时, 真实数据中还会混入基线噪声 (pedestal), 暗噪声触发,
以及少量多光电子叠加等成分. 因此, 实验必须对 PMT 的电荷谱进行标定,
以建立从电子学读出量到物理量的映射.

JUNO 实验中用到的 PMT 在中山泛亚电业进行测试与封装. 测试上述所有指标,
并且加装分压器以及做防水处理.

#figure(
  image("spectrum.png"),
  caption: [典型电荷积分直方图@bellamy_absolute_1994],
) <charge1994>

@charge1994 展示了一个典型的电荷谱拟合例子: 数据直方图由 pedestal, 1 PE 以及 2–4
PE 等分量叠加构成, 并通过拟合得到 $Q_1$ (SPE 标尺), $sigma_1$ (分辨率) 与 $mu$
(占空比) 等参数.

#bibliography("main.bib")
