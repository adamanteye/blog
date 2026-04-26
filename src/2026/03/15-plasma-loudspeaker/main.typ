#import "/slide.typ": *
#import "meta.typ": desc, title
#set text(lang: "zh")
#show: conf.with(title: title, desc: desc)

== 电路设计

KiCAD 的 `Tools > Plugin and Content Manager` 可以下载到 `Fabrication Toolkit`.
支持导出嘉立创 BOM.

按照功能, 电路可以分成两部分, 音频放大以及 ZVS 驱动.

/ 音频放大:

参考#link(
  "https://www.ti.com.cn/cn/lit/an/zhca782b/zhca782b.pdf",
)[反相放大器电路 (Rev. B)], 但根据本实验需要做了单电源化和声道合成处理.

`J1` 的左右声道先经电容耦合进入 `TL072` 的其中一路通道, 另一个通道被禁用. 两个
$qty("22", "kO")$ 电阻用于声道求和和输入阻抗设定. 围绕运放的 $qty("22", "kO")$
电阻和 $qty("22", "kO")$ 可调电阻用于设置 `AMP_OUT` 的放大幅度.
这一部分的目的是合成与放大音频.

/ ZVS 驱动:

我参考了 #link("https://www.instructables.com/ZVS-Driver/")[How to Build a
  Simple But Powerful Flyback Driver] 所示的 Mazzilli ZVS 思路, 由两只
`IRFP4668PbF` MOSFET 组成对称自激结构. 输入电感 `L1` 向高压包一次侧中心抽头供能,
两个功率管交替导通, 在一次侧和谐振电容 `C4` 之间形成高频谐振回路. `C4` 与 `C6`
取值为 $qty("0.33", "uF")$, 用于维持 ZVS 所需的谐振条件.

`AMP_OUT` 并不直接参与高频自激, 而是作为低频调制信号去改变放电功率.

== 原理图

板承载低压控制与一次侧驱动部分, 高压包通过外部连线接入.

#figure(image("schematic-1.svg", height: 60%), caption: "原理图")

使用 #link("https://www.falstad.com/circuit/circuitjs.html")[circuitjs]
的仿真#footnote[现在发现这是一个下等的工具, 没办法用商业 SPICE 模型,
  只有理想元件.]表明, ZVS 起振的频率与外部线圈等效电感强相关.

== PCB

PCB 采用双层板, 在音频放大部分采用双面覆铜作为 GND. 最大线宽为 0.5 mm,
最小线宽为 0.15 mm.

#figure(image("output.png", height: 80%), caption: "PCB")

== 测试计划

#figure(image("pcb.jpg", height: 50%), caption: "PCB")

#grid(
  columns: 2,
  [
    / 测试方案:
    + 接入 12V 供电, 利用示波器观察放大输出波形是否正确
    + 接入高压包, 观察是否能产生电弧, 以及是否持续
    + 移动电极距离, 再次观察
    + 评价音质
  ],
  [
    / 已投入的物料成本:
    - 嘉立创 PCB 打板: 41.04 $yuan$
    - 嘉立创物料: 102.78 $yuan$
  ],
)

== 测试结果

在 D+4 的测试, 发现放大输出部分是正确的. 而 ZVS 不能其起振.

/ 不足:
- 没有留出通孔来插电极, 用示波器或万用表的调试体验很不好
- 也没有做开关, 难以独立调试电路的某一部分
- DC 电源, 3.5mm 音频接口靠近电路板内侧
- 没有完成机械加工和支撑
- 手工焊接质量差

/ 分析:

ZVS 常见的接法是连接电源输出与电极地, 而我这里是接入了电源输出以及 `AMP_OUT`.

`TL072` 是小信号运放, 不是功率级回流路径. ZVS 谐振电流很大,
不能让运放输出脚承担这个节点. 这样的接法破坏了 MOSFET 的 $V_(G S)$ 条件.

/ 改进:

必须更换调制方式.
