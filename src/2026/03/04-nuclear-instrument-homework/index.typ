#import "/page.typ": *
#import "meta.typ": desc, title
#show: conf.with(title: title, desc: desc)

#let hw = [
  = 第二周作业
  == 问答题

  $kb$ 谱仪测量电子或正电子的能量分布, $kg$ 谱仪测量光子能谱.
  前者依赖带电粒子在介质中的电离和激发损失. 后者依赖光电效应,
  康普顿散射和电子对产生.

  == 平板电离室

  电子和正离子分别向阳极和阴极漂移, 两极板感应电流极性相反. 定义: 电离对数
  $N=num("5e4")$, 总电荷 $Q=N e approx qty("8.01e-15", "C")$. 若输入电容为 $C$,
  最大电压幅度 $V_"max"=Q/C approx qty("0.8", "mV")$.

  == 平板电离室漂移时间

  电子漂移时间约 $qty("0.5", "us")$, 正离子约 $qty("0.5", "ms")$.
  电子被收集后离子仍在漂移, 因而感应电流不会立即消失, 而是形成离子尾.

  = 第三周作业

  == 信号变换

  $e^(j 10t)$ 的周期 $T=2 pi/10=pi/5$. 形式:
  $(5 sin(8t))^2 prop 1/2-cos(16t)/2$, 因而周期 $T=pi/8$. 记 $r()$ 为反褶,
  $w(x)$ 为右移 $x$, $h(ka)$ 为横向压缩 $ka$ 倍, 则 $f(-3t-2)=h(3)r()w(2)f(t)$.
  函数曲线为:

  #canvas(lq.diagram(
    xlabel: [$t$],
    ylabel: [$f(-3t-2)$],
    lq.path((-2 / 3, 0), (-2 / 3, 1), (-1, 0), (-1, 1), (-4 / 3, 0)),
  ))

  下列波形的函数式为 $f(t)=1-abs(t/2)$, $abs(t)<2$.

  == 信号与系统

  冲激筛选给出 $int_(-inft)^(+inft) f(t-t_0) kd(t) dif t=f(-t_0)$. 对
  $kd(t)-kd(t-t_0)$, 傅里叶积分为
  $int_(-inft)^(+inft) e^(-j ko t)(kd(t)-kd(t-t_0)) dif t=1-e^(-j ko t_0)$.

  系统分类: $r(t)=e(t)u(t)$ 线性, 时变, 因果. $r(t)=e(1-t)$ 线性, 时变, 非因果.
  $r(t)=e(2t)$ 线性, 时变, 非因果. $r(t)=int_(-inft)^(5t) e(tau) dif tau$ 线性,
  时变, 非因果. 若第二个输入为第一个输入的导数, 则
  $r_2(t)=dv(r_1, t)=e^(-a t)kd(t)-a e^(-a t)u(t)$.

  == 周期信号与傅里叶变换

  谱线间隔为基频 $f_0=1/T=qty("1", "MHz")$. 第一零点给出带宽
  $f_B=1/tau=qty("2", "MHz")$. 波形为偶函数, 只有余弦项:
  $a_n=(2/T) int_(-tau/2)^(tau/2) E cos(n ko t) dif t=(2E)/(n pi) sin(n pi/2)$.
  基波与三次谐波的幅度比为 $(2/pi)/(2/(3 pi))=3$.

  #let x = lq.linspace(1, 8, num: 8)
  #canvas(lq.diagram(
    xlabel: [$n$],
    ylabel: [$a_n$],
    lq.plot(x, x => 2 / x / calc.pi * calc.sin((calc.pi * x) / 2)),
  ))

  = 第五周作业

  == 1

  特征方程 $kl^2+2kl+2=0$, 根为 $kl_1=-1+j$, $kl_2=-1-j$. 定义零输入响应
  $r_"zi"(t)=e^(-t)(C_1 cos t+C_2 sin t)u(t)$. 由 $r(0_+)=1$ 得 $C_1=1$. 求导:
  $r'_"zi"(t)=e^(-t)((C_2-C_1)cos t-(C_1+C_2)sin t)u(t)$. 由 $r'(0_+)=2$ 得
  $C_2-C_1=2$, 即 $C_2=3$. 因而 $r_"zi"(t)=e^(-t)(cos t+3 sin t)u(t)$.

  == 2

  零初始条件下取拉氏变换: $s^2 R(s)+s R(s)+R(s)=s E(s)+E(s)$. 系统函数
  $H(s)=R(s)/E(s)=(s+1)/(s^2+s+1)$, 且 $s^2+s+1=(s+1/2)^2+3/4$. 形式:
  $
    H(s)
    = (s + 1/2) / ((s + 1/2)^2 + (sqrt(3)/2)^2)
    + (1/2) / ((s + 1/2)^2 + (sqrt(3)/2)^2)
  $

  所以冲激响应:
  $
    h(t)
    = e^(-t/2)
    cos((sqrt(3)/2) t) + 1/sqrt(3) sin((sqrt(3)/2) t)
    u(t)
  $

  == 3

  题中系统满足
  $dv(r, t)+5 r(t)=int_(-inft)^(+inft)e(tau) f(t-tau) dif tau-e(t)$, 其中
  $f(t)=e^(-t)u(t)+3 kd(t)$. 积分项即卷积 $(e*f)(t)$. 零初始拉氏变换给出
  $s R(s)+5 R(s)=E(s)F(s)-E(s)$, 且 $F(s)=1/(s+1)+3$, 所以
  $H(s)=R(s)/E(s)=(F(s)-1)/(s+5)$. 即:
  $
    H(s)
    = (1/(s + 1) + 2) / (s + 5)
    = (2 s + 3) / ((s + 1)(s + 5))
  $

  部分分式展开:
  $
    (2 s + 3) / ((s + 1)(s + 5))
    = 1/(4 (s + 1)) + 7/(4 (s + 5))
  $

  因此单位冲激响应 $h(t)=(e^(-t)/4+7e^(-5t)/4)u(t)$.

  == 4

  === (a)

  由图可知 $f_2(t)=kd(t+2)+kd(t-2)$, 因而 $(f_1*f_2)(t)=f_1(t+2)+f_1(t-2)$.
  原函数由两个单位三角波组成, 中心在 $t=-2$ 与 $t=2$. 卷积后得到中心在 $-4,0,4$
  的三个三角波, 中间峰值为 $2$. 形式:
  $
    (f_1 * f_2)(t)
    = (1 - abs(t + 4))(u(t + 5) - u(t + 3))
    + 2 (1 - abs(t))(u(t + 1) - u(t - 1))
    + (1 - abs(t - 4))(u(t - 3) - u(t - 5))
  $

  === (b)

  由图可写 $f_1(t)=2(u(t)-u(t-1))$, $f_2(t)=sin t (u(t)-u(t-pi))$. 因而:
  $
    (f_1 * f_2)(t)
    = 2 int_(max(0, t - pi))^(min(1, t)) sin(t - tau) dif tau
  $

  即:
  $
    (f_1 * f_2)(t) =
    cases(
      0 "if" t < 0,
      2 (1 - cos t) "if" 0 <= t < 1,
      2 (cos(t - 1) - cos t) "if" 1 <= t < pi,
      2 (cos(t - 1) + 1) "if" pi <= t < pi + 1,
      0 "if" t >= pi + 1,
    )
  $

  == 5

  拉氏变换结果: $cal(L){1-e^(-a t)}=1/s-1/(s+a)=a/(s (s+a))$.
  $cal(L){sin t+2 cos t}=1/(s^2+1)+2 s/(s^2+1)=(2 s+1)/(s^2+1)$.
  $cal(L){(1+2 t)e^(-t)}=1/(s+1)+2/(s+1)^2=(s+3)/(s+1)^2$.

  == 6

  部分分式: $1/(s (s^2+5))=1/5 (1/s-s/(s^2+5))$, 所以
  $cal(L)^(-1){1/(s (s^2+5))}=1/5 (1-cos(sqrt(5) t))u(t)$. 又
  $3 s/((s+4)(s+2))=6/(s+4)-3/(s+2)$, 所以
  $cal(L)^(-1){3 s/((s+4)(s+2))}=(6 e^(-4t)-3 e^(-2t))u(t)$.

  = 第八次作业

  == 伽马能谱分析

  $isotope("Th", a: 228)$ 主要通过 $ka$ 衰变布居 $isotope("Ra", a: 224)$ 的
  $num("0")$, $qty("84.43", "keV")$, $qty("215.99", "keV")$,
  $qty("250.78", "keV")$, $qty("290.32", "keV")$ 等能级. 低能 $kg$
  射线由能级差给出:

  + $qty("84.4", "keV")$: $num("84.43") -> num("0")$, 主峰
  + $qty("131.6", "keV")$: $num("215.99") -> num("84.43")$
  + $qty("166.4", "keV")$: $num("250.78") -> num("84.43")$
  + $qty("205.9", "keV")$: $num("290.32") -> num("84.43")$
  + $qty("216.0", "keV")$: $num("215.99") -> num("0")$
  + $qty("74.3", "keV")$: $num("290.32") -> num("215.99")$, 弱支

  即: $qty("84.4", "keV")$ 为主峰, $qty("216.0", "keV")$ 次之,
  $qty("131.6", "keV")$ 与 $qty("166.4", "keV")$ 为中等强度,
  $qty("205.9", "keV")$ 与 $qty("74.3", "keV")$ 较弱. 定性棒状谱如下:

  #canvas(
    lq.diagram(
      xlabel: [$E_kg$ / keV],
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

  取阳极感应电流流入前放大器为正. 定义: 沉积能量 $E_"dep"=qty("1", "MeV")$,
  平均电离能 $w=qty("25", "eV")$, 电子-离子对数 $N=10^6/25=num("4.0e4")$, 总电荷
  $Q_0=N e approx qty("6.41e-15", "C")$. 平行板近似下 $V=qty("1000", "V")$,
  $d=qty("10", "mm")=qty("0.01", "m")$, $E=V/d approx qty("1.0e5", "V/m")$.

  迁移率取 $mu_e=qty("2e3", "cm^2 V^-1 s^-1")=qty("0.2", "m^2 V^-1 s^-1")$,
  $mu_i=qty("2", "cm^2 V^-1 s^-1")=qty("2.0e-4", "m^2 V^-1 s^-1")$, 故
  $v_e=mu_e E approx qty("2.0e4", "m/s")$, $v_i=mu_i E approx qty("20", "m/s")$.
  阳极权电场 $E_w=1/d=qty("100", "m^-1")$. Shockley-Ramo
  定律给出单种载流子感应电流 $i=q v E_w=(q v)/d$. 电子和正离子对阳极贡献同号. 若
  $d-z_0=qty("6", "mm")$, $z_0=qty("4", "mm")$, 则
  $t_e=(d-z_0)/v_e approx qty("0.30", "us")$,
  $t_i=z_0/v_i approx qty("200", "us")$,
  $i_e=(Q_0 v_e)/d approx qty("1.28e-8", "A")$,
  $i_i=(Q_0 v_i)/d approx qty("1.28e-11", "A")$. 因此:

  $
    i_A(t) = cases(
      i_e + i_i approx qty("1.283e-8", "A") "if" 0 <= t < qty("0.30", "us"),
      i_i approx qty("1.28e-11", "A") "if" qty("0.30", "us") <= t < qty("200", "us"),
      0 "if" t >= qty("200", "us"),
    )
  $

  即: 前段是约 $qty("12.8", "nA")$ 的快电子脉冲, 随后是约 $qty("12.8", "pA")$
  的长离子尾.

  == 栅极电离室阳极感应电流

  理想栅极电离室中, 阳极权电势为:

  $
    phi_w(z) = cases(
      0 "if" 0 <= z <= d_1,
      (z - d_1) / (d - d_1) "if" d_1 < z <= d,
    )
  $

  权电场为:

  $
    E_w(z) = cases(
      0 "if" 0 <= z <= d_1,
      1 / (d - d_1) "if" d_1 < z <= d,
    )
  $

  题中 $d=qty("10", "mm")$, $d_1=qty("9", "mm")$, $d-d_1=qty("1", "mm")$.
  两区实际漂移电场均约 $qty("1.0e5", "V/m")$, 因而
  $v_e approx qty("2.0e4", "m/s")$, $v_i approx qty("20", "m/s")$.

  === 电离发生在栅极下方

  若 $z_0<d_1$, 电子越过栅极前阳极权电场为零, 阳极无感应信号. 对
  $z_0=qty("4", "mm")$, 电子到栅极时间
  $t_1=(d_1-z_0)/v_e approx qty("0.25", "us")$, 栅极到阳极时间
  $t_2=(d-d_1)/v_e approx qty("0.05", "us")$. 阳极-栅极间隙内
  $i_A=(Q_0 v_e)/(d-d_1) approx qty("1.28e-7", "A")$. 形式:

  $
    i_A(t) = cases(
      0 "if" 0 <= t < qty("0.25", "us"),
      qty("1.28e-7", "A") "if" qty("0.25", "us") <= t < qty("0.30", "us"),
      0 "if" t >= qty("0.30", "us"),
    )
  $

  即: 只有宽度约 $qty("50", "ns")$, 高度约 $qty("128", "nA")$ 的快脉冲,
  基本无离子尾.

  === 电离发生在栅极与阳极之间

  若 $z_0=qty("9.5", "mm")$, 电离位置在栅极与阳极之间,
  电子和正离子一产生就位于权电场区. 电子收集时间
  $t_e=(d-z_0)/v_e approx qty("25", "ns")$, 正离子到达栅极时间
  $t_i=(z_0-d_1)/v_i approx qty("25", "us")$. 电流幅度
  $i_e=(Q_0 v_e)/(d-d_1) approx qty("1.28e-7", "A")$,
  $i_i=(Q_0 v_i)/(d-d_1) approx qty("1.28e-10", "A")$. 形式:

  $
    i_A(t) = cases(
      i_e + i_i approx qty("1.283e-7", "A") "if" 0 <= t < qty("25", "ns"),
      i_i approx qty("1.28e-10", "A") "if" qty("25", "ns") <= t < qty("25", "us"),
      0 "if" t >= qty("25", "us"),
    )
  $

  即: 电离发生在栅极上方时, 阳极仍会看到较弱但可见的离子尾.

  == 硅探测器耗尽与电场

  一侧突变结近似下的 $p^+ n^-$ 探测器. 定义:
  $d=qty("0.3", "mm")=qty("3.0e-4", "m")$,
  $N_D=qty("1e12", "cm^-3")=qty("1e18", "m^-3")$,
  $ke_"Si"=11.7ke_0 approx qty("1.04e-10", "F/m")$.

  === 全耗尽电压

  忽略内建电势, 全耗尽电压
  $V_"fd"=(q N_D d^2)/(2ke_"Si") approx qty("69.6", "V")$, 即约
  $qty("70", "V")$.

  === 反向偏压 $qty("200", "V")$ 时的电场分布

  由于 $qty("200", "V")>V_"fd"$, 探测器完全耗尽并过耗尽. 以背电极为 $x=0$, $p^+$
  阳极为 $x=d$, 有 $dv(abs(E), x)=(q N_D)/ke_"Si"$, 且
  $int_0^d abs(E(x)) dif x=V_R$. 因而:

  $
    |E(x)|
    = (V_R - V_"fd") / d + (q N_D x) / ke_"Si"
  $

  其中 $V_R=qty("200", "V")$, 得 $E_0 approx qty("4.35e5", "V/m")$,
  $S approx qty("1.55e9", "V/m^2")$, 即 $|E(x)| approx E_0+S x$. 因此
  $|E(0)| approx qty("4.35e5", "V/m")$, $|E(d)| approx qty("8.99e5", "V/m")$.

  故电场强度在背电极处最小, 向 $p^+$ 阳极线性增大, 形状是一个带底座的三角形.

  === 阳极的权电场分布

  平板型探测器中阳极权电势 $phi_w(x)=x/d$, 权电场
  $E_w=dv(phi_w, x)=1/d approx qty("3.33e3", "m^-1")$, 在整个厚度内均匀不变.

  #canvas(
    grid(
      columns: 2,
      lq.diagram(
        xlabel: [$x$ / mm],
        ylabel: [$|E(x)|$ / (V/m)],
        xlim: (0, 0.3),
        ylim: (0, 1.0e6),
        lq.path((0.0, 4.35e5), (0.3, 8.99e5)),
      ),
      lq.diagram(
        xlabel: [$x$ / mm],
        ylabel: [$E_w$ / m^(-1)],
        xlim: (0, 0.3),
        ylim: (0, 4.0e3),
        lq.path((0.0, 3.33e3), (0.3, 3.33e3)),
      ),
    ),
  )

  == 载流子俘获时的输出电荷

  设产生 $n$ 对电子-空穴对. 载流子产生点距阳极 $D/4$, 从左侧背电极起算
  $x_0=3 D/4$. 对右侧阳极, $phi_w(x)=x/D$, 初始权电势 $phi_w(x_0)=3/4$.
  Shockley-Ramo 定理给出单个载流子的感应电荷
  $kD Q=abs(q)abs(phi_w(x_f)-phi_w(x_i))$.

  === 电子和空穴全部被收集

  电子到阳极, $kD Q_e=e(1-3/4)=e/4$. 空穴到背电极, $kD Q_h=e(3/4-0)=3 e/4$.
  总输出电荷 $kD Q=n (kD Q_e+kD Q_h)=n e$.

  === 电子全部被收集, 空穴仅有 $num("50")%$ 被收集

  电子仍贡献 $n e/4$. 只有一半空穴到达背电极, 空穴贡献
  $0.5 times 3 n e/4=3 n e/8$. 故 $kD Q=n e/4+3 n e/8=5 n e/8$.

  === 电子全部被收集, 空穴仅有 $num("10")%$ 被收集

  同理 $kD Q=n e/4+0.1 times 3 n e/4=(13 n e)/40$. 三种情况分别为 $kD Q=n e$,
  $5 n e/8$, $13 n e/40$. 前放输出幅度 $kD V=kD Q/C$. 因此空穴俘获越严重,
  脉冲幅度越小.


  = 第九次作业

  == 1

  设输入矩形电流脉冲 $i_s(t)=I_0(u(t)-u(t-t_w))$. 并联 RC 电路满足
  $C dv(v, t)+v/R=i_s(t)$. 脉冲期间 $0<t<t_w$, $v(t)=I_0 R(1-e^(-t/(R C)))$.
  脉冲结束后 $t>t_w$, $v(t)=I_0 R(1-e^(-t_w/(R C)))e^(-(t-t_w)/(R C))$.

  若 $t_w << R C$, 有 $e^(-t/(R C)) approx 1-t/(R C)$, 所以
  $v(t) approx (I_0/C)t$, 峰值 $v_"max" approx I_0 t_w/C=Q/C$, 随后按 $R C$
  衰减, 波形近似窄三角脉冲. 若 $t_w >> R C$, 输出先快速趋近 $I_0 R$,
  在脉冲大部分时间近似保持平台, 结束后按 $R C$ 衰减, 波形近似圆角矩形.

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

  外特性斜率 $K=dif v_o/dif v_i$. 三段增益为:
  $K_1=(A-B)/(b-a)=((1.0-1.4)/(3-1)) unit("V/mV")=-200$,
  $K_2=(-A-A)/(a-(-a))=((-1.0-1.0)/2) unit("V/mV")=-1000$,
  $K_3=(-B-(-A))/(b-a)=((-1.4+1.0)/2) unit("V/mV")=-200$.

  密勒等效电容 $C_M=C_f(1-K)$. 对 $C_f=qty("1", "pF")$,
  $C_"M1"=C_"M3"=qty("201", "pF")$, $C_"M2"=qty("1001", "pF")$. 若输入端本身电容
  $C_i=qty("10", "pF")$, 则 $C_"in,1"=C_"in,3"=qty("211", "pF")$,
  $C_"in,2"=qty("1011", "pF")$.

  当输入电流由小变大且电流源方向向下时, $v_i$ 逐渐变负, 工作点从原点向左移动:
  先在 $(-a,a)$ 高增益区快速上升, 再进入 $(-b,-a)$ 慢增益区, 最后在 $v_i<-b$
  时输出饱和到 $v_o approx B=qty("1.4", "V")$.

  == 3

  图中反馈网络为 $R_2 = qty("1000", "MO")$, $C_2 = qty("1", "pF")$,
  $A = num("1e4")$.

  输入端还并联有 $R_1 = qty("100", "MO")$, $C_1 = qty("2000", "pF")$.

  由于 $v_o = -A v_i$

  反馈电阻和反馈电容在输入端的等效值分别为 $R_"f,eq" = R_2 / (1 + A)$,
  $C_"f,eq" = (1 + A) C_2$.

  故整个放大器的等效输入阻抗 $Z_i = R_i parallel (1/(s C_i))$

  其中 $R_i = R_1 parallel R_"f,eq"$, $C_i = C_1 + C_"f,eq"$.

  代入数值得:
  $R_"f,eq" = (1000 / 10001) unit("MO") approx qty("0.100", "MO")$

  $
    R_i = qty("100", "MO") parallel qty("0.100", "MO")
    approx qty("9.99e4", "ohm")
    C_i = qty("2000", "pF") + num("10001") times qty("1", "pF")
    = qty("12001", "pF") approx qty("12.0", "nF")
  $

  所以等效输入阻抗可写为
  $Z_i approx qty("99.9", "kO") parallel qty("12.0", "nF")$

  == 4

  === (1)

  左图为反相放大器, 有 $v_o = A (0 - v_-) = -A v_-$

  在反相输入节点列 KCL: $(v_i - v_-) / R_2 + (v_o - v_-) / R_1 = 0$

  代入 $v_- = -v_o / A$ 后得闭环增益 $v_o / v_i = - A R_1 / (R_1 + (A + 1) R_2)$

  代入 $R_1 = qty("100", "kO"), R_2 = qty("1", "kO"), A = 1000$,
  $v_o / v_i = -1000 times 100 / (100 + 1001) approx -90.83$

  === (2)

  同相放大器反馈系数 $kb=R_2/(R_1+R_2)=1/100$, 且 $v_o=A(v_i-kb v_o)$. 闭环增益
  $v_o/v_i=A/(1+A kb)$. 代入 $A=1000$, $kb=0.01$, 得 $v_o/v_i approx 90.91$.
  两种电路的有限开环闭环增益分别为 $K_1 approx -90.83$, $K_2 approx 90.91$.

  == 5

  定义: 反相输入节点 $v_i$, 输出 $v_o$, 左侧运放输出 $-A v_i$. 中间 RC 网络满足:
  $
    (-A v_i - v_o) / R
    = C dv(v_o, t) + C_f dv(v_o - v_i, t)
  $

  输入端 KCL 为 $i(t)=C_i dv(v_i, t)+C_f dv(v_i-v_o, t)$. 拉氏域令
  $i(t)=Q kd(t)$, 即 $I(s)=Q$, 得 $V_o(s)=-Q(A-R C_f s)/(s(C_T+K s))$, 其中
  $C_T=C_i+(1+A)C_f$, $K=R(C_i C+C_i C_f+C C_f)$. 部分分式:
  $
    V_o(s) = -Q (
      A/C_T 1/s
      - (R C_f + A K / C_T) / (K (s + C_T / K))
    )
  $

  时域表达式:
  $
    v_o(t) = -Q (
      A / C_T
      - (R C_f / K + A / C_T) e^(-t/tau)
    ) u(t)
  $

  其中 $tau=K/C_T$. 若 $(1+A)C_f >> C_i$, 则 $C_T approx (1+A)C_f$,
  $tau approx R C/(1+A)$, 稳态幅度
  $lim_(t->oo)v_o(t) approx -A Q/((1+A)C_f) approx -Q/C_f$. 近似形式:
  $
    v_o(t) approx -Q / C_f (1 - e^(-t/tau)) u(t) \
    tau approx R C / (1 + A)
  $

  波形为快速上升后稳定到 $-Q/C_f$. 若在 $C_f$ 两端并联 $R_f$ 且
  $R_f C_f >> R C$, 快上升基本不变, 但反馈电容通过 $R_f$ 缓慢泄放, 输出以
  $tau_f approx R_f C_f$ 回到基线, 即由“快上升 + 平顶”变为“快上升 + 慢恢复”.

  == 6

  闭环上限频率 $f_H approx "GBW"/(1+C_i/C_f)$, 上升时间
  $t_r approx 0.35/f_H=0.35(1+C_i/C_f)/"GBW"$. 逐项代入: $(1)$
  $t_r approx qty("3.85", "ns")$. $(2)$ $t_r approx qty("2.10", "ns")$. $(3)$
  $t_r approx qty("1.93", "ns")$. $(4)$ $t_r approx qty("4.20", "ns")$.

  == 7

  跨导放大器满足 $i_o=G(v_+-v_-)=-G v_i$, 其中
  $G=qty("10", "mA/V")=qty("0.01", "S")$. 参数: $C_i=qty("100", "pF")$,
  $C_f=qty("1", "pF")$, $C=qty("10", "pF")$, $R=qty("500", "kohm")$.
  主时间常数近似: $tau approx (C_i C+C_i C_f+C C_f)/(C_f G+(C_i+C_f)/R)$.

  其中 $G = qty("10", "mA/V") = qty("0.01", "S")$

  图中参数为
  $
    C_i = qty("100", "pF") \
    C_f = qty("1", "pF") \
    C = qty("10", "pF") \
    R = qty("500", "kO")
  $

  输入端与输出端列方程可得该系统的主时间常数近似为
  $tau approx (C_i C + C_i C_f + C C_f) / (C_f G + (C_i + C_f)/R)$

  代入数值:
  $
    C_i C + C_i C_f + C C_f
    = (100 times 10 + 100 times 1 + 10 times 1) unit("pF^2")
    = qty("1110", "pF^2")
  $

  $C_f G = qty("1e-12", "F") times qty("0.01", "S") = qty("1.0e-14", "F/s")$

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
  $t_r approx 2.2 tau approx qty("2.4e-7", "s") = qty("240", "ns")$

  因此该跨导前放的输出上升时间约为 $t_r approx qty("0.24", "us")$


  = 第十二次作业

  == 1. 带正反馈电压比较器的阈值和回差

  定义: $V_"OH"=qty("3.2", "V")$, $V_"OL"=-qty("0.4", "V")$,
  $V_"OM"=V_"OH"-V_"OL"=qty("3.6", "V")$, 开环增益 $A=1500$. 输入线性范围
  $V_"iM"=V_"OM"/A=qty("2.4", "mV")$. 正反馈系数
  $F=R_2/(R_1+R_2)=10/11 approx 0.909$.

  高电平时同相端电压
  $V_"2H"=(V_"OH" R_2+V_"ref" R_1)/(R_1+R_2) approx qty("3.182", "V")$, 上升阈值
  $V_T=V_"1T"=V_"2H"-V_"iM"/2 approx qty("3.181", "V")$. 低电平时
  $V_"2L"=(V_"OL" R_2+V_"ref" R_1)/(R_1+R_2) approx -qty("90.9", "mV")$,
  下降恢复阈值 $V_"1R"=V_"2L"+V_"iM"/2 approx -qty("89.7", "mV")$. 回差为:

  $
    V_H = V_"1T" - V_"1R"
    = V_"OM" (F - 1 / A)
    approx qty("3.27", "V")
  $

  若要求 $V_H'=qty("0.1", "V")$, 则 $F'=V_H'/V_"OM"+1/A approx 0.0284$,
  $R_1/R_2=(1-F')/F' approx 34.2$. 因此要显著减小反馈系数: 保持
  $R_2=qty("10", "kohm")$ 时取 $R_1 approx qty("342", "kohm")$. 保持
  $R_1=qty("1", "kohm")$ 时需 $R_2 approx qty("29", "ohm")$.

  == 2. 交流耦合施密特电路

  因 $V_B=-qty("4", "V")$, 输入端绝对电压 $v_1=V_B+V_i$. 复位后 $C_1$ 隔直,
  $V_2$ 由 $R_1$ 拉到 $qty("0", "V")$. 此时 $v_1=-qty("4", "V")<V_2$,
  输出为高电平. 输入上升时, 第一次翻转条件 $v_1=V_2 approx qty("0", "V")$,
  相对于脉冲底部的阈值 $V_T=qty("0", "V")-V_B=qty("4", "V")$. 输出从 $V_"OH"$
  跳到 $V_"OL"$ 时, 因 $t_"wi" << R_1 C_1$, 电容电压近似不变, $V_2$ 跟随输出跃变
  $kD V_2=V_"OL"-V_"OH"=-qty("3.0", "V")$. 因此输入下降时恢复条件
  $v_1 approx -qty("3.0", "V")$, 恢复阈值
  $V_R=-qty("3.0", "V")-V_B=qty("1.0", "V")$, 回差
  $V_H=V_T-V_R=qty("3.0", "V")$.

  波形上, $V_O$ 初始为高电平. $V_B+V_i$ 上升越过 $qty("0", "V")$ 时跳低,
  下降越过 $-qty("3.0", "V")$ 时回高. $V_2$ 在两个翻转时刻从 $qty("0", "V")$
  跳到 $-qty("3.0", "V")$, 再回到 $qty("0", "V")$.

  #let tt-schmitt = lq.linspace(-0.1, 1.15)
  #let vin-schmitt(t) = if t < 0 {
    -4
  } else if t < 0.5 {
    -4 + 10 * t
  } else if t < 1 {
    6 - 10 * t
  } else {
    -4
  }
  #let vo-schmitt(t) = if t < 0.4 or t >= 0.9 { 3.2 } else { 0.2 }
  #let v2-schmitt(t) = if t < 0.4 or t >= 0.9 { 0 } else { -3 }

  #canvas(
    grid(
      columns: 1,
      row-gutter: 0.8em,
      lq.diagram(
        width: 12cm,
        height: 3cm,
        xlabel: [$t/t_"wi"$],
        ylabel: [$V_B + V_i$ / V],
        xlim: (-0.1, 1.15),
        ylim: (-4.5, 1.4),
        lq.plot(tt-schmitt, vin-schmitt),
        lq.path((-0.1, 0), (1.15, 0), stroke: gray + 0.6pt),
        lq.path((-0.1, -3), (1.15, -3), stroke: gray + 0.6pt),
      ),
      lq.diagram(
        width: 12cm,
        height: 3cm,
        xlabel: [$t/t_"wi"$],
        ylabel: [$V_O$ / V],
        xlim: (-0.1, 1.15),
        ylim: (0, 3.5),
        lq.plot(tt-schmitt, vo-schmitt),
      ),
      lq.diagram(
        width: 12cm,
        height: 3cm,
        xlabel: [$t/t_"wi"$],
        ylabel: [$V_2$ / V],
        xlim: (-0.1, 1.15),
        ylim: (-3.4, 0.4),
        lq.plot(tt-schmitt, v2-schmitt),
      ),
    ),
  )

  == 3. 高纯锗探测器的本征能量分辨率

  定义: 平均电离能 $W=qty("2.96", "eV")$, 法诺因子 $F=0.058$. 对沉积能量 $E$,
  平均载流子对数 $ol(N)=E/W$, 涨落 $ks_N=sqrt(F ol(N))$. 本征 FWHM:
  $omega_P=2.355 W ks_N=2.355 sqrt(F E W)$.

  对 $E_1=qty("1173.2", "keV")$, 有 $ol(N)_1 approx num("3.96e5")$,
  $ks_(N,1) approx num("1.52e2")$, $omega_(P,1) approx qty("1.06", "keV")$. 对
  $E_2=qty("1332.5", "keV")$, 有 $ol(N)_2 approx num("4.50e5")$,
  $ks_(N,2) approx num("1.62e2")$, $omega_(P,2) approx qty("1.13", "keV")$.
  若电子学噪声 $N_"ENC"=100$, 则
  $omega_E=2.355 N_"ENC" W approx qty("0.697", "keV")$. 忽略电荷收集涨落时,
  $omega=sqrt(omega_P^2+omega_E^2)$, 得 $omega_1 approx qty("1.27", "keV")$,
  $omega_2 approx qty("1.32", "keV")$.

  结果汇总如下:

  #table(
    columns: 6,
    [能量], [$ol(N)$], [$ks_N$], [本征 FWHM], [含 ENC 后 FWHM], [相对分辨率],
    [$qty("1173.2", "keV")$],
    [$3.96 times 10^5$],
    [$1.52 times 10^2$],
    [$qty("1.06", "keV")$],
    [$qty("1.27", "keV")$],
    [0.108%],

    [$qty("1332.5", "keV")$],
    [$4.50 times 10^5$],
    [$1.62 times 10^2$],
    [$qty("1.13", "keV")$],
    [$qty("1.32", "keV")$],
    [0.099%],
  )

  == 4. 弹道亏损

  设探测器电流 $i(t)=Q/t_D (u(t)-u(t-t_D))$. 若输入为理想冲激 $Q kd(t)$,
  输出峰值 $V_M=Q max(h(t))=Q/C$.

  === 矩形冲激响应

  $h_a(t)=1/C (u(t)-u(t-2 t_D))$. 两矩形完全重叠时重叠长度为 $t_D$, 所以
  $V_"OM,a"=Q/t_D dot 1/C dot t_D=Q/C$, 弹道亏损 $D_(B,a)=(V_M-V_"OM,a")/V_M=0$.

  === 三角冲激响应

  $
    h_b(t) = cases(
      t / (C t_D) "if" num("0") <= t <= t_D,
      (2 t_D - t) / (C t_D) "if" t_D < t <= 2 t_D,
      num("0") "otherwise",
    )
  $

  最大平均值出现在积分窗口以 $t_D$ 为中心时, 区间为 $[t_D/2,3t_D/2]$. 面积
  $S=t_D/C-2 times (1/2 dot t_D/2 dot 1/(2 C))=3 t_D/(4 C)$. 因此
  $V_"OM,b"=Q/t_D dot S=3 Q/(4 C)$, $D_(B,b)=(Q/C-3 Q/(4 C))/(Q/C)=1/4$.
  即输出为理想冲激输入的 $75%$.

  === 电流脉宽在 $0.5 t_D$ 到 $t_D$ 之间变化时

  设电流脉宽 $t_s$, 总电荷仍为 $Q$, 电流幅度 $Q/t_s$. 图 (a) 中只要
  $t_s<=2 t_D$, 矩形脉冲可完全放入平台, 峰值恒为 $V_"OM,a"(t_s)=Q/C$. 图 (b)
  中最大积分窗口仍以三角形峰值为中心, 当 $t_s<=2 t_D$ 时:

  $
    V_"OM,b"(t_s)
    = Q / t_s dot int_(t_D - t_s/2)^(t_D + t_s/2) h_b(t) dif t
    = Q / C (1 - t_s / (4 t_D))
  $

  所以 $V_"OM,b"(0.5 t_D)=7 Q/(8 C)$, $V_"OM,b"(t_D)=3 Q/(4 C)$. 弹道亏损从
  $1/8$ 增大到 $1/4$, 即图 (b) 输出随电流脉宽增加而降低,
  会把同一能量事件展宽到不同幅度并恶化能量分辨率.

  = 第十三次作业

  == $isotope("Co", a: 60)$ 的 $qty("1.33", "MeV")$ 伽马射线 MDA

  定义: 能量分辨率 $omega_"FWHM"=qty("2", "keV")$. 若取一个 FWHM 作为全能峰能窗,
  本底计数
  $B=b kD E L_T=qty("1", "cps/keV") times qty("2", "keV") times qty("1000", "s")
  =2000$. 95% 探测限采用 Currie 形式:

  $
    L_D = 2.71 + 4.65 sqrt(B)
  $

  代入 $B=2000$ 得 $L_D approx 2.11 times 10^2$. 最小可探测活度定义为
  $A_"MDA"=L_D/(L_T epsilon P_kg)$. 对 $isotope("Co", a: 60)$ 的
  $qty("1332.5", "keV")$ 级联伽马线, 取 $P_kg approx 1$,
  $epsilon=0.04%=4.0 times 10^(-4)$, $L_T=qty("1000", "s")$, 即:

  $
    A_"MDA" approx (2.11 times 10^2) / (1000 times 4.0 times 10^(-4))
    approx qty("5.3e2", "Bq")
  $

  即: 若题中 $0.04%$ 已是所选能窗内的有效全能峰效率, 则
  $A_"MDA" approx qty("5.3e2", "Bq")$. 若 $0.04%$ 是整个高斯全能峰总效率,
  而只取中心 $omega_"FWHM"/2$ 能窗, 峰面积比例
  $f="erf"(sqrt(ln 2)) approx 0.761$, 有效效率为 $f epsilon$, 于是
  $A_"MDA" approx qty("6.9e2", "Bq")$.

  形式: $A_"MDA" prop L_D/(L_T epsilon P_kg)$. 本底主导时 $B=b kD E L_T$,
  $L_D prop sqrt(B)$, 近似:

  $
    A_"MDA" prop sqrt(b kD E) / (epsilon P_kg sqrt(L_T))
  $

  所以降低 MDA 的方向很明确: 降低本底 $b$, 缩小但不过窄的能窗 $kD E$,
  提高全能峰效率 $epsilon$, 增加计数时间 $L_T$, 并选择发射概率大,
  干扰少的伽马线. 其中 $L_T$ 的收益只有 $1/sqrt(L_T)$ 量级,
  屏蔽和效率优化通常更直接.

  == 同轴型高纯锗探测器所需偏压更低的原因

  平面型 HPGe 可近似为一维平板结. 定义: 杂质浓度 $N$, 厚度 $D$, 介电常数
  $epsilon$. 全耗尽电压数量级为 $V_(D,"plane")=(e N D^2)/(2 epsilon)$.
  因此探测厚度为 MeV 伽马射线所需的厘米量级时, 偏压按 $D^2$ 快速增大. 例如
  $N=qty("1e10", "cm^-3")$, $D=qty("1", "cm")$ 时约需 $qty("565", "V")$.
  若平面厚度增至 $qty("5", "cm")$, 偏压约增大 $25$ 倍, 进入十几 kV 量级.

  同轴型 HPGe 在晶体中心开孔并设置中心电极, 电场与耗尽层主要沿径向分布. 对内半径
  $a$, 外半径 $b$ 的双开端同轴结构, 令 $rho=e N$, 从外电极向内耗尽时,
  全耗尽电压可写为:

  $
    V_(D, "coax")
    = rho / (4 epsilon) (b^2 - a^2)
    - (rho a^2) / (2 epsilon) ln(b / a)
  $

  即: 探测体积可通过长度和外半径增加, 但关键耗尽距离由径向间隙 $b-a$ 控制,
  不必让整个探测厚度都成为一维耗尽宽度. 中心孔还缩短最大漂移距离,
  并使中心附近漂移场和权电场更强. 因此在相近有效体积和全能峰效率下,
  同轴型可以用较低偏压达到全耗尽, 这也是大体积 HPGe
  伽马谱仪通常采用同轴结构的原因.

  == 中心电极为阴极时的感应电流

  取同轴探测器内半径为 $a$, 外半径为 $b$, 事件发生在半径 $r_0$ 处.
  中心电极权电场 $E_w(r)=1/(r ln(b/a))$. 中心电极为阴极时, 空穴向中心电极漂移,
  电子向外电极漂移. 若漂移速度饱和且大小分别为 $v_h$ 和 $v_e$,
  则两种载流子对中心电极的感应电流幅度可定性写成:

  $
    abs(i_h(t))
    prop v_h / ((r_0 - v_h t) ln(b / a))
  $

  $
    abs(i_e(t))
    prop v_e / ((r_0 + v_e t) ln(b / a))
  $

  其中空穴分量持续 $0<t<(r_0-a)/v_h$, 电子分量持续 $0<t<(b-r_0)/v_e$.
  符号取决于前置放大器定义的电流方向. 定性图主要看幅度和持续时间. 由于
  $E_w prop 1/r$, 越靠近中心电极, 单位漂移距离产生的感应电流越大.

  图中 A 点比 B 点更靠近中心电极:

  + A 点产生的空穴很快到达中心阴极, 因而有一个较短, 较大的上升型空穴电流分量.
    电子要漂移到外电极, 时间较长, 其电流分量随 $r$ 增大而逐渐减小.
  + B 点靠近外电极, 电子很快被外电极收集, 电子分量短且较小.
    空穴需从大半径漂移到中心电极, 持续时间长,
    并且随着接近中心电极电流幅度逐渐增大.

  #let t-coax = lq.linspace(0, 4.2, num: 300)
  #let a-coax = 1.0
  #let b-coax = 5.0
  #let r-a = 1.7
  #let r-b = 4.3
  #let i-coax(t, r0) = {
    let ih = if t >= 0 and t <= r0 - a-coax { 1 / (r0 - t) } else { 0 }
    let ie = if t >= 0 and t <= b-coax - r0 { 1 / (r0 + t) } else { 0 }
    ih + ie
  }

  #canvas(
    lq.diagram(
      width: 12cm,
      height: 5cm,
      xlabel: [$t$ / arb],
      ylabel: [$abs(i)$ / arb],
      legend: (position: top + right),
      lq.plot(t-coax, t => i-coax(t, r-a), label: [A: 靠近中心电极]),
      lq.plot(t-coax, t => i-coax(t, r-b), label: [B: 靠近外电极]),
    ),
  )

  因此, 若把中心电极感应电流画为同一极性的脉冲, A
  点脉冲前段较强且短空穴分量明显, 随后有较长的衰减电子分量. B
  点脉冲则先有很短的电子分量, 之后主要表现为较长并逐渐增强的 空穴分量,
  到空穴到达中心电极时结束.

  == 不同 ENC 下 $isotope("Co", a: 60)$ 能峰的能量分辨率

  定义: HPGe 平均电离能 $W=qty("2.96", "eV")$, 法诺因子 $F=0.058$.
  若电荷收集完全, 能量分辨率只考虑信号产生涨落和电子学噪声, 本征贡献
  $omega_P=2.355 sqrt(F E W)$, 电子学噪声贡献 $omega_E=2.355 N_"ENC" W$,
  总半高宽 $omega=sqrt(omega_P^2+omega_E^2)$.

  对 $E_1=qty("1173.2", "keV")$,
  $omega_(P,1)=2.355 sqrt(0.058 times 1173.2 times 10^3 times 2.96) unit("eV")
  approx qty("1.06", "keV")$. 对 $E_2=qty("1332.5", "keV")$,
  $omega_(P,2)=2.355 sqrt(0.058 times 1332.5 times 10^3 times 2.96) unit("eV")
  approx qty("1.13", "keV")$.

  不同 ENC 下的结果为:

  #table(
    columns: 5,
    [能峰能量], [ENC], [电子学 FWHM], [总 FWHM], [相对分辨率],

    [$qty("1173.2", "keV")$],
    [$50$],
    [$qty("0.349", "keV")$],
    [$qty("1.11", "keV")$],
    [$0.0949%$],

    [$qty("1173.2", "keV")$],
    [$200$],
    [$qty("1.39", "keV")$],
    [$qty("1.75", "keV")$],
    [$0.149%$],

    [$qty("1173.2", "keV")$],
    [$500$],
    [$qty("3.49", "keV")$],
    [$qty("3.64", "keV")$],
    [$0.310%$],

    [$qty("1332.5", "keV")$],
    [$50$],
    [$qty("0.349", "keV")$],
    [$qty("1.18", "keV")$],
    [$0.0885%$],

    [$qty("1332.5", "keV")$],
    [$200$],
    [$qty("1.39", "keV")$],
    [$qty("1.79", "keV")$],
    [$0.135%$],

    [$qty("1332.5", "keV")$],
    [$500$],
    [$qty("3.49", "keV")$],
    [$qty("3.66", "keV")$],
    [$0.275%$],
  )

  可以看出, 当 ENC 从 50 e 增大到 500 e 时, 电子学噪声项从次要贡献变成主导贡献,
  总能量分辨率明显恶化. 两个能峰的本征分辨率随 $sqrt(E)$ 增大,
  但相对分辨率随能量升高略有改善.
]

#hw
