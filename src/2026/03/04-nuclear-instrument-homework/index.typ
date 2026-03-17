#import "/page.typ": *
#import "meta.typ": desc, title
#show: conf.with(title: title, desc: desc)

#let hw = [
  = 第二周作业
  == 问答题

  请描述说明 $beta$ 谱仪和 $gamma$ 谱仪存在哪些不同.

  对象不同, $beta$ 谱仪测量(正)电子的能量分布, $gamma$ 谱仪测量光谱.
  并且前者通过电离/激发进行测量, 后者通过光电效应, 康普顿散射,
  电子对产生进行测量.

  == 平板电离室

  + 电子和正离子分别向阳极和阴极漂移, 两个板上感应电流的极性相反, 阳极流出电流,
    阴极流入电流.
  + 电离出的电子和正离子对的数量为 $num("5e4")$ 电荷量为 $qty("8.01e-15", "C")$.
  + 考虑 $V_"max"=Q\/C=qty("0.8", "mV")$

  == 平板电离室漂移时间

  + 电子的漂移时间为 $qty("0.5", "us")$, 正离子为 $qty("0.5", "ms")$.
  + 还是会产生电流, 因为电子漂移完后, 离子还在漂移, 产生离子尾巴.

  = 第三周作业

  == 信号变换

  $e^(j 10t)$ 的周期为 $2pi/10=pi/5$.

  $(5sin(8t))^2prop 1/2-cos(16t)/2$. 从而周期为 $pi/8$.


  记 $r()$ 为反褶, $w(x)$ 为向右移动 $x$. $h(ka)$ 为伸缩 $ka$ 倍, 有

  $ f(-3t-2) = h(3) r() w(2) f(t) $

  从而函数曲线为:

  #canvas(lq.diagram(
    xlabel: [$t$],
    ylabel: [$f(-3t-2)$],
    lq.path((-2 / 3, 0), (-2 / 3, 1), (-1, 0), (-1, 1), (-4 / 3, 0)),
  ))

  下列波形的函数式为:

  $ f(t)=1-abs(t/2), abs(t)<2 $

  == 信号与系统

  + $ int_(-inft)^(+inft) f(t-t_0) kd(t) dd(t)=f(-t_0) $
  + $ int_(-inft)^(+inft) e^(-j ko t)(kd(t)-kd(t-t_0)) dd(t) =1-e^(-j ko t_0) $

  + $r(t)=e(t)u(t)$ 线性, 时变, 因果
  + $r(t)=e(1-t)$ 线性, 时变, 非因果
  + $r(t)=e(2t)$ 线性, 时变, 非因果
  + $r(t)=int_(-inft)^(5t) e(tau) dd(tau)$ 线性, 时变, 非因果

  考虑第二个输入是第一个输入的导数:
  $ r_2 (t)=dv(r_1, t) =e^(-a t)delta(t)-a e^(-a t) u(t) $

  == 周期信号与傅里叶变换

  谱线间隔就是基频 $f=1/T$, 间隔 1 MHz.

  带宽在第一零点位置, $f_B=1/tau$, 为 2 MHz.

  因为是偶函数, 从而只有余弦项.
  $
    a_n = 2/T int_(-tau/2)^(tau/2) E cos(n ko t) dd(t) = (2E)/(n pi) sin((n pi)/2)
  $

  从而基波与三次谐波的幅度比为
  $ 2/pi \/(2/(3pi)) = 3 $

  #let x = lq.linspace(1, 8, num: 8)
  #canvas(lq.diagram(
    xlabel: [$n$],
    ylabel: [$a_n$],
    lq.plot(x, x => 2 / x / calc.pi * calc.sin((calc.pi * x) / 2)),
  ))
]

#hw
