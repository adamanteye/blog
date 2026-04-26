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

  $ gamma = 1+E_k/(m_e c^2), beta=sqrt(1-1/gamma^2) $

  #let x = lq.logspace(1, 7)
  #canvas(
    grid(
      columns: 2,
      lq.diagram(
        xscale: lq.scale.log(base: 10),
        xlabel: [$E_k$/eV],
        ylabel: [$gamma$],
        lq.plot(x, x => (1 + x / 511000)),
      ),
      lq.diagram(
        xscale: lq.scale.log(base: 10),
        xlabel: [$E_k$/eV],
        ylabel: [$beta$],
        lq.plot(x, x => (calc.sqrt(1 - 1 / calc.pow(1 + x / 511000, 2)))),
      ),
    ),
  )

  == 电子 de Broglie 波长

  电子的相对论动量满足
  $ (p c)^2=(E_k + m_e c^2)^2 - (m_e c^2)^2 = E_k^2 + 2 E_k m_e c^2 $

  de Broglie 波长
  $ lambda=h/p=(h c)/(p c) $

  取常数 $h c=1239.84$
  $ lambda=1239.84/ sqrt(E_k^2 + 2 E_k m_e c^2) $


  #let hc = 1239.841984
  #canvas(
    lq.diagram(
      xscale: lq.scale.log(base: 10),
      yscale: lq.scale.log(base: 10),
      xlabel: [$E_k$/eV],
      ylabel: [$lambda$],
      lq.plot(x, Ek => (hc / calc.sqrt(Ek * Ek + 2 * Ek * 511000))),
    ),
  )


  == 200 keV 电镜中电子平均纵向间距

  已知电流 $I=100 unit("pA")$, 电子流率
  $ dot(N) = I/e $

  其中 $e = qty("1.602e-19", "C")$

  对于 $E_k = 200$ KeV 的时候:
  $ gamma = 1 + 200/511 approx 1.391 $

  把电子到达看作平均均匀流, 则平均时间间隔
  $ Delta t approx 1/dot(N) approx 1.60 times 10^-9 text(s) $

  平均纵向间距
  $
    Delta z approx v Delta t = v/dot(N) approx (2.09 times 10^8)/(6.24 times 10^8) approx 0.334 m
  $

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
    f(E) & =1/(1+e^((E-E_F)\/(k_B T))), quad T>0
  $

  并且 $T->0$ 有:

  $
    f(E) & =cases(1 "where" E<E_F, 0 "where" E>E_F)
  $

  接下来考虑金属表面法向取为 $x$ 方向. 电子若要从金属中逸出, 不仅要朝向表面运动,
  还要有足够大的法向动能克服表面势垒.

  设金属内电子能量为

  $
    E = (p_x^2 + p_y^2 + p_z^2)/(2m_0)
  $

  其中 $p_x$ 是垂直于表面的动量分量. 真空能级比金属内费米能级高出功函数 $W$,
  因此若能量以金属内导带底部为零点, 则表面势垒高度为

  $
    E_v = E_F + W
  $

  由于电子穿越表面时, 平行于表面的动量分量 $p_y, p_z$ 守恒,
  因此真正用于"翻过势垒"的是法向动能, 即必须满足

  $
    p_x^2/(2m_0) > E_v = E_F + W
  $

  并且还要有 $p_x > 0$.

  现在计算单位体积, 单位动量空间中的量子态数.

  考虑边长为 $L$, 体积为 $V=L^3$ 的立方体, 对电子取周期性边界条件.
  则允许的波矢为

  $
    k_i = 2pi n_i/L, quad i = x,y,z
  $

  因此在波矢空间中, 每个量子态占据的体积为 $(2pi)^3/V$.

  故单位体积, 单位波矢空间中的态数为 $1/(2pi)^3$.

  再考虑电子的自旋, 为 $2/(2pi)^3$, 记为 $2/(2pi)^3 dd(k, 3)$.

  由 $p = hbar k$ 可知, 单位体积, 单位动量空间中的量子态数为:

  $ 2/((2pi)^3 hbar^3) = 2/h^3 $

  故动量在 $va(p)$ 到 $va(p) + dd(va(p))$ 之间的电子数密度为:

  $
    dd(N) = 2/h^3 f(E) dd(p_x) dd(p_y) dd(p_z)
  $

  这些电子对表面的电流贡献为:
  $
    dd(J) = e v_x dd(N) = e p_x/m_0 2/h^3 f(E) dd(p_x) dd(p_y) dd(p_z)
  $

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
      lq.plot(ts, t => r(t, 2.6), label: [LaB6 2.6 eV]),
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

  势垒顶部满足

  $
    dv(U, x) = -e E_a + e^2/(16pi ke_0 x^2) = 0
  $

  从而

  $
    x_m = sqrt(e/(16pi ke_0 E_a))
  $

  把 $x_m$ 代回势垒, 有

  $
    U(x_m)-W & = -e E_a x_m - e^2/(16pi ke_0 x_m) \
             & = -2 e E_a x_m \
             & = -sqrt(e^3 E_a/(4pi ke_0))
  $

  故 Schottky 势垒降低量为

  $ Delta W = W-U(x_m) = sqrt(e^3 E_a/(4pi ke_0)) $

  当 $E_a = 100 unit("MV/m") = 10^8 unit("V/m")$ 时,

  $
    Delta W = sqrt(e^3 E_a/(4pi ke_0))
    approx num("6.08e-20") text(J)
    approx 0.38 text("eV")
  $

  并且势垒顶点位置为

  $ x_m = sqrt(e/(16pi ke_0 E_a)) approx num("1.90e-9") text(m) $

  == 推导光电发射热发射度的表达式

  这里取阴极表面法向为 $z$, 横向为 $x,y$. 设有效功函数为 $W_"eff"$, 光子能量为
  $h nu$, 则电子逸出后的最大超额能量为

  $ Delta E = h nu - W_"eff" $

  对应的最大动量满足

  $ p_m = sqrt(2m_0 Delta E) $

  在最简单的自由电子模型下, 发射到真空中的电子在动量空间占据半球

  $ p_x^2 + p_y^2 + p_z^2 <= p_m^2, quad p_z > 0 $

  并且穿过表面的粒子流要按法向速度加权, 即

  $ dd(N) = C v_z dd(p, 3) = C p_z/m_0 dd(p, 3) $

  其中 $C$ 为与归一化有关的常数. 在求二阶矩时, 分子分母中的 $C/m_0$ 会相互抵消.

  于是

  $
    sigma_(p_x)^2 = chevron.l p_x^2 chevron.r - chevron.l p_x chevron.r^2
  $

  由对称性可知 $chevron.l p_x chevron.r = 0$, 所以

  $
    sigma_(p_x)^2
    = int p_x^2 dd(N) \/ int dd(N)
    = int p_x^2 p_z dd(p, 3) \/ int p_z dd(p, 3)
  $

  取球坐标, 以 $z$ 为极轴, 有

  $
    p_x = p sin theta cos phi, quad p_z = p cos theta
  $

  以及

  $ dd(p, 3) = p^2 sin theta dd(p) dd(theta) dd(phi) $

  故分母为

  $
    int p_z dd(p, 3) & = int_0^(p_m) p^3 dd(p) int_0^(pi/2) cos theta sin theta dd(theta)
                       int_0^(2pi) dd(phi) \
                     & = 2pi (p_m^4/4) (1/2) \
                     & = (pi p_m^4)/4
  $

  分子为

  $
    int p_x^2 p_z dd(p, 3) & = int_0^(p_m) p^5 dd(p) int_0^(pi/2) sin^3 theta cos theta dd(theta)
                             int_0^(2pi) cos^2 phi dd(phi) \
                           & = (p_m^6/6) (1/4) pi \
                           & = (pi p_m^6)/24
  $

  因此

  $
    sigma_(p_x)^2 = ((pi p_m^6)/24) \/ ((pi p_m^4)/4) = p_m^2/6
  $

  再代入 $p_m^2 = 2m_0 Delta E$, 得

  $
    sigma_(p_x)^2 = (m_0 Delta E) / 3
  $

  即

  $ sigma_(p_x) = sqrt((m_0 Delta E) / 3) $

  对于归一化热发射度,

  $
    epsilon_("n",x)
    = 1/(m_0 c) sqrt(chevron.l x^2 chevron.r chevron.l p_x^2 chevron.r - chevron.l x p_x chevron.r^2)
  $

  若阴极表面位置与横向动量无关, 即 $chevron.l x p_x chevron.r = 0$, 且
  $sigma_x^2 = chevron.l x^2 chevron.r$, 则

  $
    epsilon_("n",x) = (sigma_x sigma_(p_x))/(m_0 c)
  $

  最终得到

  $
    epsilon_("n",x) = sigma_x sqrt((Delta E)/(3m_0 c^2))
  $

  其中 $Delta E = h nu - W_"eff"$

  == 重复 Child-Langmuir 的推导过程

  考虑一维平板真空二极管. 阴极位于 $x=0$, 阳极位于 $x=d$, 阴极电势取为 0,
  阳极电势为 $V$, 即

  $ phi(0)=0, quad phi(d)=V $

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

  积分得

  $
    1/2 phi'^2 = 2A sqrt(phi) + C
  $

  在空间电荷限制发射条件下, 阴极表面电场为 0, 即 $phi'(0)=0$. 再结合 $phi(0)=0$,
  可得 $C=0$. 因此

  $ phi'^2 = 4A sqrt(phi) $

  取正根并分离变量:

  $
    d phi/(d x) = 2 sqrt(A) phi^(1/4) \
    phi^(-1/4) dd(phi) = 2 sqrt(A) dd(x)
  $

  积分得

  $
    4/3 phi^(3/4) = 2 sqrt(A) x
  $

  在 $x=d$ 处取 $phi=V$, 得

  $
    4/3 V^(3/4) = 2 sqrt(A) d
  $

  于是

  $ A = 4/9 V^(3/2)/d^2 $

  代回 $A$ 的定义, 最终得到 Child-Langmuir 定律

  $
    J = (4 ke_0) / 9 sqrt((2e)/m_0) V^(3/2)/d^2
  $

  并且电势分布为

  $
    phi(x) = V (x/d)^(4/3)
  $

  = 第四次作业

  == 重复 Child-Langmuir 的推导过程, 并计算 200 kV, 5 cm 间距极板中的流强密度

  设平板二极管阴极位于 $x = 0$, 阳极位于 $x = d$, 两极板间电压为 $V_0$. 取电势为
  $phi(x)$, 满足

  $
    phi(0) = 0, quad phi(d) = V_0
  $

  设电子从阴极表面近似静止出发, 由能量守恒有

  $
    1/2 m v^2 = e phi
  $

  故电子速度为

  $
    v = sqrt((2 e phi) / m)
  $

  稳恒条件下, 电流密度 $J$ 为常数. 设电荷密度大小为 $abs(rho)$, 则

  $
    J = abs(rho) v
  $

  所以

  $
    abs(rho) = J / v
  $

  由 Poisson 方程,

  $
    (d^2 phi) / (d x^2) = abs(rho) / epsilon_0
  $

  代入上式得

  $
    (d^2 phi) / (d x^2)
    = J / (epsilon_0 v) \
    = J / epsilon_0 sqrt(m / (2 e phi))
  $

  即

  $
    (d^2 phi) / (d x^2)
    = J / epsilon_0 sqrt(m / (2 e)) phi^(-1/2)
  $

  令

  $
    K = J / epsilon_0 sqrt(m / (2 e))
  $

  则有

  $
    (d^2 phi) / (d x^2) = K phi^(-1/2)
  $

  两边同乘 $d phi / d x$, 得

  $
    (d^2 phi) / (d x^2) (d phi) / (d x)
    = K phi^(-1/2) (d phi) / (d x)
  $

  即

  $
    d/(d x) [1/2 ((d phi) / (d x))^2]
    = d/(d x) [2 K phi^(1/2)]
  $

  积分得

  $
    1/2 ((d phi) / (d x))^2 = 2 K phi^(1/2) + C
  $

  在空间电荷限制条件下, 阴极表面电场为零, 即

  $
    phi(0) = 0, quad ((d phi) / (d x))|_(x = 0) = 0
  $

  故积分常数 $C = 0$. 于是

  $
    ((d phi) / (d x))^2 = 4 K phi^(1/2)
  $

  取正根,

  $
    (d phi) / (d x) = 2 sqrt(K) phi^(1/4)
  $

  分离变量并积分:

  $
    phi^(-1/4) d phi = 2 sqrt(K) d x
  $

  $
    integral phi^(-1/4) d phi = integral 2 sqrt(K) d x
  $

  得

  $
    4/3 phi^(3/4) = 2 sqrt(K) x
  $

  在 $x = d$ 处有 $phi = V_0$, 所以

  $
    4/3 V_0^(3/4) = 2 sqrt(K) d
  $

  从而

  $
    sqrt(K) = 2/3 V_0^(3/4) / d
  $

  两边平方得

  $
    K = 4/9 V_0^(3/2) / d^2
  $

  再代回

  $
    K = J / epsilon_0 sqrt(m / (2 e))
  $

  得到 Child-Langmuir 定律

  $
    J
    = 4 epsilon_0 / 9 sqrt((2 e) / m) V_0^(3/2) / d^2
  $

  代入数值

  $
    epsilon_0 = 8.854 times 10^(-12) " F/m"
  $

  $
    e = 1.602 times 10^(-19) " C"
  $

  $
    m = 9.11 times 10^(-31) " kg"
  $

  $
    V_0 = 200 times 10^3 " V"
  $

  $
    d = 5 times 10^(-2) " m"
  $

  故

  $
    J
    = 4 epsilon_0 / 9 sqrt((2 e) / m) V_0^(3/2) / d^2
    approx 8.35 times 10^4 " A/m"^2
  $

  也可写成

  $
    J approx 8.35 " A/cm"^2
  $

  因此, 极板中的空间电荷限制流强密度为

  $
    J approx 8.35 times 10^4 " A/m"^2
  $

  == 无限长圆柱分布电子束流在 $r = 1 " mm"$ 处电子受到的力

  设电子束半径为 $a = 1 " mm" = 1.0 times 10^(-3) " m"$, 束流流强为
  $I = 100 " A"$, 且在圆柱内均匀分布.

  设电子束速度为 $v$, 则线电荷密度大小为

  $
    lambda = I / v
  $

  体电荷密度大小为

  $
    abs(rho) = lambda / (pi a^2) = I / (pi a^2 v)
  $

  对半径为 $a$ 的均匀带电圆柱, 在柱内半径 $r$ 处的电场大小为

  $
    E(r) = abs(rho) r / (2 epsilon_0)
  $

  因此在边界 $r = a$ 处,

  $
    E(a) = I / (2 pi epsilon_0 a v)
  $

  电场方向指向圆柱轴心, 但电子带负电, 所以电子受到的电场力方向为径向向外.
  其大小为

  $
    F_E = e E(a) = e I / (2 pi epsilon_0 a v)
  $

  均匀电流圆柱在柱内半径 $r$ 处的磁场大小为

  $
    B(r) = mu_0 I r / (2 pi a^2)
  $

  故在边界 $r = a$ 处,

  $
    B(a) = mu_0 I / (2 pi a)
  $

  电子沿束流方向运动, 所受磁力大小为

  $
    F_B = e v B(a) = e v mu_0 I / (2 pi a)
  $

  其方向为径向向内.

  所以电子所受总力大小为

  $
    F = F_E - F_B
  $

  即

  $
    F
    = e I / (2 pi a) (1 / (epsilon_0 v) - mu_0 v)
  $

  利用

  $
    mu_0 epsilon_0 = 1 / c^2
  $

  并记

  $
    beta = v / c, quad gamma = 1 / sqrt(1 - beta^2)
  $

  则

  $
    F = e I / (2 pi epsilon_0 a v) (1 - beta^2)
    = e I / (2 pi epsilon_0 a v gamma^2)
  $

  总力方向为径向向外.


  电子静能为

  $
    m c^2 = 511 " keV"
  $

  故

  $
    gamma = 1 + 100 / 511 approx 1.1957
  $

  $
    beta = sqrt(1 - 1 / gamma^2) approx 0.5482
  $

  $
    v = beta c approx 1.6435 times 10^8 " m/s"
  $

  于是

  $
    E(a) = I / (2 pi epsilon_0 a v)
    approx 1.0937 times 10^7 " V/m"
  $

  $
    B(a) = mu_0 I / (2 pi a)
    = 2.0 times 10^(-2) " T"
  $

  故电场力大小为

  $
    F_E = e E(a) approx 1.75 times 10^(-12) " N"
  $

  方向为径向向外.

  磁力大小为

  $
    F_B = e v B(a) approx 5.27 times 10^(-13) " N"
  $

  方向为径向向内.

  因此总力为

  $
    F = F_E - F_B
    approx 1.23 times 10^(-12) " N"
  $

  方向为径向向外.

  当电子动能为 10 MeV 时

  $
    gamma = 1 + 10000 / 511 approx 20.569
  $

  $
    beta = sqrt(1 - 1 / gamma^2) approx 0.99882
  $

  $
    v = beta c approx 2.9944 times 10^8 " m/s"
  $

  于是

  $
    E(a) = I / (2 pi epsilon_0 a v)
    approx 6.00 times 10^6 " V/m"
  $

  $
    B(a) = mu_0 I / (2 pi a)
    = 2.0 times 10^(-2) " T"
  $

  故电场力大小为

  $
    F_E = e E(a) approx 9.62 times 10^(-13) " N"
  $

  方向为径向向外.

  磁力大小为

  $
    F_B = e v B(a) approx 9.60 times 10^(-13) " N"
  $

  方向为径向向内.

  因此总力为

  $
    F = F_E - F_B
    approx 2.27 times 10^(-15) " N"
  $

  方向仍为径向向外.

  = 第七次作业

  == 当直线加速电场达到多大时, 电子能量不再增加

  电子作直线加速时, 加速度与速度平行. 此时相对论辐射功率可写为

  $
    P_"rad"
    = e^2 gamma^6 a^2 / (6 pi epsilon_0 c^3)
  $

  而平行于速度方向受力时

  $
    e E = gamma^3 m_e a
  $

  故

  $
    a = e E / (gamma^3 m_e)
  $

  代回得

  $
    P_"rad"
    = e^4 E^2 / (6 pi epsilon_0 m_e^2 c^3)
  $

  电场对电子做功的速率为

  $
    P_"acc" = e E v = e E beta c
  $

  当电子能量不再增加时, 有 $P_"rad" = P_"acc"$, 因而

  $
    e^4 E^2 / (6 pi epsilon_0 m_e^2 c^3) = e E beta c
  $

  $
    E = (6 pi epsilon_0 m_e^2 c^4 beta) / e^3
  $

  对高能电子可取 $beta approx 1$, 于是临界电场为

  $
    E_"crit" = (6 pi epsilon_0 m_e^2 c^4) / e^3
  $

  代入

  $
    epsilon_0 = 8.854 times 10^(-12) " F/m"
  $

  $
    m_e = 9.109 times 10^(-31) " kg"
  $

  $
    e = 1.602 times 10^(-19) " C"
  $

  $
    c = 3.00 times 10^8 " m/s"
  $

  得

  $
    E_"crit" approx 2.72 times 10^20 " V/m"
  $

  因此, 直线加速电场要达到约

  $
    E_"crit" approx 2.7 times 10^20 " V/m"
  $

  时, 电子辐射损失才会与加速获得的能量相等. 这个数值极高,
  远高于通常加速器中的电场.

  == HEPS 参数计算

  已知电子束能量 $E_e = 6 " GeV"$, 束流流强 $I = 200 " mA" = 0.2 " A"$.

  电子的相对论因子为

  $
    gamma = E_e / (m_e c^2) approx 6000 / 0.511 approx 1.174 times 10^4
  $

  === A) 弯铁辐射总功率与特征波长

  题给弯铁长度 $L = 0.857 " m"$, 偏转半径 $rho = 20 " m"$.

  同步辐射中, 电子经过长度 $L$ 的弯铁所损失的能量可写为

  $
    U = 88.5 E_e^4 L / rho^2
  $

  其中 $U$ 的单位为 keV, $E_e$ 取 GeV, $L$ 与 $rho$ 取 m.

  代入数值

  $
    U = 88.5 times 6^4 times 0.857 / 20^2
    approx 245.7 " keV"
  $

  这就是单个电子经过该偏转磁铁一次损失的辐射能量.

  于是该弯铁对应的总辐射功率为

  $
    P = U I
  $

  注意这里 $U = 245.7 " keV"$ 可视作 $245.7 " kV"$ 的等效电压, 故

  $
    P = 245.7 times 10^3 times 0.2
    approx 4.91 times 10^4 " W"
  $

  即

  $
    P approx 49.1 " kW"
  $

  弯铁辐射的特征波长取临界波长

  $
    lambda_c = 4 pi rho / (3 gamma^3)
  $

  代入 $rho = 20 " m"$, $gamma approx 1.174 times 10^4$, 得

  $
    lambda_c
    = 4 pi times 20 / (3 times (1.174 times 10^4)^3)
    approx 5.18 times 10^(-11) " m"
  $

  即

  $
    lambda_c approx 0.0518 " nm"
  $

  对应的特征光子能量约为

  $
    E_c = h c / lambda_c approx 24.0 " keV"
  $

  因此 A 问结果为:

  $
    P approx 49.1 " kW", quad lambda_c approx 0.0518 " nm"
  $

  === B) ID19 波荡器基频波长与带宽

  已知波荡器周期长度

  $
    lambda_u = 22.6 " mm" = 2.26 times 10^(-2) " m"
  $

  $
    K = 2.3, quad N = 174
  $

  波荡器轴线上第 $n$ 次谐波的波长为

  $
    lambda_n = lambda_u / (2 n gamma^2) (1 + K^2 / 2 + gamma^2 theta^2)
  $

  基频光对应 $n = 1$, 且取轴上观察方向 $theta = 0$, 因而

  $
    lambda_1 = lambda_u / (2 gamma^2) (1 + K^2 / 2)
  $

  代入数值

  $
    lambda_1
    = (2.26 times 10^(-2)) / (2 times (1.174 times 10^4)^2)
    (1 + 2.3^2 / 2)
    approx 2.99 times 10^(-10) " m"
  $

  即

  $
    lambda_1 approx 0.299 " nm"
  $

  对应光子能量约为

  $
    E_1 = h c / lambda_1 approx 4.15 " keV"
  $

  有限周期数 $N$ 导致基频谱线具有自然带宽, 量级可估算为

  $
    Delta lambda / lambda_1 approx 1 / N
  $

  故

  $
    Delta lambda / lambda_1 approx 1 / 174 approx 5.75 times 10^(-3)
  $

  即相对带宽约为

  $
    0.575%
  $

  于是绝对带宽约为

  $
    Delta lambda
    approx lambda_1 / N
    approx 0.299 / 174 " nm"
    approx 1.72 times 10^(-3) " nm"
  $

  若取常见的 FWHM 估算, 则

  $
    Delta lambda / lambda_1 approx 0.89 / N approx 5.11 times 10^(-3)
  $

  与上面的数量级一致.

  因此 B 问结果为:

  $
    lambda_1 approx 0.299 " nm", quad
    Delta lambda / lambda_1 approx 5.7 times 10^(-3)
  $

  即基频光约为 4.15 keV, 相对带宽约为 $0.5%$ 到 $0.6%$.
]

#hw
