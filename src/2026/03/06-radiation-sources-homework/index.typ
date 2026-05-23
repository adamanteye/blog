#import "/page.typ": *
#import "meta.typ": desc, title
#set text(lang: "zh")
#show: conf.with(title: title, desc: desc)

#let hw = [
  = 第一次作业

  == 束流的相空间分布

  已知漂移段无外力, 无自场, 粒子横向斜率 $x' = v_x/v_z$ 在漂移中保持不变,
  而横向位置随纵向传播距离 $L$ 发生线性漂移:
  $ x(L) = x(0) + L x'(0) $

  #canvas(lq.diagram(
    xlabel: [$x$],
    ylabel: [$x'$],
    lq.path((0, 0), (4, 2), (0, 2), (0, -2), (-4, -2), (0, 0)),
  ))

  右上角与左下角顶点分别为 $(2a,b), (-2a,-b)$

  == 电子能量分布

  $ kg = 1+E_k/(m_e c^2), kb=sqrt(1-1/kg^2) $

  #let x = lq.logspace(1, 7)
  #canvas(
    grid(
      columns: 2,
      lq.diagram(
        xscale: lq.scale.log(base: 10),
        xlabel: [$E_k$/eV],
        ylabel: [$kg$],
        lq.plot(x, x => (1 + x / 511000)),
      ),
      lq.diagram(
        xscale: lq.scale.log(base: 10),
        xlabel: [$E_k$/eV],
        ylabel: [$kb$],
        lq.plot(x, x => (calc.sqrt(1 - 1 / calc.pow(1 + x / 511000, 2)))),
      ),
    ),
  )

  == 电子 de Broglie 波长

  电子的相对论动量满足
  $ (p c)^2=(E_k + m_e c^2)^2 - (m_e c^2)^2 = E_k^2 + 2 E_k m_e c^2 $

  de Broglie 波长
  $ kl=h/p=(h c)/(p c) $

  取常数 $h c=1239.84$
  $ kl=1239.84/ sqrt(E_k^2 + 2 E_k m_e c^2) $


  #let hc = 1239.841984
  #canvas(
    lq.diagram(
      xscale: lq.scale.log(base: 10),
      yscale: lq.scale.log(base: 10),
      xlabel: [$E_k$/eV],
      ylabel: [$kl$],
      lq.plot(x, Ek => (hc / calc.sqrt(Ek * Ek + 2 * Ek * 511000))),
    ),
  )


  == 200 keV 电镜中电子平均纵向间距

  已知电流 $I=qty("100", "pA")$, 电子流率
  $ dot(N) = I/e $

  其中 $e = qty("1.602e-19", "C")$

  对于 $E_k = qty("200", "keV")$ 的时候:
  $ kg = 1 + 200/511 approx 1.391 $

  把电子到达看作平均均匀流, 则平均时间间隔
  $ kD t approx 1/dot(N) approx qty("1.60e-9", "s") $

  平均纵向间距
  $kD z approx v kD t = v/dot(N) approx (2.09 times 10^8)/(6.24 times 10^8) approx qty("0.334", "m")$

  = 第二次作业

  == 推导 Richardson-Dushman 公式

  1901, Richardson 观察到加热导线, 电流随温度近似指数增长. 后来 Dushman 导出了
  Richardson 公式中的一个常数. 最后得到的式子为:

  $ J=(4pi m_0 e k_B^2)/h^3 T^2 e^(-W\/(k_B T)) $

  公式的物理图像是, 金属中的自由电子在热激发下获得足够能量, 克服表面势垒 (功函数
  $W$) 逸出金属, 形成热发射电流.

  考虑 Fermi-Dirac 分布 (能量为 $E$ 的单粒子量子态被占据的平均数, 并且假设 $T$
  并不是非常高, 可以在公式中使用 $E_F$):

  $
    f(E) & =1/(1+e^((E-E_F)\/(k_B T))) "for" T>0
  $

  并且 $T->0$ 有:

  $
    f(E) & =cases(1 "where" E<E_F, 0 "where" E>E_F)
  $

  接下来考虑金属表面法向取为 $x$ 方向. 电子若要从金属中逸出, 不仅要朝向表面运动,
  还要有足够大的法向动能克服表面势垒.

  设金属内电子能量为 $E = (p_x^2 + p_y^2 + p_z^2)/(2m_0)$

  其中 $p_x$ 是垂直于表面的动量分量. 真空能级比金属内费米能级高出功函数 $W$,
  因此若能量以金属内导带底部为零点, 则表面势垒高度为 $E_v = E_F + W$

  由于电子穿越表面时, 平行于表面的动量分量 $p_y, p_z$ 守恒,
  因此真正用于"翻过势垒"的是法向动能, 即必须满足 $p_x^2/(2m_0) > E_v = E_F + W$

  并且还要有 $p_x > 0$.

  现在计算单位体积, 单位动量空间中的量子态数.

  考虑边长为 $L$, 体积为 $V=L^3$ 的立方体, 对电子取周期性边界条件.
  则允许的波矢为 $k_i = 2pi n_i/L$, $i = x,y,z$.

  因此在波矢空间中, 每个量子态占据的体积为 $(2pi)^3/V$.

  故单位体积, 单位波矢空间中的态数为 $1/(2pi)^3$.

  再考虑电子的自旋, 为 $2/(2pi)^3$, 记为 $2/(2pi)^3 dd(k, 3)$.

  由 $p = hbar k$ 可知, 单位体积, 单位动量空间中的量子态数为:

  $ 2/((2pi)^3 hbar^3) = 2/h^3 $

  故动量在 $va(p)$ 到 $va(p) + dd(va(p))$ 之间的电子数密度为:
  $dd(N) = 2/h^3 f(E) dd(p_x) dd(p_y) dd(p_z)$

  这些电子对表面的电流贡献为:
  $dd(J) = e v_x dd(N) = e p_x/m_0 2/h^3 f(E) dd(p_x) dd(p_y) dd(p_z)$

  积分 (利用高斯积分公式):

  $
    & int_(-inft)^(+inft) dd(p_y) int_(-inft)^(+inft) dd(p_z)
      int_sqrt(2m_0(E_F+W))^(+inft) dd(p_x)
      e p_x/m_0 2/h^3 1/(1+e^((E-E_F)\/(k_B T))) \
    & = (2e)/(m_0 h^3) int dd(p_y) int dd(p_z)
      int p_x dd(p_x) 1/(1+e^((E-E_F)\/(k_B T))) \
    & approx (2e)/(m_0 h^3) int dd(p_y) int dd(p_z)
      int p_x dd(p_x) e^(-(E-E_F)\/(k_B T)) \
    & = (4pi m_0 e k_B^2 T^2)/h^3 exp(-W/(k_B T))
  $

  与经典 Maxwell 分布推导的主要区别在于: 金属内电子是简并费米气体,
  态密度由量子态计数 $2 / h^3$ 给出, 发射主要来自费米面附近的高能尾部; 因而 R-D
  公式中的 Richardson 常数 $A = 4pi m_0 e k_B^2 / h^3$ 是量子统计给出的普适常数.
  经典图像没有 Pauli 不相容和费米能级, 会把电子看作普通 Maxwell 气体,
  难以得到这个普适前因子.

  == 要求热阴极电流密度的稳定性优于百分之一, 对温度和功函数的变化分别有什么要求

  $
    e^(W\/(k_B T))\/((4pi m_0 e k_B^2)/h^3) dd(J)
    = (2T+W/k_B) dd(T)
    - T/k_B dd(W)
  $

  考虑温度变化, 有:

  $
    abs(dd(J)/J) = abs((2+W/(k_B T)) dd(T)/T) < 0.01 \
    ==> abs(dd(T)/T) < abs(0.01/(2+W/(k_B T)))
  $

  考虑功函数变化, 有:
  $
    abs(dd(J)/J) = abs(W/(k_B T)dd(W)/W) < 0.01 \
    ==> abs(dd(W)/W) < abs(0.01(k_B T)/W)
  $

  == 画出 100 到 2000 摄氏度热发射电流密度

  #let ts = lq.linspace(100 + 273.15, 2000 + 273.15)

  #let A = 1.20173e6
  #let k_B = 8.617333262e-5
  #let r(t, w) = {
    A * t * t * calc.exp(-w / (k_B * t))
  }

  #canvas(
    lq.diagram(
      legend: (position: bottom + right),
      xlabel: [$T$/K],
      ylabel: [$J unit("A/m^2")$],
      yscale: lq.scale.log(base: 10),
      lq.plot(ts, t => r(t, 4.65), label: [Cu 4.65 eV]),
      lq.plot(ts, t => r(t, 4.26), label: [Ag 4.26 eV]),
      lq.plot(ts, t => r(t, 5.1), label: [Au 5.1 eV]),
      lq.plot(ts, t => r(t, 4.5), label: [W 4.5 eV]),
      lq.plot(ts, t => r(t, 2.6), label: [$chem("La")chem("B")_6$ 2.6 eV]),
    ),
  )

  == 基于热发射的物理图像, 思考光电发射的原理

  热发射是电子靠热激发从分布高能尾部越过功函数, 光电发射不同,
  是电子吸收光子能量, 被光激发到更高能量, 从而越过功函数.

  = 第三次作业

  == 重复 Schottky 势垒降低的推导过程

  相对于零场时的功函数 $W$, 外加电场和镜像力给出的附加势能为

  $ V(x)=-e E_a x - e^2/(16pi ke_0 x) $

  故总势垒可写成

  $ U(x)=W+V(x)=W-e E_a x - e^2/(16pi ke_0 x) $

  势垒顶部满足 $dv(U, x) = -e E_a + e^2/(16pi ke_0 x^2) = 0$

  从而 $x_m = sqrt(e/(16pi ke_0 E_a))$

  把 $x_m$ 代回势垒, 有

  $
    U(x_m)-W & = -e E_a x_m - e^2/(16pi ke_0 x_m) \
             & = -2 e E_a x_m \
             & = -sqrt(e^3 E_a/(4pi ke_0))
  $

  故 Schottky 势垒降低量为

  $ kD W = W-U(x_m) = sqrt(e^3 E_a/(4pi ke_0)) $

  当 $E_a = qty("100", "MV/m") = qty("1e8", "V/m")$ 时,

  $
    kD W = sqrt(e^3 E_a/(4pi ke_0))
    approx qty("6.08e-20", "J")
    approx qty("0.38", "eV")
  $

  并且势垒顶点位置为

  $ x_m = sqrt(e/(16pi ke_0 E_a)) approx qty("1.90e-9", "m") $

  == 推导光电发射热发射度的表达式

  这里取阴极表面法向为 $z$, 横向为 $x,y$. 设有效功函数为 $W_"eff"$, 光子能量为
  $h nu$, 则电子逸出后的最大超额能量为

  $ kD E = h nu - W_"eff" $

  对应的最大动量满足

  $ p_m = sqrt(2m_0 kD E) $

  在最简单的自由电子模型下, 发射到真空中的电子在动量空间占据半球

  $ p_x^2 + p_y^2 + p_z^2 <= p_m^2, p_z > 0 $

  并且穿过表面的粒子流要按法向速度加权, 即

  $ dd(N) = C v_z dd(p, 3) = C p_z/m_0 dd(p, 3) $

  其中 $C$ 为与归一化有关的常数. 在求二阶矩时, 分子分母中的 $C/m_0$ 会相互抵消.

  于是 $ks_(p_x)^2 = chevron.l p_x^2 chevron.r - chevron.l p_x chevron.r^2$

  由对称性可知 $chevron.l p_x chevron.r = 0$, 所以

  $
    ks_(p_x)^2
    = int p_x^2 dd(N) \/ int dd(N)
    = int p_x^2 p_z dd(p, 3) \/ int p_z dd(p, 3)
  $

  取球坐标, 以 $z$ 为极轴, 有 $p_x = p sin kt cos phi$, $p_z = p cos kt$.

  以及

  $ dd(p, 3) = p^2 sin kt dd(p) dd(kt) dd(phi) $

  故分母为

  $
    int p_z dd(p, 3) & = int_0^(p_m) p^3 dd(p) int_0^(pi/2) cos kt sin kt dd(kt)
                       int_0^(2pi) dd(phi) \
                     & = 2pi (p_m^4/4) (1/2) \
                     & = (pi p_m^4)/4
  $

  分子为

  $
    int p_x^2 p_z dd(p, 3) & = int_0^(p_m) p^5 dd(p) int_0^(pi/2) sin^3 kt cos kt dd(kt)
                             int_0^(2pi) cos^2 phi dd(phi) \
                           & = (p_m^6/6) (1/4) pi \
                           & = (pi p_m^6)/24
  $

  因此

  $
    ks_(p_x)^2 = ((pi p_m^6)/24) \/ ((pi p_m^4)/4) = p_m^2/6
  $

  再代入 $p_m^2 = 2m_0 kD E$, 得 $ks_(p_x)^2 = (m_0 kD E) / 3$

  即

  $ ks_(p_x) = sqrt((m_0 kD E) / 3) $

  对于归一化热发射度,

  $
    ke_("n",x)
    = 1/(m_0 c) sqrt(chevron.l x^2 chevron.r chevron.l p_x^2 chevron.r - chevron.l x p_x chevron.r^2)
  $

  若阴极表面位置与横向动量无关, 即 $chevron.l x p_x chevron.r = 0$, 且
  $ks_x^2 = chevron.l x^2 chevron.r$, 则 $ke_("n",x) = (ks_x ks_(p_x))/(m_0 c)$

  最终得到 $ke_("n",x) = ks_x sqrt((kD E)/(3m_0 c^2))$

  其中 $kD E = h nu - W_"eff"$

  因此单位束斑尺寸对应的本征发射度随超额能量 $h nu - W_"eff"$ 的平方根增加.
  降低光电发射热发射度的主要办法是让驱动光尽量接近发射阈值, 即减小
  $h nu - W_"eff"$; 也可以在满足电荷量和空间电荷限制的前提下减小激光光斑尺寸
  $ks_x$. 实际阴极还需要控制表面粗糙、污染和非均匀场,
  否则会额外引入横向动量和位置相关性.

  == 重复 Child-Langmuir 的推导过程

  考虑一维平板真空二极管. 阴极位于 $x=0$, 阳极位于 $x=d$, 阴极电势取为 0,
  阳极电势为 $V$, 即

  $ phi(0)=0 $,
  $ phi(d)=V $.

  并假设电子从阴极出发时初速度近似为 0.

  电流密度守恒为

  $ J = e n(x) v(x) $

  其中 $n(x)$ 为电子数密度, $v(x)$ 为电子速度.

  电子在电势 $phi(x)$ 中满足能量守恒

  $ 1/2 m_0 v^2 = e phi(x) $

  故

  $ v(x)=sqrt((2e phi(x))/m_0) $

  Poisson 方程为

  $ phi''(x) = e n(x)/ke_0 $

  利用 $n(x)=J/(e v)$ 代入, 得

  $
    phi''(x)
    = J/(ke_0 v)
    = J/ke_0 sqrt(m_0/(2e)) phi^(-1/2)
  $

  记

  $ A = J/ke_0 sqrt(m_0/(2e)) $

  则

  $ phi''(x)=A phi^(-1/2) $

  两边同乘 $phi'(x)$:

  $
    phi'' phi'
    = A phi^(-1/2) phi'
  $

  积分得 $1/2 phi'^2 = 2A sqrt(phi) + C$

  在空间电荷限制发射条件下, 阴极表面电场为 0, 即 $phi'(0)=0$. 再结合 $phi(0)=0$,
  可得 $C=0$. 因此

  $ phi'^2 = 4A sqrt(phi) $

  取正根并分离变量:

  $
    dv(phi, x) = 2 sqrt(A) phi^(1/4) \
    phi^(-1/4) dd(phi) = 2 sqrt(A) dd(x)
  $

  积分得 $4/3 phi^(3/4) = 2 sqrt(A) x$

  在 $x=d$ 处取 $phi=V$, 得 $4/3 V^(3/4) = 2 sqrt(A) d$

  于是

  $ A = 4/9 V^(3/2)/d^2 $

  代回 $A$ 的定义, 最终得到 Child-Langmuir 定律
  $J = (4 ke_0) / 9 sqrt((2e)/m_0) V^(3/2)/d^2$

  并且电势分布为 $phi(x) = V (x/d)^(4/3)$

  = 第四次作业

  == 重复 Child-Langmuir 的推导过程, 并计算 200 kV, 5 cm 间距极板中的流强密度

  设平板二极管阴极位于 $x = 0$, 阳极位于 $x = d$, 两极板间电压为 $V_0$. 取电势为
  $phi(x)$, 满足 $phi(0) = 0$, $phi(d) = V_0$.

  设电子从阴极表面近似静止出发, 由能量守恒有 $1/2 m v^2 = e phi$

  故电子速度为 $v = sqrt((2 e phi) / m)$

  稳恒条件下, 电流密度 $J$ 为常数. 设电荷密度大小为 $abs(rho)$, 则
  $J = abs(rho) v$

  所以 $abs(rho) = J / v$

  由 Poisson 方程, $dv(phi, x, 2) = abs(rho) / ke_0$

  代入上式得

  $
    dv(phi, x, 2)
    = J / (ke_0 v) \
    = J / ke_0 sqrt(m / (2 e phi))
  $

  即

  $
    dv(phi, x, 2)
    = J / ke_0 sqrt(m / (2 e)) phi^(-1/2)
  $

  令 $K = J / ke_0 sqrt(m / (2 e))$

  则有 $dv(phi, x, 2) = K phi^(-1/2)$

  两边同乘 $dv(phi, x)$, 得

  $
    dv(phi, x, 2) dv(phi, x)
    = K phi^(-1/2) dv(phi, x)
  $

  即

  $
    dv(1/2 (dv(phi, x))^2, x)
    = dv(2 K phi^(1/2), x)
  $

  积分得 $1/2 (dv(phi, x))^2 = 2 K phi^(1/2) + C$

  在空间电荷限制条件下, 阴极表面电场为零, 即 $phi(0) = 0$,
  $(dv(phi, x))|_(x = 0) = 0$.

  故积分常数 $C = 0$. 于是 $(dv(phi, x))^2 = 4 K phi^(1/2)$

  取正根, $dv(phi, x) = 2 sqrt(K) phi^(1/4)$

  分离变量并积分: $phi^(-1/4) dd(phi) = 2 sqrt(K) dd(x)$,
  $int phi^(-1/4) dd(phi) = int 2 sqrt(K) dd(x)$.

  得 $4/3 phi^(3/4) = 2 sqrt(K) x$

  在 $x = d$ 处有 $phi = V_0$, 所以 $4/3 V_0^(3/4) = 2 sqrt(K) d$

  从而 $sqrt(K) = 2/3 V_0^(3/4) / d$

  两边平方得 $K = 4/9 V_0^(3/2) / d^2$

  再代回 $K = J / ke_0 sqrt(m / (2 e))$

  得到 Child-Langmuir 定律

  $
    J
    = 4 ke_0 / 9 sqrt((2 e) / m) V_0^(3/2) / d^2
  $

  代入数值 $ke_0 = qty("8.854e-12", "F/m")$, $e = qty("1.602e-19", "C")$,
  $m = qty("9.11e-31", "kg")$, $V_0 = qty("200e3", "V")$,
  $d = qty("5e-2", "m")$.

  故

  $
    J
    = 4 ke_0 / 9 sqrt((2 e) / m) V_0^(3/2) / d^2
    approx qty("8.35e4", "A/m^2")
  $

  也可写成 $J approx qty("8.35", "A/cm^2")$

  因此, 极板中的空间电荷限制流强密度为 $J approx qty("8.35e4", "A/m^2")$

  == 无限长圆柱分布电子束流在 $r = qty("1", "mm")$ 处电子受到的力

  设电子束半径为 $a = qty("1", "mm") = qty("1.0e-3", "m")$, 束流流强为
  $I = qty("100", "A")$, 且在圆柱内均匀分布.

  设电子束速度为 $v$, 则线电荷密度大小为 $kl = I / v$

  体电荷密度大小为 $abs(rho) = kl / (pi a^2) = I / (pi a^2 v)$

  对半径为 $a$ 的均匀带电圆柱, 在柱内半径 $r$ 处的电场大小为
  $E(r) = abs(rho) r / (2 ke_0)$

  因此在边界 $r = a$ 处, $E(a) = I / (2 pi ke_0 a v)$

  电场方向指向圆柱轴心, 但电子带负电, 所以电子受到的电场力方向为径向向外.
  其大小为 $F_E = e E(a) = e I / (2 pi ke_0 a v)$

  均匀电流圆柱在柱内半径 $r$ 处的磁场大小为 $B(r) = mu_0 I r / (2 pi a^2)$

  故在边界 $r = a$ 处, $B(a) = mu_0 I / (2 pi a)$

  电子沿束流方向运动, 所受磁力大小为 $F_B = e v B(a) = e v mu_0 I / (2 pi a)$

  其方向为径向向内.

  所以电子所受总力大小为 $F = F_E - F_B$

  即

  $
    F
    = e I / (2 pi a) (1 / (ke_0 v) - mu_0 v)
  $

  利用 $mu_0 ke_0 = 1 / c^2$

  并记 $kb = v / c$, $kg = 1 / sqrt(1 - kb^2)$.

  则

  $
    F = e I / (2 pi ke_0 a v) (1 - kb^2)
    = e I / (2 pi ke_0 a v kg^2)
  $

  总力方向为径向向外.


  电子静能为 $m c^2 = qty("511", "keV")$

  故 $kg = 1 + 100 / 511 approx 1.1957$,
  $kb = sqrt(1 - 1 / kg^2) approx 0.5482$,
  $v = kb c approx qty("1.6435e8", "m/s")$.

  于是

  $
    E(a) = I / (2 pi ke_0 a v)
    approx qty("1.0937e7", "V/m")
    B(a) = mu_0 I / (2 pi a)
    = qty("2.0e-2", "T")
  $

  故电场力大小为 $F_E = e E(a) approx qty("1.75e-12", "N")$

  方向为径向向外.

  磁力大小为 $F_B = e v B(a) approx qty("5.27e-13", "N")$

  方向为径向向内.

  因此总力为

  $
    F = F_E - F_B
    approx qty("1.23e-12", "N")
  $

  方向为径向向外.

  当电子动能为 10 MeV 时 $kg = 1 + 10000 / 511 approx 20.569$,
  $kb = sqrt(1 - 1 / kg^2) approx 0.99882$,
  $v = kb c approx qty("2.9944e8", "m/s")$.

  于是

  $
    E(a) = I / (2 pi ke_0 a v)
    approx qty("6.00e6", "V/m")
    B(a) = mu_0 I / (2 pi a)
    = qty("2.0e-2", "T")
  $

  故电场力大小为 $F_E = e E(a) approx qty("9.62e-13", "N")$

  方向为径向向外.

  磁力大小为 $F_B = e v B(a) approx qty("9.60e-13", "N")$

  方向为径向向内.

  因此总力为

  $
    F = F_E - F_B
    approx qty("2.27e-15", "N")
  $

  方向仍为径向向外.

  = 第五次作业

  == Mo 和 W 的 Kα 射线能量与最低激发电子能量

  查 NIST X-ray Transition Energies 数据库可得, Mo 和 W 的 K 系特征线与 K
  吸收边为:

  #table(
    columns: 5,
    [材料],
    [$K ka_2$ / keV],
    [$K ka_1$ / keV],
    [$K$ edge / keV],
    [最低电子能量],

    [Mo], [17.374], [17.479], [20.000], [$E_e >= qty("20.0", "keV")$],
    [W], [57.982], [59.319], [69.525], [$E_e >= qty("69.5", "keV")$],
  )

  这里 $K ka_1$ 对应 $K L_3$ 跃迁, $K ka_2$ 对应 $K L_2$ 跃迁. 产生 Kα
  特征射线的必要条件是入射电子能量至少能够打出 K 壳层空穴, 因此最低电子能量由 K
  edge 决定, 而不是由 Kα 光子能量本身决定.

  == 50 keV、100 keV、150 keV 管压下的 X 光管能谱示意

  X 光管能谱由连续轫致辐射和靶材特征线组成. 管压为 $V$ 时, 连续谱最高光子能量为
  $E_"max" = e V.$

  下面用 Kramers 形式作定性示意:

  $
    I(E) prop (E_"max" - E) / E_"max" \
    0 < E < E_"max".
  $

  当 $E_"max"$ 超过靶材 K edge 时, 谱中出现 Kα 和 Kβ 特征峰; 否则没有 K
  系特征线. 示意图中红线为 Kα, 蓝线为 Kβ.

  #let energy = lq.linspace(0.1, 150)
  #let brem(e, emax) = if e < emax { (emax - e) / emax } else { 0 }
  #let peak(e, edge, h) = if e > edge { h } else { 0 }
  #let spectrum(emax, edge, k-a-energy, k-b-energy, title) = {
    lq.diagram(
      xlabel: [$E_kg$ / keV],
      ylabel: [相对强度],
      lq.plot(energy, e => brem(e, emax), mark: none, label: [连续谱]),
      lq.path(
        (k-a-energy, 0),
        (k-a-energy, peak(emax, edge, 1.25)),
        stroke: red + 0.9pt,
        label: [$K ka$],
      ),
      lq.path(
        (k-b-energy, 0),
        (k-b-energy, peak(emax, edge, 0.75)),
        stroke: blue + 0.9pt,
        label: [$K kb$],
      ),
      lq.path(
        (emax, 0),
        (emax, 1.05),
        stroke: gray + 0.5pt,
        label: [$E_"max"$],
      ),
    )
  }

  #canvas(
    grid(
      columns: 2,
      row-gutter: 1em,
      [
        *Mo, 50 kV*

        #spectrum(50, 20.000, 17.479, 19.608, [Mo 50 kV])
      ],
      [
        *W, 50 kV*

        #spectrum(50, 69.525, 59.319, 67.245, [W 50 kV])
      ],

      [
        *Mo, 100 kV*

        #spectrum(100, 20.000, 17.479, 19.608, [Mo 100 kV])
      ],
      [
        *W, 100 kV*

        #spectrum(100, 69.525, 59.319, 67.245, [W 100 kV])
      ],

      [
        *Mo, 150 kV*

        #spectrum(150, 20.000, 17.479, 19.608, [Mo 150 kV])
      ],
      [
        *W, 150 kV*

        #spectrum(150, 69.525, 59.319, 67.245, [W 150 kV])
      ],
    ),
  )

  从图中可以看出: Mo 的 K edge 约为 20.0 keV, 所以在 50 kV、100 kV 和 150 kV
  下都可激发 Mo 的 Kα 特征线; W 的 K edge 约为 69.5 keV, 所以 50 kV 时不能激发 W
  的 Kα 特征线, 100 kV 和 150 kV 时可以激发.

  == 考虑靶自吸收后的 X 射线转换效率

  X 光管中电子能量转化为 X 射线能量的经验效率可估算为
  $eta_0 approx 9 times 10^(-10) Z V,$

  其中 $Z$ 为靶材原子序数, $V$ 用伏特计. 若产生的 X 光子约 40% 被靶自吸收,
  则出射 X 射线效率为 $eta = 0.6 eta_0.$

  Mo 的原子序数为 $Z = 42$, W 的原子序数为 $Z = 74$. 对不同管压有:

  #table(
    columns: 5,
    [材料], [管压], [$eta_0$], [考虑 40% 自吸收后 $eta$], [百分数],
    [Mo], [50 kV], [0.00189], [0.00113], [0.113%],
    [Mo], [100 kV], [0.00378], [0.00227], [0.227%],
    [Mo], [150 kV], [0.00567], [0.00340], [0.340%],
    [W], [50 kV], [0.00333], [0.00200], [0.200%],
    [W], [100 kV], [0.00666], [0.00400], [0.400%],
    [W], [150 kV], [0.00999], [0.00599], [0.599%],
  )

  因此在 50--150 kV 范围内, 考虑 40% 靶自吸收后, Mo 靶最终电子能量转化为出射 X
  射线能量的效率约为 $0.11%--0.34%$, W 靶约为 $0.20%--0.60%$. W 的原子序数更高,
  因而在相同管压下转换效率更高.

  = 第六次作业

  == 从 Larmor 公式推导辐射表达式

  非相对论情形下, 加速电荷的总辐射功率由 Larmor 公式给出:
  $P = q^2 a^2 / (6 pi ke_0 c^3)$

  对相对论运动电子, 不能直接把实验室系中的加速度代入这个式子.
  正确的做法是在电子的瞬时静止系中使用 Larmor 公式,
  再把瞬时静止系中的加速度用实验室系中的加速度表示出来.

  设实验室系为 $S$, 电子速度为 $va(v)$, 实验室系加速度为 $va(a) = dv(va(v), t).$

  在某一瞬间取电子的瞬时静止系 $S'$. 在 $S'$ 中电子瞬时速度为零,
  因而可以使用非相对论 Larmor 公式: $P' = q^2 a'^2 / (6 pi ke_0 c^3).$

  这里的 $a'$ 是瞬时静止系中的加速度, 不是实验室系中的 $a$.
  将实验室系加速度分解为平行于速度和垂直于速度的两部分:

  $
    va(a) = va(a)_parallel + va(a)_perp \
    va(a)_parallel parallel va(v) \
    va(a)_perp perp va(v).
  $

  洛伦兹变换下, 加速度分量满足

  $
    a'_parallel = kg^3 a_parallel \
    a'_perp = kg^2 a_perp.
  $

  因此瞬时静止系中的加速度平方为

  $
    a'^2
    = a'_parallel^2 + a'_perp^2
    = kg^6 a_parallel^2 + kg^4 a_perp^2.
  $

  代入 Larmor 公式得到

  $
    P'
    = q^2 / (6 pi ke_0 c^3)
    (kg^6 a_parallel^2 + kg^4 a_perp^2).
  $

  对总辐射功率, 可以取 $P = P'$. 原因是: 在瞬时静止系中,
  总辐射动量对角度积分后为零; 辐射四动量变换到实验室系时,
  辐射能量和时间间隔都乘以同一个 $kg$ 因子, 因而二者之比, 即总功率保持不变.
  所以实验室系中的辐射功率为

  $
    P
    = q^2 / (6 pi ke_0 c^3)
    (kg^6 a_parallel^2 + kg^4 a_perp^2).
  $

  这就是 Liénard 公式的一种常用分量形式.

  接下来把它改写为矢量形式. 由于 $a^2 = a_parallel^2 + a_perp^2,$

  且 $abs(va(v) times va(a))^2 = v^2 a_perp^2,$

  所以

  $
    a^2 - abs(va(v) times va(a))^2 / c^2
    = a_parallel^2 + a_perp^2 - kb^2 a_perp^2
    = a_parallel^2 + (1 - kb^2) a_perp^2.
  $

  又因为 $1 - kb^2 = 1 / kg^2,$

  因此

  $
    a^2 - abs(va(v) times va(a))^2 / c^2
    = a_parallel^2 + a_perp^2 / kg^2.
  $

  两边乘以 $kg^6$, 有

  $
    kg^6 (a^2 - abs(va(v) times va(a))^2 / c^2)
    = kg^6 a_parallel^2 + kg^4 a_perp^2.
  $

  于是总辐射功率可写为

  $
    P
    = q^2 kg^6 / (6 pi ke_0 c^3)
    (a^2 - abs(va(v) times va(a))^2 / c^2).
  $

  这就是 Liénard 公式的矢量形式.

  下面讨论两个特殊情况.

  若加速度与速度方向平行, 即 $va(a) parallel va(v)$, 则 $va(v) times va(a) = 0.$

  因此 $P_parallel = q^2 kg^6 a^2 / (6 pi ke_0 c^3).$

  若加速度与速度方向垂直, 即 $va(a) perp va(v)$, 则
  $abs(va(v) times va(a))^2 = v^2 a^2.$

  因而

  $
    a^2 - abs(va(v) times va(a))^2 / c^2
    = a^2 (1 - kb^2)
    = a^2 / kg^2.
  $

  代入 Liénard 公式得

  $
    P_perp
    = q^2 kg^6 / (6 pi ke_0 c^3) a^2 / kg^2
    = q^2 kg^4 a^2 / (6 pi ke_0 c^3).
  $

  因此, 平行加速时辐射功率随 $kg^6$ 增强, 垂直加速时辐射功率随 $kg^4$ 增强.
  关键原因是 Larmor 公式中的加速度应理解为 瞬时静止系中的加速度,
  而实验室系中的平行加速度和垂直加速度在洛伦兹变换下具有不同的 $kg$ 因子.

  == Compton 散射低能极限下电子反冲角和动能

  设入射光子能量为 $h nu_i$, 沿 $x$ 方向传播; 散射光子能量为 $h nu_s$, 散射角为
  $kt$; 反冲电子动量与入射方向夹角为 $phi$. 光子动量守恒给出
  $p_e cos phi = h nu_i / c - h nu_s / c cos kt$,
  $p_e sin phi = h nu_s / c sin kt$.

  因而

  $
    tan phi
    = (nu_s sin kt) / (nu_i - nu_s cos kt).
  $

  Compton 散射公式为 $1 / nu_s - 1 / nu_i = h / (m_e c^2) (1 - cos kt),$

  或写成

  $
    nu_s = nu_i / (1 + ka (1 - cos kt)) \
    ka = h nu_i / (m_e c^2).
  $

  当 $h nu_i << m_e c^2$ 时, 有 $ka << 1$, 因而可取 $nu_s approx nu_i$. 于是

  $
    tan phi
    approx sin kt / (1 - cos kt).
  $

  利用三角恒等式

  $
    sin kt = 2 sin(kt / 2) cos(kt / 2) \
    1 - cos kt = 2 sin^2(kt / 2)
  $

  得 $tan phi approx cot(kt / 2).$

  因此 $cot(kt / 2) approx tan phi.$

  接下来求反冲电子动能. 能量守恒为 $E_k = h nu_i - h nu_s.$

  由上式

  $
    h nu_s
    = (h nu_i) / (1 + ka (1 - cos kt)).
  $

  因此

  $
    E_k
    = h nu_i (1 - 1 / (1 + ka (1 - cos kt))).
  $

  在 $ka << 1$ 时,

  $
    E_k approx h nu_i ka (1 - cos kt)
    = (h nu_i)^2 / (m_e c^2) (1 - cos kt).
  $

  由前面的角度关系 $tan phi = cot(kt / 2)$ 可知 $phi approx pi / 2 - kt / 2$,
  因而 $cos phi = sin(kt / 2).$

  又 $1 - cos kt = 2 sin^2(kt / 2) = 2 cos^2 phi.$

  所以 $E_k approx h nu_i (2 h nu_i) / (m_e c^2) cos^2 phi.$

  即 $E_k approx ((h nu_i)^2) / (m_e c^2) 2 cos^2 phi.$

  这说明在低能 Compton 散射中, 反冲电子动能相对入射光子能量是二阶小量, 其大小随
  $cos^2 phi$ 改变.

  == 环形加速器中同步辐射能量损失估算

  带电粒子在环形加速器中作横向加速运动, 单圈同步辐射能量损失可写为
  $U_0 = C_kg / (2 pi) E^4 int 1 / rho^2 dd(s).$

  若近似为半径为 $rho$ 的圆形轨道, 则
  $int 1 / rho^2 dd(s) = (2 pi rho) / rho^2 = 2 pi / rho,$

  因而 $U_0 = C_kg E^4 / rho.$

  对电子常用工程公式为 $U_0["keV"] = 88.5 (E["GeV"])^4 / rho["m"].$

  对 CEPC, 周长约为 $C = qty("100", "km"),$

  轨道半径近似为

  $
    rho = C / (2 pi)
    = (100000 / (2 pi)) unit("m")
    approx qty("1.59e4", "m").
  $

  当电子能量为 $E = qty("120", "GeV")$ 时,

  $
    U_0
    = (88.5 times 120^4 / (1.59 times 10^4)) unit("keV")
    approx qty("1.15e6", "keV").
  $

  即 $U_0 approx qty("1.15", "GeV").$

  因此, 在这个近似下 CEPC 中 120 GeV 电子每运动一圈约损失 $qty("1.15", "GeV")$
  的能量.

  对质子, 同一能量和弯曲半径下同步辐射能损相对于电子要乘以 $(m_e / m_p)^4,$

  因为同步辐射强度随粒子质量的四次方反比缩放. 因而可写为

  $
    U_(0,p)["keV"]
    = 88.5 (E_p["GeV"])^4 / rho["m"] (m_e / m_p)^4.
  $

  题给 SPPC 中质子能量为 $E_p = qty("75", "TeV") = qty("7.5e4", "GeV").$

  仍取周长 100 km 对应的 $rho approx qty("1.59e4", "m")$, 且
  $m_p / m_e approx 1836$. 则

  $
    U_(0,p)
    = 88.5 (7.5 times 10^4)^4 / (1.59 times 10^4)
    ((1 / 1836)^4) unit("keV")
    approx qty("1.55e4", "keV").
  $

  即 $U_(0,p) approx qty("15.5", "MeV").$

  这个结果远小于同周长、同量级能量电子束的同步辐射损失,
  但对于高流强质子环仍然不是完全可以忽略的工程量.

  = 第七次作业

  == 当直线加速电场达到多大时, 电子能量不再增加

  电子作直线加速时, 加速度与速度平行. 此时相对论辐射功率可写为

  $
    P_"rad"
    = e^2 kg^6 a^2 / (6 pi ke_0 c^3)
  $

  而平行于速度方向受力时 $e E = kg^3 m_e a$

  故 $a = e E / (kg^3 m_e)$

  代回得

  $
    P_"rad"
    = e^4 E^2 / (6 pi ke_0 m_e^2 c^3)
  $

  电场对电子做功的速率为 $P_"acc" = e E v = e E kb c$

  当电子能量不再增加时, 有 $P_"rad" = P_"acc"$, 因而
  $e^4 E^2 / (6 pi ke_0 m_e^2 c^3) = e E kb c$,
  $E = (6 pi ke_0 m_e^2 c^4 kb) / e^3$.

  对高能电子可取 $kb approx 1$, 于是临界电场为
  $E_"crit" = (6 pi ke_0 m_e^2 c^4) / e^3$

  代入 $ke_0 = qty("8.854e-12", "F/m")$, $m_e = qty("9.109e-31", "kg")$,
  $e = qty("1.602e-19", "C")$, $c = qty("3.00e8", "m/s")$.

  得 $E_"crit" approx qty("2.72e20", "V/m")$

  因此, 直线加速电场要达到约 $E_"crit" approx qty("2.7e20", "V/m")$

  时, 电子辐射损失才会与加速获得的能量相等. 这个数值极高,
  远高于通常加速器中的电场.

  == HEPS 参数计算

  已知电子束能量 $E_e = qty("6", "GeV")$, 束流流强
  $I = qty("200", "mA") = qty("0.2", "A")$.

  电子的相对论因子为
  $kg = E_e / (m_e c^2) approx 6000 / 0.511 approx 1.174 times 10^4$

  === A) 弯铁辐射总功率与特征波长

  题给弯铁长度 $L = qty("0.857", "m")$, 偏转半径 $rho = qty("20", "m")$.

  同步辐射中, 电子经过长度 $L$ 的弯铁所损失的能量可写为
  $U = 88.5 E_e^4 L / rho^2$

  其中 $U$ 的单位为 keV, $E_e$ 取 GeV, $L$ 与 $rho$ 取 m.

  代入数值

  $
    U = 88.5 times 6^4 times 0.857 / 20^2
    approx qty("245.7", "keV")
  $

  这就是单个电子经过该偏转磁铁一次损失的辐射能量.

  于是该弯铁对应的总辐射功率为 $P = U I$

  注意这里 $U = qty("245.7", "keV")$ 可视作 $qty("245.7", "kV")$ 的等效电压, 故

  $
    P = 245.7 times 10^3 times 0.2
    approx qty("4.91e4", "W")
  $

  即 $P approx qty("49.1", "kW")$

  弯铁辐射的特征波长取临界波长 $kl_c = 4 pi rho / (3 kg^3)$

  代入 $rho = qty("20", "m")$, $kg approx 1.174 times 10^4$, 得

  $
    kl_c
    = 4 pi times 20 / (3 times (1.174 times 10^4)^3)
    approx qty("5.18e-11", "m")
  $

  即 $kl_c approx qty("0.0518", "nm")$

  对应的特征光子能量约为 $E_c = h c / kl_c approx qty("24.0", "keV")$

  因此 A 问结果为: $P approx qty("49.1", "kW")$,
  $kl_c approx qty("0.0518", "nm")$.

  === B) ID19 波荡器基频波长与带宽

  已知波荡器周期长度 $kl_u = qty("22.6", "mm") = qty("2.26e-2", "m")$,
  $K = 2.3$, $N = 174$.

  波荡器轴线上第 $n$ 次谐波的波长为
  $kl_n = kl_u / (2 n kg^2) (1 + K^2 / 2 + kg^2 kt^2)$

  基频光对应 $n = 1$, 且取轴上观察方向 $kt = 0$, 因而
  $kl_1 = kl_u / (2 kg^2) (1 + K^2 / 2)$

  代入数值

  $
    kl_1
    = (2.26 times 10^(-2)) / (2 times (1.174 times 10^4)^2)
    (1 + 2.3^2 / 2)
    approx qty("2.99e-10", "m")
  $

  即 $kl_1 approx qty("0.299", "nm")$

  对应光子能量约为 $E_1 = h c / kl_1 approx qty("4.15", "keV")$

  有限周期数 $N$ 导致基频谱线具有自然带宽, 量级可估算为
  $kD kl / kl_1 approx 1 / N$

  故 $kD kl / kl_1 approx 1 / 174 approx 5.75 times 10^(-3)$

  即相对带宽约为 $0.575%$

  于是绝对带宽约为

  $
    kD kl
    approx kl_1 / N
    approx (0.299 / 174) unit("nm")
    approx qty("1.72e-3", "nm")
  $

  若取常见的 FWHM 估算, 则
  $kD kl / kl_1 approx 0.89 / N approx 5.11 times 10^(-3)$

  与上面的数量级一致.

  因此 B 问结果为:

  $
    kl_1 approx qty("0.299", "nm") \
    kD kl / kl_1 approx 5.7 times 10^(-3)
  $

  即基频光约为 4.15 keV, 相对带宽约为 $0.5%$ 到 $0.6%$.

  = 第八次作业

  == 周期高斯微束列的聚束因子与基频谱宽

  设单个微束团的纵向时间分布为
  $f_0(t) = 1 / (sqrt(2 pi) ks_e) exp(-t^2 / (2 ks_e^2))$

  若电子束由 $N$ 个相同微束团组成, 相邻微束团间隔为 $T = 10 ks_e$,
  则归一化后的总分布可写为 $f_N(t) = 1 / N sum_(n=0)^(N-1) f_0(t - n T)$

  即

  $
    f_N(t)
    = 1 / (N sqrt(2 pi) ks_e)
    sum_(n=0)^(N-1) exp(-(t - n T)^2 / (2 ks_e^2)).
  $

  下面给出 $N = 8$, $ks_e = 1$, $T = 10 ks_e$ 时的分布示意:

  #let ks-e = 1
  #let micro-t = 10 * ks-e
  #let g(t, n) = calc.exp(
    -calc.pow(t - n * micro-t, 2) / (2 * ks-e * ks-e),
  )
  #let train(t) = (
    (
      g(t, 0)
        + g(t, 1)
        + g(t, 2)
        + g(t, 3)
        + g(t, 4)
        + g(t, 5)
        + g(t, 6)
        + g(t, 7)
    )
      / (8 * calc.sqrt(2 * calc.pi) * ks-e)
  )
  #let tt = lq.linspace(-5, 75)

  #canvas(
    lq.diagram(
      xlabel: [$t / ks_e$],
      ylabel: [$f_N(t)$],
      lq.plot(tt, train),
    ),
  )

  按聚束因子的定义 $b(ko) = int_(-inft)^(inft) f_N(t) exp(-i ko t) dd(t),$

  代入上式可得

  $
    b(ko)
    = exp(-ko^2 ks_e^2 / 2)
    1 / N sum_(n=0)^(N-1) exp(-i ko n T).
  $

  利用有限等比级数,

  $
    sum_(n=0)^(N-1) exp(-i ko n T)
    = exp(-i ko T (N - 1) / 2)
    (sin(N ko T / 2)) / (sin(ko T / 2)).
  $

  因此聚束因子为

  $
    b(ko)
    = exp(-ko^2 ks_e^2 / 2)
    exp(-i ko T (N - 1) / 2)
    (sin(N ko T / 2)) / (N sin(ko T / 2)).
  $

  通常更关心其模:

  $
    abs(b(ko))
    = exp(-ko^2 ks_e^2 / 2)
    abs((sin(N ko T / 2)) / (N sin(ko T / 2))).
  $

  这个结果可以分成两部分理解. 第一项 $exp(-ko^2 ks_e^2 / 2)$ 是单个高斯微束团的
  form factor, 决定整个频谱的包络; 第二项是长度为 $N$ 的周期列给出的 Dirichlet
  因子, 决定谱线出现在 $ko_m = 2 pi m / T$, $m = 0, 1, 2, ...$

  附近.

  在第 $m$ 次谐波处,

  $
    abs(b_m) = exp(-(m ko_0 ks_e)^2 / 2) \
    ko_0 = 2 pi / T.
  $

  本题中 $T = 10 ks_e$, 所以基频处

  $
    abs(b_1)
    = exp(-1 / 2 (2 pi ks_e / T)^2)
    = exp(-1 / 2 (2 pi / 10)^2)
    approx 0.821.
  $

  基频附近令 $ko = ko_0 + kd ko$. 当 $abs(kd ko) T << 1$ 时,

  $
    abs(b(ko))
    approx exp(-ko_0^2 ks_e^2 / 2)
    abs((sin(N kd ko T / 2)) / (N sin(kd ko T / 2))).
  $

  其第一个零点满足 $N kd ko T / 2 = pi,$

  故半宽到第一个零点为 $kd ko_"zero" = 2 pi / (N T).$

  两个一阶零点之间的全宽为 $kD ko_"zero" = 4 pi / (N T).$

  若用强度谱 $abs(b)^2$ 的半高全宽估算, sinc 平方函数给出
  $kD ko_"FWHM" / ko_0 approx 0.89 / N.$

  因此基频谱宽主要由周期数 $N$ 决定: $N$ 越大, 谱线越窄. 微束团宽度 $ks_e$
  主要通过高斯包络影响各谐波强度; $ks_e$ 越小, 高频谐波衰减越慢. 对本题
  $T = 10 ks_e$, 基频仍有较强聚束, 但更高谐波会按 $exp(-(m 2 pi / 10)^2 / 2)$
  快速下降.

  == LCLS 自由电子激光参数估算

  已知 LCLS 自由电子激光装置的辐射波长为
  $kl_r = qty("1.5", "angstrom") = qty("1.5e-10", "m"),$

  波荡器周期 $kl_u = qty("3", "cm") = qty("3.0e-2", "m"),$

  $K = 3.5$, 周期数 $N_u = 3328$, 归一化发射度
  $ke_n = qty("0.5", "mm") dot "mrad"$, Pierce 参数 $rho = 5 times 10^(-4)$.

  对平面波荡器, 轴上基频共振条件为 $kl_r = kl_u / (2 kg^2) (1 + K^2 / 2).$

  所以电子束的相对论因子为

  $
    kg
    = sqrt(kl_u (1 + K^2 / 2) / (2 kl_r)).
  $

  代入数值,

  $
    kg
    = sqrt(
      (3.0 times 10^(-2)) (1 + 3.5^2 / 2)
      / (2 times 1.5 times 10^(-10))
    )
    approx 2.67 times 10^4.
  $

  电子束能量为

  $
    E_e = kg m_e c^2
    approx (2.67 times 10^4) times qty("0.511", "MeV")
    approx qty("1.36e4", "MeV")
    approx qty("13.6", "GeV").
  $

  一维 FEL 功率增益长度可估算为 $L_g = kl_u / (4 pi sqrt(3) rho).$

  因此

  $
    L_g
    = (3.0 times 10^(-2))
    / (4 pi sqrt(3) times 5 times 10^(-4))
    approx qty("2.76", "m").
  $

  波荡器总长度为
  $L_u = N_u kl_u = 3328 times qty("0.03", "m") approx qty("99.8", "m").$

  若按 SASE 饱和长度约为 $15--20$ 个增益长度估算, 则
  $L_"sat" approx (15--20) L_g approx qtyrange("41", "55", "m"),$

  小于波荡器总长度, 因而该参数下可以达到饱和输出.

  按课件中的一维 FEL scaling, SASE 辐射的相对带宽为

  $ kD ko / ko approx 2 rho = 1.0 times 10^(-3). $

  即相对带宽约为 $0.10%.$

  有限波荡器周期数给出的自然线宽量级为 $1 / N_u approx 3.0 times 10^(-4),$

  小于 $2 rho$, 所以 SASE 饱和输出带宽主要由 Pierce 参数决定.

  SASE 饱和输出的尖峰时间宽度可用合作长度估算. 课件给出的合作长度为

  $ L_c = kl_r / (4 pi rho). $

  因而

  $
    kD t_"spike" approx L_c / c
    = kl_r / (4 pi rho c).
  $

  代入 $kl_r = qty("1.5e-10", "m")$, $rho = 5 times 10^(-4)$,
  $c = qty("3.0e8", "m/s")$, 得

  $
    kD t_"spike"
    approx (1.5 times 10^(-10))
    / (4 pi times 5 times 10^(-4) times 3.0 times 10^8)
    approx qty("8.0e-17", "s").
  $

  即 $kD t_"spike" approx qty("0.08", "fs")$, 数量级为 $qty("0.1", "fs")$.

  综上,

  $
    E_e approx qty("13.6", "GeV") \
    L_g approx qty("2.8", "m") \
    kD ko / ko approx 1.0 times 10^(-3) \
    kD t_"spike" approx qty("0.1", "fs").
  $

  = 第九次作业

  == 波荡器辐射产生 100 keV 硬 X 射线所需电子能量

  题给波荡器周期长度 $kl_u = qty("2.5", "cm") = qty("2.5e-2", "m"),$

  最大磁场 $B_0 = qty("0.45", "T").$

  波荡器参数为

  $
    K = e B_0 kl_u / (2 pi m_e c)
    approx 0.934 B_0["T"] kl_u ["cm"].
  $

  代入数值有 $K approx 0.934 times 0.45 times 2.5 approx 1.05.$

  对平面波荡器, 第一次谐波在观察角 $kt = 0$ 方向的波长为

  $
    kl_r
    = kl_u / (2 kg^2) (1 + K^2 / 2).
  $

  100 keV 光子的波长为

  $
    kl_r = (h c) / E_kg
    = (qty("1239.84", "eV nm")) / (qty("1.0e5", "eV"))
    approx qty("1.24e-2", "nm")
    = qty("1.24e-11", "m").
  $

  因此

  $
    kg
    = sqrt(kl_u (1 + K^2 / 2) / (2 kl_r)).
  $

  代入数值,

  $
    kg
    = sqrt(
      (2.5 times 10^(-2)) (1 + 1.05^2 / 2)
      / (2 times 1.24 times 10^(-11))
    )
    approx 3.96 times 10^4.
  $

  电子束总能量为

  $
    E_e = kg m_e c^2
    approx (3.96 times 10^4) times qty("0.511", "MeV")
    approx qty("2.02e4", "MeV")
    = qty("20.2", "GeV").
  $

  因此, 用该波荡器在轴上产生约 100 keV 的基频硬 X 射线, 所需电子能量约为
  $E_e approx qty("20", "GeV").$

  == 逆康普顿散射产生 100 keV 硬 X 射线所需电子能量

  激光波长为 $kl_L = qty("1064", "nm"),$

  光子能量为

  $
    E_L = h c / kl_L
    = (qty("1239.84", "eV nm")) / (qty("1064", "nm"))
    approx qty("1.165", "eV").
  $

  设入射激光与电子速度方向的夹角为 $ka$, 散射光沿电子正前方观测, 即 $kt = 0$. 在
  Thomson 近似下, 散射光能量可写为

  $
    E_kg
    approx E_L (1 - kb cos ka) / (1 - kb)
    approx 2 kg^2 E_L (1 - cos ka).
  $

  这里忽略了反冲修正, 因为本题所得电子能量下 $kg E_L / (m_e c^2) << 1$.

  对 180 度相互作用, 即激光与电子迎头相撞, $ka = pi$, $E_kg approx 4 kg^2 E_L.$

  因而

  $
    kg = sqrt(E_kg / (4 E_L))
    = sqrt((1.0 times 10^5) / (4 times 1.165))
    approx 146.
  $

  电子束能量为

  $
    E_e = kg m_e c^2
    approx 146 times qty("0.511", "MeV")
    approx qty("74.8", "MeV").
  $

  对 90 度垂直相互作用, $ka = pi / 2$, $E_kg approx 2 kg^2 E_L.$

  因而

  $
    kg = sqrt(E_kg / (2 E_L))
    = sqrt((1.0 times 10^5) / (2 times 1.165))
    approx 207.
  $

  电子束能量为

  $
    E_e = kg m_e c^2
    approx 207 times qty("0.511", "MeV")
    approx qty("106", "MeV").
  $

  因此, 1064 nm 激光产生 100 keV X 射线时, 180 度逆康普顿散射所需电子能量约为 75
  MeV, 90 度散射所需电子能量约为 106 MeV.

  == 逆康普顿散射的 X 射线横向尺寸与脉冲宽度

  题给电子束均方根长度和横向尺寸为

  $
    ks_(e,z) = qty("450", "um") \
    ks_(e,x) = ks_(e,y) = qty("60", "um").
  $

  激光均方根脉冲宽度为 $ks_(l,t) = qty("100", "fs"),$

  对应的空间长度为

  $
    c ks_(l,t)
    approx (3.0 times 10^8 times 100 times 10^(-15)) unit("m")
    approx qty("30", "um").
  $

  记激光纵向空间长度 $ks_(l,z) = c ks_(l,t) approx qty("30", "um")$,
  并取激光两个横向方向的均方根尺寸为
  $ks_(l,x) = ks_(l,y) = qty("15", "um").$

  两个高斯分布相乘后, 有效相互作用区的均方根尺寸为

  $
    ks_"eff"
    = (1 / ks_1^2 + 1 / ks_2^2)^(-1/2).
  $

  对 180 度迎头散射, 激光沿电子束轴向传播, 因此 X
  射线横向尺寸主要由电子束横向尺寸与 激光焦斑横向尺寸的重叠决定:

  $
    ks_x = ks_y
    = (1 / 60^2 + 1 / 15^2)^(-1/2) unit("um")
    approx qty("14.6", "um").
  $

  轴向前方观测时, X 射线脉宽主要由电子束纵向长度决定. 用
  $ks_t approx ks_(e,z) / c$ 估算,

  $
    ks_t
    approx (qty("450", "um")) / c
    approx qty("1.5", "ps").
  $

  对 90 度垂直散射, 设激光沿电子束横向 $x$ 方向传播.
  这时不能简单把电子束横向尺寸 与激光纵向长度作二束重叠;
  按课件给出的高斯重叠积分, $x$ 方向源尺寸为

  $
    ks_x
    = (ks_(e,x) sqrt(ks_(l,z)^2 + ks_(e,z)^2 + ks_(l,x)^2))
    / sqrt(ks_(l,z)^2 + ks_(e,z)^2 + ks_(l,x)^2 + ks_(e,x)^2) \
    = (60 sqrt(30^2 + 450^2 + 15^2))
    / sqrt(30^2 + 450^2 + 15^2 + 60^2) unit("um") \
    approx qty("59.5", "um").
  $

  另一个横向方向由电子束横向尺寸与激光焦斑横向尺寸决定:

  $
    ks_y
    = (1 / 60^2 + 1 / 15^2)^(-1/2) unit("um")
    approx qty("14.6", "um").
  $

  对沿电子正前方的 X 射线脉宽, 课件中 90 度对撞的结果为

  $
    ks_t
    = (ks_(e,z) sqrt(ks_(l,x)^2 + ks_(e,x)^2 + ks_(l,z)^2))
    / (c sqrt(ks_(l,x)^2 + ks_(e,x)^2 + ks_(l,z)^2 + ks_(e,z)^2)).
  $

  代入数值,

  $
    ks_t
    = (450 sqrt(15^2 + 60^2 + 30^2))
    / sqrt(15^2 + 60^2 + 30^2 + 450^2) unit("um") / c \
    approx qty("68.0", "um") / c
    approx qty("0.23", "ps").
  $

  所以两种散射几何的结果可概括为

  $
    "180 degree": \
    ks_x approx ks_y approx qty("14.6", "um") \
    ks_t approx qty("1.5", "ps") \
    "90 degree": \
    ks_x approx qty("59.5", "um") \
    ks_y approx qty("14.6", "um") \
    ks_t approx qty("0.23", "ps").
  $

]

#hw
