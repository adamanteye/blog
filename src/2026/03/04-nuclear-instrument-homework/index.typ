#import "/page.typ": *
#import "meta.typ": desc, title
#show: conf.with(title: title, desc: desc)

#let hw = [
  = 第二周作业
  == 问答题

  请描述说明 $kb$ 谱仪和 $kg$ 谱仪存在哪些不同.

  对象不同, $kb$ 谱仪测量(正)电子的能量分布, $kg$ 谱仪测量光谱.
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
  $ r_2 (t)=dv(r_1, t) =e^(-a t)kd(t)-a e^(-a t) u(t) $

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

  = 第五周作业

  == 1

  特征方程为
  $
    kl^2 + 2 kl + 2 = 0
  $

  解得
  $
    kl_1 = -1 + j, quad kl_2 = -1 - j
  $

  故零输入响应可写为
  $
    r_"zi"(t) = e^(-t)(C_1 cos t + C_2 sin t) u(t)
  $

  由初始条件 $r(0_+) = 1$ 可得 $C_1 = 1$.

  再对上式求导:
  $
    r'_"zi"(t) = e^(-t)((C_2 - C_1) cos t - (C_1 + C_2) sin t) u(t)
  $

  由 $r'(0_+) = 2$ 得
  $
    C_2 - C_1 = 2
  $

  故 $C_2 = 3$.

  因此系统的零输入响应为
  $
    r_"zi"(t) = e^(-t)(cos t + 3 sin t) u(t)
  $

  == 2

  在零初始条件下取拉氏变换, 有
  $
    s^2 R(s) + s R(s) + R(s) = s E(s) + E(s)
  $

  故系统函数为
  $
    H(s) = R(s) / E(s) = (s + 1) / (s^2 + s + 1)
  $

  将分母配方:
  $
    s^2 + s + 1 = (s + 1/2)^2 + 3/4
  $

  于是
  $
    H(s)
    = (s + 1/2) / ((s + 1/2)^2 + (sqrt(3)/2)^2)
    + (1/2) / ((s + 1/2)^2 + (sqrt(3)/2)^2)
  $

  所以冲激响应为
  $
    h(t)
    = e^(-t/2)
    cos((sqrt(3)/2) t) + 1/sqrt(3) sin((sqrt(3)/2) t)
    u(t)
  $

  == 3

  题中系统满足
  $
    dv(r, t) + 5 r(t) = int_(-inft)^(+inft) e(tau) f(t - tau) d tau - e(t)
  $

  其中
  $
    f(t) = e^(-t) u(t) + 3 kd(t)
  $

  注意到
  $
    int_(-inft)^(+inft) e(tau) f(t - tau) d tau = (e * f)(t)
  $

  在零初始条件下取拉氏变换:
  $
    s R(s) + 5 R(s) = E(s) F(s) - E(s)
  $

  而
  $
    F(s) = 1/(s + 1) + 3
  $

  故
  $
    H(s) = R(s) / E(s) = (F(s) - 1) / (s + 5)
  $

  即
  $
    H(s)
    = (1/(s + 1) + 2) / (s + 5)
    = (2 s + 3) / ((s + 1)(s + 5))
  $

  将其展开为部分分式:
  $
    (2 s + 3) / ((s + 1)(s + 5))
    = 1/(4 (s + 1)) + 7/(4 (s + 5))
  $

  因此单位冲激响应为
  $
    h(t) = (1/4 e^(-t) + 7/4 e^(-5 t)) u(t)
  $

  == 4

  === (a)

  由图可知
  $
    f_2(t) = kd(t + 2) + kd(t - 2)
  $

  因此
  $
    (f_1 * f_2)(t) = f_1(t + 2) + f_1(t - 2)
  $

  原函数 $f_1(t)$ 由两个单位三角波组成, 分别以 $t = -2$ 和 $t = 2$ 为中心.
  所以卷积结果由 3 个三角波组成:

  + 在 $[-5, -3]$ 上, 是一个峰值为 $1$ 的三角波, 中心在 $t = -4$.
  + 在 $[-1, 1]$ 上, 是一个峰值为 $2$ 的三角波, 中心在 $t = 0$.
  + 在 $[3, 5]$ 上, 是一个峰值为 $1$ 的三角波, 中心在 $t = 4$.

  可写成
  $
    (f_1 * f_2)(t)
    = (1 - abs(t + 4))(u(t + 5) - u(t + 3))
    + 2 (1 - abs(t))(u(t + 1) - u(t - 1))
    + (1 - abs(t - 4))(u(t - 3) - u(t - 5))
  $

  === (b)

  由图可写
  $
    f_1(t) = 2 (u(t) - u(t - 1))
  $

  $
    f_2(t) = sin t (u(t) - u(t - pi))
  $

  故
  $
    (f_1 * f_2)(t)
    = 2 int_(max(0, t - pi))^(min(1, t)) sin(t - tau) d tau
  $

  分段计算如下:

  + 当 $t < 0$ 或 $t > pi + 1$ 时, 两函数无重叠,
    $
      (f_1 * f_2)(t) = 0
    $

  + 当 $0 <= t < 1$ 时,
    $
      (f_1 * f_2)(t)
      = 2 int_0^t sin(t - tau) d tau
      = 2 (1 - cos t)
    $

  + 当 $1 <= t < pi$ 时,
    $
      (f_1 * f_2)(t)
      = 2 int_0^1 sin(t - tau) d tau
      = 2 (cos(t - 1) - cos t)
    $

  + 当 $pi <= t < pi + 1$ 时,
    $
      (f_1 * f_2)(t)
      = 2 int_(t - pi)^1 sin(t - tau) d tau
      = 2 (cos(t - 1) + 1)
    $

  因此
  $
    (f_1 * f_2)(t) =
    cases(
      0 quad t < 0,
      2 (1 - cos t) quad 0 <= t < 1,
      2 (cos(t - 1) - cos t) quad 1 <= t < pi,
      2 (cos(t - 1) + 1)quad pi <= t < pi + 1,
      0 quad t >= pi + 1,
    )
  $

  == 5

  + $1 - e^(-a t)$,
    $
      cal(L){1 - e^(-a t)}
      = 1/s - 1/(s + a)
      = a / (s (s + a))
    $

  + $sin t + 2 cos t$,
    $
      cal(L){sin t + 2 cos t}
      = 1/(s^2 + 1) + 2 s/(s^2 + 1)
      = (2 s + 1)/(s^2 + 1)
    $

  + $(1 + 2 t)e^(-t)$,
    $
      cal(L){(1 + 2 t)e^(-t)}
      = 1/(s + 1) + 2/(s + 1)^2
      = (s + 3)/(s + 1)^2
    $

  == 6

  + $1 / (s (s^2 + 5))$,

    先做部分分式展开:
    $
      1 / (s (s^2 + 5))
      = 1/5 (1/s - s/(s^2 + 5))
    $

    故其拉氏逆变换为
    $
      cal(L)^(-1){1 / (s (s^2 + 5))}
      = 1/5 (1 - cos(sqrt(5) t)) u(t)
    $

  + $3 s / ((s + 4)(s + 2))$,

    部分分式展开为
    $
      3 s / ((s + 4)(s + 2))
      = 6/(s + 4) - 3/(s + 2)
    $

    故其拉氏逆变换为
    $
      cal(L)^(-1){3 s / ((s + 4)(s + 2))}
      = (6 e^(-4 t) - 3 e^(-2 t)) u(t)
    $

  = 第八次作业

  == 伽马能谱分析

  由题图可知, $isotope("Th", a: 228)$ 主要通过 $ka$ 衰变布居
  $isotope("Ra", a: 224)$ 的 $num("0")$, $qty("84.43", "keV")$,
  $qty("215.99", "keV")$, $qty("250.78", "keV")$, $qty("290.32", "keV")$ 等能级.
  低激发能级的退激 $kg$ 射线主要由这些能级差决定:

  + $qty("84.4", "keV")$: $num("84.43") -> num("0")$, 是最强的一条谱线;
  + $qty("131.6", "keV")$: $num("215.99") -> num("84.43")$;
  + $qty("166.4", "keV")$: $num("250.78") -> num("84.43")$;
  + $qty("205.9", "keV")$: $num("290.32") -> num("84.43")$;
  + $qty("216.0", "keV")$: $num("215.99") -> num("0")$;
  + $qty("74.3", "keV")$: $num("290.32") -> num("215.99")$, 这一支很弱.

  因此可认为该核素的低能 $kg$ 能谱由以上几条离散谱线组成. 其中
  $qty("84.4", "keV")$ 为主峰, $qty("216.0", "keV")$ 次之, $qty("131.6", "keV")$
  与 $qty("166.4", "keV")$ 为中等强度, $qty("205.9", "keV")$ 和
  $qty("74.3", "keV")$ 较弱.

  下面给出定性棒状谱, 仅表示相对强弱关系:

  #canvas(
    lq.diagram(
      xlabel: [$E_kg unit("keV")$],
      ylabel: [relative intensity],
      xlim: (60, 230),
      ylim: (0, 1.05),
      lq.path((74.3, 0), (74.3, 0.02)),
      lq.path((84.4, 0), (84.4, 1.00)),
      lq.path((131.6, 0), (131.6, 0.52)),
      lq.path((166.4, 0), (166.4, 0.42)),
      lq.path((205.9, 0), (205.9, 0.10)),
      lq.path((216.0, 0), (216.0, 0.72)),
    ),
  )

  == 平行板电离室阳极感应电流

  取阳极感应电流流入前放大器为正. 由沉积能量与平均电离能可得产生的电子-离子对数

  $
    E_"dep" = qty("1", "MeV"), quad w = qty("25", "eV"), quad
    N = num("1e6") / num("25") = num("4.0e4")
  $

  对应总电荷量

  $
    Q_0 = N e = num("4.0e4") times num("1.602e-19")
    approx qty("6.41e-15", "C")
  $

  平行板电离室中电场近似均匀, 故

  $
    V = qty("1000", "V"), quad d = qty("10", "mm") = qty("0.01", "m"), quad
    E = V/d = num("1000") / num("0.01") approx qty("1.0e5", "V/m")
  $

  电子与正离子迁移率分别为

  $
    mu_e = qty("2e3", "cm^2 V^-1 s^-1") = qty("0.2", "m^2 V^-1 s^-1")
  $

  $
    mu_i = qty("2", "cm^2 V^-1 s^-1") = qty("2.0e-4", "m^2 V^-1 s^-1")
  $

  所以漂移速度为

  $
    v_e = mu_e E approx qty("2.0e4", "m/s")
  $

  $
    v_i = mu_i E approx qty("20", "m/s")
  $

  对阳极而言, 权电场为

  $
    E_w = num("1") / d = qty("100", "m^-1")
  $

  根据 Shockley-Ramo 定律, 单种载流子对阳极的感应电流大小为

  $
    i = q v E_w = (q v) / d
  $

  电子与正离子贡献同号, 因而总感应电流为两者之和.

  电子距阳极的距离为 $d - z_0 = qty("6", "mm")$, 正离子距阴极的距离为
  $z_0 = qty("4", "mm")$, 故收集时间分别为

  $
    t_e = (d - z_0) / v_e = num("6e-3") / num("2.0e4")
    approx qty("3.0e-7", "s") = qty("0.30", "us")
  $

  $
    t_i = z_0 / v_i = num("4e-3") / num("20")
    approx qty("2.0e-4", "s") = qty("200", "us")
  $

  电流大小分别为

  $
    i_e = (Q_0 v_e) / d
    approx qty("1.28e-8", "A")
  $

  $
    i_i = (Q_0 v_i) / d
    approx qty("1.28e-11", "A")
  $

  因此阳极感应电流的时间波形为

  $
    i_A(t) = cases(
      i_e + i_i approx qty("1.283e-8", "A") quad num("0") <= t < qty("0.30", "us"),
      i_i approx qty("1.28e-11", "A") quad qty("0.30", "us") <= t < qty("200", "us"),
      num("0") quad t >= qty("200", "us"),
    )
  $

  也就是说, 前面是一个约 $qty("12.8", "nA")$ 的快电子脉冲, 随后跟着一个约
  $qty("12.8", "pA")$
  的长离子尾巴.

  == 栅极电离室阳极感应电流

  理想栅极电离室中, 对阳极的权电势可取为

  $
    phi_w(z) = cases(
      num("0") quad num("0") <= z <= d_1,
      (z - d_1) / (d - d_1) quad d_1 < z <= d,
    )
  $

  因此权电场为

  $
    E_w(z) = cases(
      num("0") quad num("0") <= z <= d_1,
      num("1") / (d - d_1) quad d_1 < z <= d,
    )
  $

  题中

  $
    d = qty("10", "mm"), quad d_1 = qty("9", "mm"), quad d - d_1 = qty("1", "mm")
  $

  而实际漂移电场在两区都是

  $
    (num("1000") - num("900")) / qty("1", "mm")
    = num("900") / qty("9", "mm")
    approx qty("1.0e5", "V/m")
  $

  所以载流子漂移速度仍为

  $
    v_e approx qty("2.0e4", "m/s"), quad v_i approx qty("20", "m/s")
  $

  === 电离发生在栅极下方

  此时电离位置在栅极下方, 即 $z_0 < d_1$. 在电子越过栅极之前, 阳极的权电场为零,
  因而阳极上没有感应信号.

  当 $z_0 = qty("4", "mm")$ 时, 电子从电离位置漂移到栅极 $z = qty("9", "mm")$
  所需时间为

  $
    t_1 = (d_1 - z_0) / v_e
    = num("5e-3") / num("2.0e4")
    approx qty("2.5e-7", "s")
    = qty("0.25", "us")
  $

  电子再从栅极漂移到阳极所需时间

  $
    t_2 = (d - d_1) / v_e
    = num("1e-3") / num("2.0e4")
    approx qty("5.0e-8", "s")
    = qty("0.05", "us")
  $

  在阳极-栅极间隙内的感应电流大小为

  $
    i_A = (Q_0 v_e) / (d - d_1)
    = (num("6.41e-15") times num("2.0e4")) / num("1.0e-3")
    approx qty("1.28e-7", "A")
  $

  故阳极电流为

  $
    i_A(t) = cases(
      num("0") quad num("0") <= t < qty("0.25", "us"),
      qty("1.28e-7", "A") quad qty("0.25", "us") <= t < qty("0.30", "us"),
      num("0") quad t >= qty("0.30", "us"),
    )
  $

  即只有一个宽度约 $qty("50", "ns")$, 高度约 $qty("128", "nA")$ 的快脉冲,
  基本没有离子尾巴.

  === 电离发生在栅极与阳极之间

  当 $z_0 = qty("9.5", "mm")$ 时, 电离位置位于栅极与阳极之间,
  因此电子和正离子一产生就都在权电场区域内.

  电子到达阳极的时间为

  $
    t_e = (d - z_0) / v_e
    = num("0.5e-3") / num("2.0e4")
    approx qty("2.5e-8", "s")
    = qty("25", "ns")
  $

  正离子到达栅极的时间为

  $
    t_i = (z_0 - d_1) / v_i
    = num("0.5e-3") / num("20")
    approx qty("2.5e-5", "s")
    = qty("25", "us")
  $

  所以

  $
    i_e = (Q_0 v_e) / (d - d_1) approx qty("1.28e-7", "A")
  $

  $
    i_i = (Q_0 v_i) / (d - d_1) approx qty("1.28e-10", "A")
  $

  阳极电流波形为

  $
    i_A(t) = cases(
      i_e + i_i approx qty("1.283e-7", "A") quad num("0") <= t < qty("25", "ns"),
      i_i approx qty("1.28e-10", "A") quad qty("25", "ns") <= t < qty("25", "us"),
      num("0") quad t >= qty("25", "us"),
    )
  $

  因此, 当电离发生在栅极上方时, 阳极仍会看到一个较弱但可见的离子尾巴.

  == 硅探测器耗尽与电场

  这是一个一侧突变结近似下的 $p^+ n^-$ 探测器. 取 n 区厚度

  $
    d = qty("0.3", "mm") = qty("3.0e-4", "m")
  $

  $
    N_D = qty("1e12", "cm^-3") = qty("1e18", "m^-3")
  $

  $
    ke_"Si" = num("11.7") ke_0
    approx qty("1.04e-10", "F/m")
  $

  === 全耗尽电压

  忽略内建电势相对于几十伏量级的影响, 全耗尽电压为

  $
    V_"fd" = (q N_D d^2) / (2 ke_"Si")
  $

  代入得

  $
    V_"fd"
    = ((num("1.602e-19")) (num("1e18")) (num("3.0e-4"))^2)
    / (num("2") times num("1.04e-10"))
    approx qty("69.6", "V")
  $

  所以全耗尽电压约为

  $
    V_"fd" approx qty("70", "V")
  $

  === 反向偏压 $qty("200", "V")$ 时的电场分布

  由于 $qty("200", "V") > V_"fd"$, 探测器已完全耗尽, 并处于过耗尽状态.
  若以左侧背电极为 $x = num("0")$, 右侧 $p^+$ 阳极为 $x = d$, 则电场强度大小满足

  $
    (d |E|) / (d x) = (q N_D) / ke_"Si"
  $

  并且

  $
    int_(num("0"))^d |E(x)| d x = V_R
  $

  故有

  $
    |E(x)|
    = (V_R - V_"fd") / d + (q N_D x) / ke_"Si"
  $

  其中 $V_R = qty("200", "V")$, 所以

  $
    E_0 approx qty("4.35e5", "V/m"), quad
    S approx qty("1.55e9", "V/m^2"), quad
    |E(x)| approx E_0 + S x
  $

  这里 $x$ 用 $unit("m")$ 为单位, $|E|$ 用 $unit("V/m")$ 为单位.

  因此

  $
    |E(0)| approx qty("4.35e5", "V/m")
  $

  $
    |E(d)| approx qty("8.99e5", "V/m")
  $

  故电场强度在背电极处最小, 向 $p^+$ 阳极线性增大, 形状是一个带底座的三角形.

  === 阳极的权电场分布

  平板型探测器中, 阳极权电势满足

  $
    phi_w(x) = x / d
  $

  因此阳极权电场为常数

  $
    E_w = (d phi_w) / (d x) = num("1") / d
    = num("1") / qty("3.0e-4", "m")
    approx qty("3.33e3", "m^-1")
  $

  也就是说, 阳极的权电场在整个厚度内都是均匀不变的.

  #canvas(
    grid(
      columns: 2,
      lq.diagram(
        xlabel: [$x unit("mm")$],
        ylabel: [$|E(x)| unit("V/m")$],
        xlim: (0, 0.3),
        ylim: (0, 1.0e6),
        lq.path((0.0, 4.35e5), (0.3, 8.99e5)),
      ),
      lq.diagram(
        xlabel: [$x unit("mm")$],
        ylabel: [$E_w unit("m^-1")$],
        xlim: (0, 0.3),
        ylim: (0, 4.0e3),
        lq.path((0.0, 3.33e3), (0.3, 3.33e3)),
      ),
    ),
  )

  == 载流子俘获时的输出电荷

  设产生了 $n$ 对电子-空穴对. 图中载流子产生位置距离阳极为 $D/4$,
  因此若从左侧背电极起算, 产生位置为

  $
    x_0 = (num("3") D) / num("4")
  $

  对右侧阳极而言, 权电势为

  $
    phi_w(x) = x / D
  $

  所以初始权电势

  $
    phi_w(x_0) = num("3") / num("4")
  $

  根据 Shockley-Ramo 定理, 单个载流子在阳极上感应出的电荷量大小为

  $
    kD Q = abs(q) abs(phi_w(x_f) - phi_w(x_i))
  $

  === 电子和空穴全部被收集

  电子漂移到阳极, 因而单个电子贡献

  $
    kD Q_e = e (num("1") - (num("3") / num("4"))) = e / num("4")
  $

  空穴漂移到背电极, 单个空穴贡献

  $
    kD Q_h = e ((num("3") / num("4")) - num("0")) = (num("3") e) / num("4")
  $

  故总输出电荷量为

  $
    kD Q = n (kD Q_e + kD Q_h) = n e
  $

  === 电子全部被收集, 空穴仅有 $num("50")%$ 被收集

  电子仍全部贡献

  $
    (n e) / num("4")
  $

  只有一半空穴到达背电极, 另一半产生后立刻被俘获, 近似不产生漂移感应电荷.
  因此空穴贡献为

  $
    num("0.5") times ((num("3") n e) / num("4")) = (num("3") n e) / num("8")
  $

  故

  $
    kD Q = (n e) / num("4") + (num("3") n e) / num("8") = (num("5") n e) / num("8")
  $

  === 电子全部被收集, 空穴仅有 $num("10")%$ 被收集

  同理可得

  $
    kD Q = (n e) / num("4") + num("0.1") times ((num("3") n e) / num("4"))
    = ((num("1") / num("4")) + (num("3") / num("40"))) n e
    = (num("13") n e) / num("40")
  $

  所以三种情况下阳极输出电荷量分别为

  $
    kD Q = n e, quad (num("5") n e) / num("8"), quad (num("13") n e) / num("40")
  $

  对应前置放大器输出电压幅度为

  $
    kD V = (kD Q) / C
  $

  因此空穴俘获越严重, 脉冲幅度越小.


  = 第九次作业

  == 1

  设输入矩形电流脉冲为
  $
    i_s(t) = I_0 (u(t) - u(t - t_w))
  $

  并联 $"RC"$ 电路满足
  $
    C (d v) / (d t) + v/R = i_s(t)
  $

  因此在脉冲作用期间 $0 < t < t_w$,
  $
    v(t) = I_0 R (1 - e^(-t/(R C)))
  $

  在脉冲结束后 $t > t_w$,
  $
    v(t) = I_0 R (1 - e^(-t_w/(R C))) e^(-(t - t_w)/(R C))
  $

  + 当 $t_w$ 远小于 $R C$ 时, 指数项可展开为 $e^(-t/(R C)) approx 1 - t/(R C)$,
    因而
    $
      v(t) approx (I_0/C) t, quad 0 < t < t_w
    $
    即输出近似线性上升到
    $
      v_"max" approx I_0 t_w / C = Q/C
    $
    随后按时间常数 $R C$ 指数衰减. 这时波形近似为窄三角脉冲.

  + 当 $t_w$ 远大于 $R C$ 时, 输出先在约几个 $R C$ 内快速上升并趋近于稳态值
    $
      v approx I_0 R
    $
    在脉冲持续的大部分时间里近似保持平台. 脉冲结束后再以时间常数 $R C$ 指数下降.
    这时波形近似为圆角矩形脉冲.

    #let xs = lq.linspace(0, 6)
    #let v_short(t) = {
      if t < 1 {
        t
      } else {
        calc.exp(-(t - 1))
      }
    }
    #let v_long(t) = {
      if t < 4 {
        1 - calc.exp(-t)
      } else {
        (1 - calc.exp(-4)) * calc.exp(-(t - 4))
      }
    }

    #canvas(
      grid(
        columns: 2,
        lq.diagram(
          xlabel: [normalized $t$],
          ylabel: [normalized $v$],
          xlim: (0, 6),
          ylim: (0, 1.1),
          lq.plot(xs, v_short),
        ),
        lq.diagram(
          xlabel: [normalized $t$],
          ylabel: [normalized $v$],
          xlim: (0, 6),
          ylim: (0, 1.1),
          lq.plot(xs, v_long),
        ),
      ),
    )

  == 2

  由外特性曲线可直接读出 3 个区间的电压增益, 即各段斜率
  $
    K = dv_o / d v_i
  $

  在 $(-b, -a)$ 区间,
  $
    K_1 = (A - B) / (b - a) = (1.0 - 1.4) / (3 - 1) "V/mV" = -200
  $

  在 $(-a, a)$ 区间,
  $
    K_2 = (-A - A) / (a - (-a)) = (-1.0 - 1.0) / 2 "V/mV" = -1000
  $

  在 $(a, b)$ 区间,
  $
    K_3 = (-B - (-A)) / (b - a) = (-1.4 + 1.0) / 2 "V/mV" = -200
  $

  反馈电容在输入端的密勒等效值为
  $
    C_M = C_f (1 - K)
  $

  于是
  $
    C_"M1" = C_"M3" = num("1") times (1 - (-200)) = qty("201", "pF")
  $

  $
    C_"M2" = num("1") times (1 - (-1000)) = qty("1001", "pF")
  $

  若把输入端本身电容 $C_i = qty("10", "pF")$ 也计入, 则 3
  个区间的总等效输入电容分别为
  $
    C_"in,1" = C_"in,3" = qty("211", "pF"), quad
    C_"in,2" = qty("1011", "pF")
  $

  当 $v_i$ 初始为 0 且输入电流 $i_s$ 由小变大时, 由于电流源方向向下,
  输入节点电压 $v_i$ 逐渐变负, 工作点沿外特性曲线从原点向左移动:

  + 起初处于 $(-a, a)$ 区间, 增益最大, 因而 $v_o$ 近似按高斜率快速上升.
  + 当 $v_i < -a$ 后进入 $(-b, -a)$ 区间, 斜率减小为 $-200$, $v_o$
    继续上升但速度明显变慢.
  + 当 $v_i < -b$ 后输出进入正饱和, $v_o approx B = qty("1.4", "V")$, 再增大
    $i_s$ 也几乎不再上升.

  也就是说, 输出电压随输入电流增大经历"快增益区 -> 慢增益区 -> 饱和区"的变化.

  == 3

  图中反馈网络为
  $
    R_2 = qty("1000", "Mohm"), quad C_2 = qty("1", "pF"), quad A = num("1e4")
  $

  输入端还并联有
  $
    R_1 = qty("100", "Mohm"), quad C_1 = qty("2000", "pF")
  $

  由于
  $
    v_o = -A v_i
  $

  反馈电阻和反馈电容在输入端的等效值分别为
  $
    R_"f,eq" = R_2 / (1 + A), quad C_"f,eq" = (1 + A) C_2
  $

  故整个放大器的等效输入阻抗
  $
    Z_i = R_i // (1/(s C_i))
  $

  其中
  $
    R_i = R_1 // R_"f,eq"
  $

  $
    C_i = C_1 + C_"f,eq"
  $

  代入数值得
  $
    R_"f,eq" = 1000 / 10001 " Mohm" approx qty("0.100", "Mohm")
  $

  $
    R_i = qty("100", "Mohm") // qty("0.100", "Mohm")
    approx qty("9.99e4", "ohm")
  $

  $
    C_i = qty("2000", "pF") + num("10001") times qty("1", "pF")
    = qty("12001", "pF") approx qty("12.0", "nF")
  $

  所以等效输入阻抗可写为
  $
    Z_i approx qty("99.9", "kohm") // qty("12.0", "nF")
  $

  == 4

  === (1)

  左图为反相放大器, 有
  $
    v_o = A (0 - v_-) = -A v_-
  $

  在反相输入节点列 KCL:
  $
    (v_i - v_-) / R_2 + (v_o - v_-) / R_1 = 0
  $

  代入 $v_- = -v_o / A$ 后得闭环增益
  $
    v_o / v_i = - A R_1 / (R_1 + (A + 1) R_2)
  $

  代入 $R_1 = qty("100", "kohm"), R_2 = qty("1", "kohm"), A = 1000$,
  $
    v_o / v_i = -1000 times 100 / (100 + 1001) approx -90.83
  $

  === (2)

  右图为同相放大器. 反馈系数
  $
    beta = R_2 / (R_1 + R_2) = 1 / 100
  $

  且
  $
    v_o = A (v_i - beta v_o)
  $

  所以闭环增益
  $
    v_o / v_i = A / (1 + A beta)
  $

  代入 $A = 1000, beta = 0.01$,
  $
    v_o / v_i = 1000 / (1 + 10) approx 90.91
  $

  故两种电路在有限开环增益下的闭环放大倍数分别为
  $
    K_1 approx -90.83, quad K_2 approx 90.91
  $

  == 5

  设反相输入节点电压为 $v_i$, 输出电压为 $v_o$. 左侧运放输出为 $-A v_i$, 中间
  $R C$ 网络满足
  $
    (-A v_i - v_o) / R
    = C (d v_o) / (d t) + C_f (d (v_o - v_i)) / (d t)
  $

  输入端列 KCL:
  $
    i(t) = C_i (d v_i) / (d t) + C_f (d (v_i - v_o)) / (d t)
  $

  在拉氏域令 $i(t) = Q kd(t)$, 即 $I(s) = Q$, 可解得
  $
    V_o(s) = -Q (A - R C_f s) / (s (C_T + K s))
  $

  其中记
  $
    C_T = C_i + (1 + A) C_f
  $

  $
    K = R (C_i C + C_i C_f + C C_f)
  $

  将其写成部分分式可得
  $
    V_o(s) = -Q (
      A/C_T 1/s
      - (R C_f + A K / C_T) / (K (s + C_T / K))
    )
  $

  因此时域表达式为
  $
    v_o(t) = -Q (
      A / C_T
      - (R C_f / K + A / C_T) e^(-t/tau)
    ) u(t)
  $

  其中
  $
    tau = K / C_T
  $

  若满足 $(1 + A) C_f$ 远大于 $C_i$,

  则
  $
    C_T approx (1 + A) C_f, quad
    tau approx R C / (1 + A)
  $

  而稳态幅度
  $
    lim_(t -> oo) v_o(t) approx - A Q / ((1 + A) C_f) approx -Q / C_f
  $

  故可写成近似形式
  $
    v_o(t) approx -Q / C_f (1 - e^(-t/tau)) u(t), quad
    tau approx R C / (1 + A)
  $

  波形上表现为: 输出从接近 0 开始快速上升, 经过约几个 $tau$ 后稳定到 $-Q/C_f$.

  若在 $C_f$ 两端并联 $R_f$, 且 $R_f C_f$ 远大于 $R C$,

  则快上升过程基本不变, 但反馈电容上的电荷会通过 $R_f$ 缓慢泄放,
  输出不再长期保持平台, 而是在到达峰值后按较长时间常数
  $
    tau_f approx R_f C_f
  $
  缓慢回到基线. 因此波形由"快上升 + 平顶"变为"快上升 +
  慢恢复"的典型电荷灵敏前放脉冲.

  == 6

  电荷灵敏前放的闭环上限频率近似为
  $
    f_H approx "GBW" / (1 + C_i / C_f)
  $

  于是上升时间
  $
    t_r approx 0.35 / f_H = 0.35 (1 + C_i / C_f) / "GBW"
  $

  逐项代入:

  + $(1)$
    $
      t_r = 0.35 times (1 + 10/1) / num("1e9")
      approx qty("3.85", "ns")
    $

  + $(2)$
    $
      t_r = 0.35 times (1 + 10/2) / num("1e9")
      approx qty("2.10", "ns")
    $

  + $(3)$
    $
      t_r = 0.35 times (1 + 10/1) / (num("2e9"))
      approx qty("1.93", "ns")
    $

  + $(4)$
    $
      t_r = 0.35 times (1 + 10/2) / (num("0.5e9"))
      approx qty("4.20", "ns")
    $

  == 7

  记输入节点为 $v_i$, 输出节点为 $v_o$. 跨导放大器满足
  $
    i_o = G (v_+ - v_-) = -G v_i
  $

  其中
  $
    G = qty("10", "mA/V") = qty("0.01", "S")
  $

  图中参数为
  $
    C_i = qty("100", "pF"), quad C_f = qty("1", "pF"), quad
    C = qty("10", "pF"), quad R = qty("500", "kohm")
  $

  输入端与输出端列方程可得该系统的主时间常数近似为
  $
    tau approx (C_i C + C_i C_f + C C_f) / (C_f G + (C_i + C_f)/R)
  $

  代入数值:
  $
    C_i C + C_i C_f + C C_f
    = (100 times 10 + 100 times 1 + 10 times 1) "pF"^2
    = qty("1110", "pF^2")
  $

  $
    C_f G = qty("1e-12", "F") times qty("0.01", "S") = qty("1.0e-14", "F/s")
  $

  $
    (C_i + C_f)/R = qty("101e-12", "F") / qty("500e3", "ohm")
    approx qty("2.02e-16", "F/s")
  $

  由于 $C_f G$ 远大于 $(C_i + C_f)/R$,

  故
  $
    tau approx (qty("1110e-24", "F^2")) / (qty("1.02e-14", "F/s"))
    approx qty("1.09e-7", "s")
    = qty("109", "ns")
  $

  于是输出电压的上升时间估算为
  $
    t_r approx 2.2 tau approx qty("2.4e-7", "s") = qty("240", "ns")
  $

  因此该跨导前放的输出上升时间约为
  $
    t_r approx qty("0.24", "us")
  $
]

#hw
