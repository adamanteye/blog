#import "/page.typ": *
#import "meta.typ": desc, title
#show: conf.with(title: title, desc: desc)

= 束流的相空间分布

已知漂移段无外力, 无自场, 粒子横向斜率 $x' = v_x/v_z$ 在漂移中保持不变,
而横向位置随纵向传播距离 $L$ 发生线性漂移:
$ x(L) = x(0) + L x'(0) $

#canvas(lq.diagram(
  xlabel: [$x$],
  ylabel: [$x'$],
  lq.path((0, 0), (4, 2), (0, 2), (0, -2), (-4, -2), (0, 0)),
))

右上角与左下角顶点分别为 $(2a,b), (-2a,-b)$

= 电子能量分布

$ gamma = 1+E_k/(m_e c^2), beta=sqrt(1-1/gamma^2) $

#let x = lq.linspace(1, 7).map(it => calc.pow(10, it))
#canvas(
  grid(
    columns: 2,
    lq.diagram(
      xscale: lq.scale.log(base: 10),
      xlabel: [$E_k$ /eV],
      ylabel: [$gamma$],
      lq.plot(x, x => (1 + x / 511000)),
    ),
    lq.diagram(
      xscale: lq.scale.log(base: 10),
      xlabel: [$E_k$ /eV],
      ylabel: [$beta$],
      lq.plot(x, x => (calc.sqrt(1 - 1 / calc.pow(1 + x / 511000, 2)))),
    ),
  ),
)

= 电子 de Broglie 波长

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
    xlabel: [$E_k$ /eV],
    ylabel: [$lambda$],
    lq.plot(x, Ek => (hc / calc.sqrt(Ek * Ek + 2 * Ek * 511000))),
  ),
)


= 200 keV 电镜中电子平均纵向间距

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
