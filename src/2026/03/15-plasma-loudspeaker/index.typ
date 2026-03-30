#import "/page.typ": *
#import "meta.typ": desc, title
#set text(lang: "zh")
#show: conf.with(title: title, desc: desc)

= 实验内容

等离子体扬声器以气体放电作为换能器,
将电信号直接转换为声压波@professor_hafner_corona_2015. 与传统扬声器不同,
它没有机械振膜, 声音主要来自放电通道附近空气的快速加热与膨胀.

常见的等离子体扬声器形式包括射频电晕放电,
直流电晕放电和直流辉光放电@mazzola_modeling_1987.

= 模型

等离子体扬声器中的声场可以看作中性理想气体中的普通压力波,
其驱动来自放电引入的源项. Bastien 的表述强调了两类一般性的声源结构:
热源项和力源项@bastien_acoustics_1987. 对于直流辉光等离子体扬声器,
起主导作用的通常是热效应: 电流调制改变放电柱温度,
温度调制再通过理想气体状态关系转化为压强调制.

= 电路设计

KiCAD 的 `Tools > Plugin and Content Manager` 可以下载到 `Fabrication Toolkit`.
支持导出嘉立创 BOM.

按照功能, 电路可以分成两部分, 音频放大以及 ZVS 驱动.

== 音频放大

参考#link(
  "https://www.ti.com.cn/cn/lit/an/zhca782b/zhca782b.pdf",
)[反相放大器电路 (Rev. B)], 但根据本实验需要做了单电源化和声道合成处理.

`J1` 的左右声道先经电容耦合进入 `TL072` 的其中一路通道, 另一个通道被禁用. 两个
$qty("22", "kO")$ 电阻用于声道求和和输入阻抗设定. 围绕运放的 $qty("22", "kO")$
kΩ 电阻和 $qty("22", "kO")$ 可调电阻用于设置 `AMP_OUT` 的放大幅度.
这一部分的目的是合成与放大音频.

== ZVS 驱动

我参考了 #link("https://www.instructables.com/ZVS-Driver/")[How to Build a
  Simple But Powerful Flyback Driver] 所示的 Mazzilli ZVS 思路, 由两只
`IRFP4668PbF` MOSFET 组成对称自激结构. 输入电感 `L1` 向高压包一次侧中心抽头供能,
两个功率管交替导通, 在一次侧和谐振电容 `C4` 之间形成高频谐振回路. `C4` 取值为
0.66 uF, 用于维持 ZVS 所需的谐振条件.

`AMP_OUT` 并不直接参与高频自激, 而是作为低频调制信号去改变放电功率.

== 原理图

板承载低压控制与一次侧驱动部分, 高压包通过外部连线接入.

#figure(image("schematic.svg"), caption: "原理图")

== PCB

PCB 采用双层板, 在音频放大部分采用双面覆铜作为 GND. 最大线宽为 0.5 mm,
最小线宽为 0.15 mm.

#figure(image("output.pdf", page: 1), caption: "PCB")

== 物料小计

#let bom = csv("bom.csv")
#figure(
  table(
    columns: 8,
    table.header(
      [商品名称],
      [商品编号],
      [品牌],
      [商品类型],
      [封装格式],
      [型号发货数量],
      [单价 (人民币含税)],
      [小计金额 (人民币含税)],
    ),
    ..bom.flatten(),
  ),
  caption: [元器件物料清单],
)

== 下次迭代计划

- 添加开关
- 在 PCB 上安装风扇以及散热器
- 添加 LED 指示工作状态
- 进行立体声合成

= 工期安排

#figure(
  table(
    columns: 3,
    table.header([时间], [任务], [完成状况]),
    [D-3], [下订单购买元件, 定制 PCB], [正常完成],
    [D-3], [提交初期报告], [正常完成],
    [D-2], [制作电极, 缠绕高压包初级线圈], [],
    [D+1], [收到 PCB, 进行焊接], [],
    [D+5], [完成测试], [],
    [D+6], [总结经验和改进, 绘制下一版原理图与 PCB], [],
    [D+7], [迭代下一版 PCB], [],
    [D+14], [撰写中期报告], [],
  ),
  caption: [工期计划 (学期第五周周日 23:59 为 D0)],
)

== 测试计划

+ 接入 12V 供电, 利用示波器观察放大输出波形是否正确
+ 接入高压包, 观察是否能产生电弧, 以及是否持续
+ 移动电极距离, 再次观察
+ 评价音质

= 其他

感谢 Ayu 教学我使用 KiCAD 绘制原理图, 选择合适的封装, 以及用 KiCAD 绘制 PCB
布线, 教给我关于立创商场的若干技巧. 感谢 ldx 提醒我注意散热.

#bibliography("main.bib")
