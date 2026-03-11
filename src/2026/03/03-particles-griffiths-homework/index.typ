#import "/page.typ": *
#import "meta.typ": desc, title
#show: conf.with(title: title, desc: desc)

#let hw = [
  = 基本粒子物理历史介绍

  == 1.1

  速度为 $E q=q v B=>v=E/B$.

  荷质比为 $q v B=m v^2/R=>q/m=E/(B^2 R)$.

  == 1.2

  粗略说, $m=hbar/(2r_0 c)$, 利用 $r_0=10^(-13)$ cm, 有 $m=98.73 mmev$.

  这与观测到的实际结果 $139.57 mmev$ 相近.

  == 1.3

  取 $Delta x approx 2r_0$, 应该有 $Delta p>=hbar/(4r_0)=49.365 pmev$
  为最小动量. 从能量动量关系, $E=sqrt(m^2c^4+p^2c^2)approx 49.365$ MeV. 考虑氚的
  $beta$ 衰变能最多为十几 KeV, 这个估算不支持衰变电子在原子核内游荡.

  == 计算康普顿散射过程初末态的光子频率的关系

  考虑动量守恒:

  $ p_e^2=p_i^2+p_f^2-2p_i p_f cos theta $

  再考虑能量守恒与能量动量关系:

  $ p_e^2=((m_e c^2+p_i c-p_f c)^2-m_e^2c^4)/c^2 $

  可以得到:

  $
    1-cos theta=m_e c (1/p_f - 1/p_i) =>1-cos theta=(m_e c^2)/h (1/nu_f-1/nu_i)
  $

  == 1.4

  $ 2(m_N+m_Xi)=3m_kL+m_kS $

  考虑 $m_N=938.9185$, $m_Xi=1318.05$, $m_kS=1193.15$. 有 $m_kL$ 大致为
  $1106 mmev$

  == 1.5

  $ 4m_K^2=3m_eta^2+m_pi^2 $

  考虑 $m_pi=138.039$, $m_K=495.66$. 有 $m_eta$ 大致为 $566.8 mmev$.

  == 1.6

  $ m_kD - m_(kS^*)=m_(kS^*)-m_(Xi^*)=m_(Xi^*)-m_kO $

  从而 $m_kO=1683.5mmev$.

  == 1.8

  在强作用中, 奇异数不变 (因为强作用不改变夸克的味道, 奇异夸克的数目守恒).
  而在弱作用中, 夸克的味道可以改变.

  考虑 $kO^-$: 电荷为 -1, 奇异数为 -3. 假设需要通过强作用衰变, 至少有以下反应:

  $
    kO^- & -> Xi^- + overline(K)^0 \
    kO^- & -> kS^- + 2 overline(K)^0 \
    kO^- & -> kS^0 + overline(K)^0+ K^- \
  $

  但 $kO^-$ 质量不足以发生上面的反应. 从而只能通过弱作用衰变.

  从云室照片上看, 假设 $kO^-$ 飞行了 5 mm, 速度 $0.1c$,
  那么实验室坐标系下的寿命为 $qty("1.7e-10", "s")$,
  自身坐标系下的寿命相较实验室坐标系缩短大约 0.5%.

  == 1.12

  介子定义为两个夸克组成, 同时考虑无色的条件, 必须是夸克以及反夸克.

  + $d$: $u ol(u)$
  + $d,u$: $u ol(u)$, $u ol(d)$, ...

  对于 $n$ 种夸克味道, 可以组成 $n^2$ 种夸克.

  此外, 查表可以看到, 实际上并不写成 $u ol(u), d ol(d)$, 而是
  $(u ol(u)-d ol(d))\/sqrt(2),(u ol(u)+d ol(d))\/sqrt(2)$. 但这不影响上面的
  $n^2$ 的结论.

  == 1.13

  对于重子, 考虑无色的条件, 有 $q q q$ 以及 $ol(q) ol(q) ol(q)$ 两种组合,
  但反粒子和粒子本身只算一种.

  + $d$: $d d d$
  + $d,u$:
    $d d d, d d u, d u u, u u u$

  考虑 $n$ 味夸克组成的重子:

  $ n+n(n-1)+(n(n-1)(n-2))/6=(n(n+1)(n+2))/6 $
  == 1.14

  #figure(
    table(
      columns: 2,
      table.header([quarks], [C]),
      [$u u u$], [0],
      [$s s s$], [0],
      [$d d d$], [0],
      [$u u d$], [0],
      [$u u s$], [0],
      [$d d u$], [0],
      [$d d s$], [0],
      [$s s u$], [0],
      [$s s d$], [0],
      [$u d s$], [0],
      [$u u c$], [1],
      [$d d c$], [1],
      [$s s c$], [1],
      [$u d c$], [1],
      [$u s c$], [1],
      [$s d c$], [1],
      [$u c c$], [2],
      [$s c c$], [2],
      [$d c c$], [2],
      [$c c c$], [3],
    ),
    caption: [baryons: $u,d,s,c$ quarks],
  )

  == 1.15

  #figure(
    table(
      columns: 2,
      table.header([quarks], [C]),
      [$u ol(s)$], [0],
      [$u ol(d)$], [0],
      [$u ol(u)$], [0],
      [$s ol(s)$], [0],
      [$s ol(d)$], [0],
      [$s ol(u)$], [0],
      [$d ol(u)$], [0],
      [$d ol(s)$], [0],
      [$d ol(d)$], [0],
      [$u ol(c)$], [-1],
      [$s ol(c)$], [-1],
      [$d ol(c)$], [-1],
      [$c ol(c)$], [0],
      [$c ol(u)$], [1],
      [$c ol(s)$], [1],
      [$c ol(d)$], [1],
    ),
    caption: [mesons: $u,d,s,c$ quarks],
  )
  == 1.16

  #figure(
    table(
      columns: 4,
      table.header([$q ol(q)$], [meson], [mass], [year]),

      [$u ol(u)$], [$pi^0 (*)$], [134.98], [1950],
      [$u ol(d)$], [$pi^+$], [139.57], [1947],
      [$d ol(d)$], [$pi^0 (*)$], [134.98], [1950],
      [$u ol(s)$], [$K^+$], [493.68], [1949],
      [$d ol(s)$], [$K^0$], [497.65], [1947],
      [$s ol(s)$], [$eta (*)$], [547.51], [1962],
      [$c ol(u)$], [$D^0$], [1864.5], [1976],
      [$c ol(d)$], [$D^+$], [1869.3], [1976],
      [$c ol(s)$], [$D_s^+$], [1968.2], [1977],
      [$c ol(c)$], [$eta_c(1S)$], [2980.4], [1980],
      [$u ol(b)$], [$B^+$], [5279.0], [1983],
      [$d ol(b)$], [$B^0$], [5279.4], [1983],
      [$s ol(b)$], [$B_s^0$], [5367.5], [1993],
      [$c ol(b)$], [$B_c^+$], [6286], [1998],
      [$b ol(b)$], [$Upsilon(1S)$], [9460.3], [1977],
    ),
    caption: [mesons],
  )

  #figure(
    table(
      columns: 4,
      table.header([qqq], [baryon], [mass], [year]),
      [$u u u$], [$Delta^(++)$], [1232], [1951],
      [$u u d$], [$p$], [938.27], [1911],
      [$u d d$], [$n$], [939.57], [1932],
      [$d d d$], [$Delta^-$], [1232], [1951],
      [$u u s$], [$Sigma^+$], [1189.37], [1963],
      [$u d s$], [$Lambda$], [1115.68], [1950],
      [$d d s$], [$Sigma^-$], [1197.45], [1965],
      [$u s s$], [$Xi^0$], [1314.83], [1963],
      [$d s s$], [$Xi^-$], [1321.31], [1963],
      [$s s s$], [$Omega^-$], [1672.45], [1964],
      [$u u c$], [$Sigma_c^(++)$], [2454.02], [1975],
      [$u d c$], [$Lambda_c^+$], [2286.46], [1975],
      [$d d c$], [$Sigma_c^0$], [2453.76], [1975],
      [$u s c$], [$Xi_c^+$], [2467.9], [1983],
      [$d s c$], [$Xi_c^0$], [2471.0], [1989@avery_observation_1989],
      [$s s c$],
      [$Omega_c^0$],
      [2697.5],
      [2001@cronin-hennessy_observation_2001],

      [$u c c$], [$Xi_(c c)^(++)$], [3621.4], [2017@spradlin_discovery_2017],
      [$d c c$], [$Xi_(c c)^+$], [3518.9], [2002],
      [$s c c$], [$Omega_(c c)^+$], [], [],
      [$c c c$], [$Omega_(c c c)^(++)$], [], [],
      [$u u b$], [$Sigma_b^+$], [5807.8], [2007],
      [$u d b$], [$Lambda_b^0$], [5624], [1991@albajar_first_1991],
      [$d d b$], [$Sigma_b^-$], [5815.2], [2007],
      [$u s b$], [$Xi_b^0$], [5792], [1995],
      [$d s b$], [$Xi_b^-$], [5792.9], [2007],
      [$s s b$], [$Omega_b^-$], [6165.0], [2008@collaboration_observation_2008],
      [$u c b$], [$Xi_(c b)^+$], [], [],
      [$d c b$], [$Xi_(c b)^0$], [], [],
      [$s c b$], [$Omega_(c b)^0$], [], [],
      [$c c b$], [$Omega_(c c b)^+$], [], [],
      [$u b b$], [$Xi_bb^0$], [], [],
      [$d b b$], [$Xi_bb^-$], [], [],
      [$s b b$], [$Omega_(b b)^-$], [], [],
      [$c b b$], [$Omega_(c b b)^0$], [], [],
      [$b b b$], [$Omega_(b b b)^-$], [], [],
    ),
    caption: [baryons],
  )

]

#hw
#bibliography("main.bib")
