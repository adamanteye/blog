#import "/page.typ": *
#import "meta.typ": desc, title
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
]

#hw
