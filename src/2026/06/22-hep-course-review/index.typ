#import "/page.typ": *
#import "meta.typ": desc, title
#set text(lang: "zh")
#show: conf.with(title: title, desc: desc)

= 简述

粗略地分类, 在一学期的课程中讲授和教材@griffiths_introduction_2011 学习中,
我了解了下面的主题:

+ 基本粒子的分类和历史
+ 相对论运动学
+ 对称性
+ 狄拉克方程
+ 费曼图与黄金规则
+ 规范理论
+ 中微子振荡

= 基本粒子的分类和历史

人们先了解到电子, 质子和中子的存在 (1897 - 1932). 同时普朗克,
爱因斯坦提出了量子的概念, 揭示了光子的存在 (1900 - 1924). 而后,
通过介子认识到了强作用 (1934 - 1947). 狄拉克提出他的方程, 随后确实发现了反粒子
(1930 - 1956). 对 $kb$ 衰变连续谱的深入探究, 直到科温,
莱因斯通过实验证明中微子存在 (1930 - 1962). 随后发现了弱作用, 奇异粒子 (1947 -
1960). 最后, 人们总结了夸克模型, 乃至发展了标准模型 (1978 - 2012).

= 相对论运动学

这一部分的内容大部分已经在基础物理学 (二) 当中接触过. 需要熟练掌握的是:

$
  ts(g, -nu, -mu)&=dmat(1, -1, -1, -1) \
  ts(kL, +mu, -nu)&=mat(
    kg, -kg kb, 0, 0; -kg kb, kg, 0, 0; 0, 0, 1, 0; 0, 0, 0, 1
  )\
  ts(p, +mu)&=(E/c, p_x, p_y, p_z)\
  ts(x, +mu)&=(c t, x, y, z)\
  ts(p, +mu)ts(p, -mu)&=m^2c^2
$

= 对称性

对称性指物理系统在某种变换下规律不变. 如果哈密顿量在变换 $U$ 下满足
$
  U H U^(-1) = H
$
则这个变换对应一个守恒量或选择定则.

== 群论

课程中学到的群论比较少.

#figure(caption: "重要的群的记号", table(
  columns: 2,
  table.hline(),
  table.header([记号], [矩阵]),
  table.hline(),
  [U(n)], [幺正 ($U^(TT *) U=1$)],
  [O(n)], [正交 ($O^TT O=1$)],
  [SU(n)], [幺正并且行列式为 $1$],
  [SO(n)], [正交并且行列式为 $1$],
  table.hline(),
)) <uos>

@uos 提到的矩阵都是 $n times n$ 的, 虽然说实际上任意维度 (最平凡的例子是
$1 times 1$) 的矩阵都可以用来表示群. (换言之, 任何群都有 $1 times 1$ 的平凡表示)

连续群可以用无穷小变换的生成元描述:
$
  U(phi) = e^(i phi S),
  S = -i (dif U(phi)) / (dif phi) |_(phi=0)
$
对 $"SO"(n)$ 和 $"SU"(n)$, 生成元是 Hermitian 且无迹的. 生成元满足闭合关系
$
  [S_j, S_k] = i f_(j k l) S_l
$
其中 $f_(j k l)$ 是结构常数. rank 是可以同时对角化的生成元个数,
也就是标记同一表示中基矢所需的独立量子数个数.

$"SO"(2)$ 是平面转动群, 只有一个生成元:
$
  U(phi)
  =
  mat(cos phi, sin phi; -sin phi, cos phi)
  =
  e^(i phi S_z),
  S_z = mat(0, -i; i, 0)
$
所以 $"SO"(2)$ 的生成元个数为 $1$, rank 为 $1$.

$"SO"(3)$ 是三维转动群, 可以取
$
  S_1 = mat(0, 0, 0; 0, 0, -i; 0, i, 0),
  S_2 = mat(0, 0, i; 0, 0, 0; -i, 0, 0),
  S_3 = mat(0, -i, 0; i, 0, 0; 0, 0, 0)
$
它们满足角动量代数
$
  [S_j, S_k] = i ke_(j k l) S_l
$
所以 $"SO"(3)$ 有 $3$ 个生成元, rank 为 $1$. 在任意表示中,
生成元都可以看作角动量分量 $L_j$ 或 $J_j$, 其 Casimir 算符为 $J^2$.

$"SU"(2)$ 的基本表示由无迹 Hermitian 的 $2 times 2$ 矩阵生成, 通常取
$
  S_j = ks_j / 2,
  [S_j, S_k] = i ke_(j k l) S_l
$
对应群元为
$
  U_j(ka_j)
  =
  e^(i ka_j ks_j / 2)
  =
  I cos(ka_j / 2) + i ks_j sin(ka_j / 2)
$
$"SU"(2)$ 和 $"SO"(3)$ 有相同的 Lie 代数, 但 $"SU"(2)$ 是 $"SO"(3)$ 的双覆盖.
自旋量在 $2 pi$ 转动后变号, 在 $4 pi$ 转动后回到自身. 整数 $J$ 表示也是
$"SO"(3)$ 表示, 半整数 $J$ 表示只属于 $"SU"(2)$.

$"SU"(3)$ 有 $8$ 个生成元, rank 为 $2$. 基本表示中取
$
  S_a = kl_a / 2, a = 1, dots, 8,
  [S_a, S_b] = i f_(a b c) S_c
$
其中 $kl_a$ 是 Gell-Mann 矩阵:
$
  kl_1 = mat(0, 1, 0; 1, 0, 0; 0, 0, 0),
  kl_2 = mat(0, -i, 0; i, 0, 0; 0, 0, 0),
  kl_3 = mat(1, 0, 0; 0, -1, 0; 0, 0, 0)\
  kl_4 = mat(0, 0, 1; 0, 0, 0; 1, 0, 0),
  kl_5 = mat(0, 0, -i; 0, 0, 0; i, 0, 0),
  kl_6 = mat(0, 0, 0; 0, 0, 1; 0, 1, 0)\
  kl_7 = mat(0, 0, 0; 0, 0, -i; 0, i, 0),
  kl_8 = 1 / sqrt(3) mat(1, 0, 0; 0, 1, 0; 0, 0, -2)
$
$kl_1, kl_2, kl_3$ 给出同位旋 $"SU"(2)$ 子群. 另外
$(kl_6, kl_7, sqrt(3) kl_8 - kl_3)$ 和 $(kl_4, kl_5, sqrt(3) kl_8 + kl_3)$
也各给出一个 $"SU"(2)$ 子群. 在味 $"SU"(3)$ 中, 基本三重态可取 $(u, d, s)^T$.
对角生成元 $S_3$ 和 $S_8$ 可以同时对角化, 常用量子数是 $I_3$ 和超荷 $Y$, 其中
$Y$ 是 $2 S_8 / sqrt(3)$ 的本征值:
$
  u: (I_3, Y) = (1 / 2, 1 / 3),
  d: (I_3, Y) = (-1 / 2, 1 / 3),
  s: (I_3, Y) = (0, -2 / 3)
$
升降算符可取
$
  I_+ = S_1 + i S_2,
  I_- = S_1 - i S_2,
  U_+ = S_6 + i S_7,
  U_- = S_6 - i S_7
$
$
  V_+ = S_4 + i S_5,
  V_- = S_4 - i S_5
$
其中 $I_+$, $I_-$ 在同一超荷内改变 $I_3$, 而 $U_+$, $U_-$ 和 $V_+$, $V_-$
同时改变 $I_3$ 与 $Y$:
$
  I_+ (I_3, Y) -> (I_3 + 1, Y),
  I_- (I_3, Y) -> (I_3 - 1, Y)
$
$
  U_+ (I_3, Y) -> (I_3 - 1 / 2, Y + 1),
  U_- (I_3, Y) -> (I_3 + 1 / 2, Y - 1)
$
$
  V_+ (I_3, Y) -> (I_3 + 1 / 2, Y + 1),
  V_- (I_3, Y) -> (I_3 - 1 / 2, Y - 1)
$
三夸克直积有 $3 times 3 times 3 = 10 + 8 + 8 + 1$, 对应重子十重态,
两个八重态和一个单态.

== 角动量

内容已经在量子力学课程上学过.

== Clebsch-Gordan 系数

Clebsch-Gordan 系数 (可以通过 PDG 查阅@navas_review_2024) 本质上是两个 SU(2)
不可约表示张量基中的换基矩阵:

$ braket(j_1 j_2 semi m_1 m_2, j_1 j_2 semi j m) $

为了推导它@sakurai_modern_2020, 考虑利用:

$
  ket(j_1 j_2 semi j m)
  &=sum_(m_1) sum_(m_2) ket(j_1 j_2 semi m_1 m_2) braket(j_1 j_2 semi m_1 m_2, j_1 j_2 semi j m)
$

为了简写, 记
$
  C_(m_1 m_2)^(j m)
  = braket(j_1 j_2 semi m_1 m_2, j_1 j_2 semi j m)
$
于是
$
  ket(j_1 j_2 semi j m)
  = sum_(m_1, m_2) C_(m_1 m_2)^(j m) ket(j_1 m_1) ket(j_2 m_2)
$

总角动量算符满足
$
  J_z = J_(1 z) + J_(2 z)
$
所以对上式两边作用 $J_z$:
$
  m C_(m_1 m_2)^(j m) = (m_1 + m_2) C_(m_1 m_2)^(j m)
$
因此 Clebsch-Gordan 系数有选择规则
$
  C_(m_1 m_2)^(j m) != 0 => m = m_1 + m_2
$
也就是说求和中实际上只需要保留满足 $m_1 + m_2 = m$ 的项.

接下来使用升降算符. 总降算符为
$
  J_- = J_(1 -) + J_(2 -)
$
并且
$
  J_- ket(j m)
  = sqrt((j + m)(j - m + 1)) ket(j m - 1)
$
单个角动量空间中有
$
  J_(1 -) ket(j_1 m_1) & = sqrt((j_1 + m_1)(j_1 - m_1 + 1)) ket(j_1 m_1 - 1) \
  J_(2 -) ket(j_2 m_2) & = sqrt((j_2 + m_2)(j_2 - m_2 + 1)) ket(j_2 m_2 - 1)
$

把 $J_-$ 作用在耦合基展开式两边, 再比较 $ket(j_1 m_1) ket(j_2 m_2)$ 的系数,
得到递推公式:
$
  sqrt((j + m)(j - m + 1)) C_(m_1 m_2)^(j, m - 1)
  &=
  sqrt((j_1 + m_1 + 1)(j_1 - m_1)) C_(m_1 + 1, m_2)^(j m) \
  & +
  sqrt((j_2 + m_2 + 1)(j_2 - m_2)) C_(m_1, m_2 + 1)^(j m)
$
其中每一项仍需满足 $m_1 + m_2 = m - 1$. 给定最高权态和归一化条件后,
这个递推关系就可以逐步算出同一个 $j$ 多重态中的 Clebsch-Gordan 系数.

== 宇称 P

宇称是空间反演:
$
  vb(x) -> -vb(x)
$
若态是宇称本征态, 则
$
  P ket(psi) = eta_P ket(psi), eta_P = plus.minus 1
$
强相互作用和电磁相互作用基本守恒宇称, 弱相互作用破坏宇称.
这说明弱相互作用区分左手和右手.

== 电荷共轭 C

电荷共轭把粒子变成反粒子. 对中性自共轭态可以定义 C 本征值:
$
  C ket(psi) & = eta_C ket(psi) \
       eta_C & = plus.minus 1
$

只有那些自己是自己的反粒子的粒子可以是 C 的本征态.

== CP 破坏

CP 破坏的例子不由让人想起中微子振荡, 或者用更符合历史的顺序来说,
中微子振荡的想法来自 CP 破坏.

不严谨地说, 人们曾经希望 CP 守恒, 但在中性 $K$ 介子上, 发现了问题. 因为 $K^0$
介子可以衰变成 $2pi$ 或 $3pi$. 现在分析这个例子:

$K^0$ 是赝标量, 所以 $P ket(K^0)=- ket(K^0), P ket(mac(K^0))=- ket(mac(K^0))$,
再考虑 C, 约定 $C ket(K^0)=ket(mac(K^0)),C ket(mac(K^0))=ket(K^0)$. 有:
$ C P ket(K^0)=- ket(mac(K^0)),C P ket(mac(K^0))=- ket(K^0) $

从而在 CP 下的本征态是:

$
  ket(K_1) & =1/sqrt(2) (ket(K^0)-ket(mac(K^0))) \
  ket(K_2) & =1/sqrt(2) (ket(K^0)+ket(mac(K^0)))
$

但是, 1964 年 Cronin 和 Fitch 发现, 制备了长寿命 $K$ 介子后, 发现它有出现 $2pi$
的衰变事例 ($45/22700$ 的比例, 在这之前人们觉得 $ket(K_L)$ 就是 $ket(K_2)$).
实际上:

$ ket(K_L)=1/sqrt(1+ke^2)(ket(K_1)+ke ket(K_2)) $

这说明:
$ [C P, H]!=0 $

另一个 CP 破坏的证据是长寿命 $K$ 介子衰变的两种模式:

$
  K_L & -> pi^+ + e^- + mac(nu_e) \
  K_L & -> pi^- + e^- + nu_e
$

倘若 CP 守恒, 这两种模式出现的概率应当一样多, 但是人们发现后者比前者多出
$num("3.3e-3")$. 这意味着正反粒子并不是纯粹的约定. 如果要跟外星人交流,
用语言没有歧义地说明人类的心脏在左边@griffiths_introduction_2011, 那么可以说,
定义正电荷是长寿命 $K$ 介子衰变更容易产生的那个 (这也同时规定了电子中微子).
那么规定电子中微子的螺旋性是左手的. 到这里, 交流就建立了,
接下来只需要提供一张图示, 说明我们是怎么使用右手定则确定右手系的,
就可以同步坐标系的选取.

== CPT 守恒

CP 是电荷共轭和空间反演的组合. 弱相互作用分别破坏 C 和 P, 后来实验又说明 CP
也会被破坏. 标准模型中, CP 破坏来自 CKM 矩阵中的复相位.

T 是时间反演, 在量子力学中是反幺正变换. 如果 CP 被破坏, 同时 CPT 仍守恒, 那么 T
也必须相应被破坏.

本章最后的结论是: C, P, T 可以分别被破坏, CP 也可以被破坏, 但是 CPT
联合变换应当守恒:
$
  (C P T) H (C P T)^(-1) = H
$

= 狄拉克方程

== 从相对论能量关系出发

相对论能量动量关系是
$
  ts(p, +mu) ts(p, -mu) = m^2
$

Klein-Gordon 方程直接把它量子化, 会得到二阶时间导数. Dirac
的想法是寻找一个一阶方程:
$
  i partial_t psi = H_D psi\
  H_D = ka^i p_i + kb m
$
要求平方以后回到相对论能量关系:
$
  H_D^2 = p^2 + m^2
$
这要求矩阵 $ka^i$ 和 $kb$ 满足
$
  ka^i ka^j + ka^j ka^i & = 2 kd^(i j) \
      ka^i kb + kb ka^i & = 0 \
                   kb^2 & = 1
$
所以 $ka^i$ 和 $kb$ 不可能只是普通数, 波函数 $psi$ 也不再是单个复函数,
而是多分量旋量.

== $kg$ 矩阵和协变形式

定义
$
  kb = kg^0, ka^i = kg^0 kg^i
$
则 Dirac 方程可写为协变形式
$
  (i kg^mu partial_mu - m) psi = 0
$
其中 $kg$ 矩阵满足 Clifford 代数
$
  kg^mu kg^nu + kg^nu kg^mu = 2 ts(g, +mu, +nu)
$
Dirac 表示中可以取
$
  kg^0 = mat(I, 0; 0, -I)\
  kg^i = mat(0, ks_i; -ks_i, 0)
$
其中 $ks_i$ 是 Pauli 矩阵. 由于 $kg$ 矩阵必须至少是 $4 times 4$ 矩阵, 自由 Dirac
粒子的波函数是四分量旋量. 粗略地说, 两个分量对应自旋自由度,
另外两个分量对应粒子和反粒子自由度.

协变性的意思是 Lorentz 变换下旋量按某个矩阵 $S(kL)$ 变换:
$
  psi'(x') = S(kL) psi(x)
$
而 $kg$ 矩阵满足
$
  S(kL)^(-1) kg^mu S(kL) = ts(kL, +mu, -nu) kg^nu
$
这样 Dirac 方程在所有惯性系中有相同形式.

== 平面波解和反粒子

取平面波
$psi(x)=u(p)e^(-i p_mu x^mu)$
代入 Dirac 方程得到
$
  (kg^mu p_mu - m) u(p) = 0
$
对应正能量粒子解. 另有
$psi(x)=v(p)e^(i p_mu x^mu)$
给出
$
  (kg^mu p_mu + m) v(p) = 0
$
对应反粒子解. 因此 Dirac 方程自然给出正负能量解. 在单粒子图像中这很麻烦,
但在量子场论中负能量解被重新解释为反粒子的产生和湮灭. 这就是 Dirac
方程预言正电子的关键.

自由 Dirac 场可按粒子和反粒子模式展开:
$
  psi(x)
  =
  int (dif^3 p)/(sqrt(2 E_p))
  (a_s(p) u^s(p) e^(-i p x) + b_s^dagger(p) v^s(p) e^(i p x))
$
其中重复的自旋标签 $s$ 默认求和, $a_s$ 湮灭粒子, $b_s^dagger$ 产生反粒子.

== Dirac 共轭和守恒流

普通的 Schrodinger 型内积密度不是 Lorentz 标量. 因此定义 Dirac 共轭
$
  mac(psi) = psi^dagger kg^0
$
用它可以写出 Lorentz 标量 $mac(psi) psi$ 和四维流 $j^mu = mac(psi) kg^mu psi$.

== 手征性和质量项

定义
$
  kg^5 = i kg^0 kg^1 kg^2 kg^3
$
它满足
$
  (kg^5)^2 = 1\
  kg^5 kg^mu + kg^mu kg^5 = 0
$
于是可以定义左右手投影算符
$
  P_L & = (1 - kg^5)/2 \
  P_R & = (1 + kg^5)/2
$
并把 Dirac 旋量分解为
$
  psi_L & = P_L psi \
  psi_R & = P_R psi \
    psi & = psi_L + psi_R
$

= 费曼图与黄金规则

Feynman 图是把相互作用 Lagrange 量转成振幅 $M$ 的记账方法.
外线是真实入射和出射粒子, 满足质壳条件 $ts(p, +mu)ts(p, -mu)=m^2$.
内线是虚粒子传播子, 不必在质壳上. 顶点表示基本相互作用,
并要求能量动量和相应量子数守恒.

最重要的规则是: 同一个初末态的所有允许图要先加振幅, 再取模平方:
$
  M = M_1 + M_2 + dots, "probability" prop abs(M)^2
$
因此 Feynman 图之间可以干涉, 不是经典概率相加.

== 常见顶点

QED 的基本顶点来自
$
  cal(L)_"int" = - e mac(psi) kg^mu psi A_mu
$
对应一个 Fermion, 一个反 Fermion 和一个光子. 它只耦合电荷, 不改变味道.
耦合强度通常写成
$
  ka = e^2 / (4 pi) approx 1 / 137
$

QCD 的基本顶点是 $q mac(q) g$. 它耦合色荷, 可以改变夸克颜色, 但不改变夸克味道.
由于胶子本身带色荷, QCD 还有三胶子和四胶子顶点. 这与 QED 不同,
也导致渐近自由和禁闭.

弱作用分中性流和带电流. $Z$ 介导中性流, 通常不改变电荷. $W^plus.minus$
介导带电流, 可以把带电轻子和中微子互相连接, 也可以把上型夸克和下型夸克互相连接.
夸克带电流中会出现 CKM 混合.

== 宽度, 截面和黄金规则

Feynman 图给出的是振幅 $M$, 实验测到的是宽度 $kG$ 或截面 $ks$.
衰变寿命和总宽度满足
$
  kG = 1 / tau
$
若有多个衰变道,
$
  "BR"_i = kG_i / kG_"tot"
$
其中 $kG_i$ 是第 $i$ 个部分宽度, $kG_"tot"$ 是总宽度.

黄金规则的核心形式是
$
  dif kG = abs(M)^2 dif Phi
$
其中 $dif Phi$ 是末态相空间. 因此一个过程是否显著, 同时取决于顶点给出的
$abs(M)^2$ 和运动学给出的相空间.

两体衰变在母粒子静止系中可记为
$
  kG = (S abs(vb(p))) / (8 pi m_1^2) abs(M)^2
$
其中 $S$ 是全同粒子因子, $abs(vb(p))$ 是末态粒子动量大小.
两体散射的微分截面有结构
$
  dv(ks, kO) prop abs(M)^2
  (abs(vb(p)_f))/(abs(vb(p)_i))
$
其中初末态动量因子来自相空间.

对撞机中常用亮度 $cal(L)$ 表示束流强度, 事件率为
$
  R = ks cal(L)
$

== OZI 规则

OZI 规则是强子衰变中的经验规则: 如果初态夸克线能连续连到末态夸克线,
过程较容易发生; 如果初态必须先完全湮灭成胶子, 再产生新的轻夸克, 过程会被压低.
$J\/psi$ 是 $c mac(c)$, 它低于开粲阈值, 不能衰变成 $D mac(D)$,
而衰变成轻强子又要先湮灭成多个胶子, 所以宽度异常窄.

= 规范理论

规范理论的核心思想是: 把某个内部对称性从整体变换推广到局域变换后, 为了保持
Lagrange 量不变, 必须引入规范场和协变导数. 相互作用不是额外附加的,
而是局域规范不变性要求出来的.

== 局域 $"U"(1)$ 和 QED

自由 Dirac 场有整体相位对称性
$
  psi -> e^(i ka) psi
$
若令相位依赖时空,
$
  psi -> e^(i kt(x)) psi
$
普通导数会多出 $partial_mu kt(x)$ 项. 为了恢复不变性, 引入协变导数
$
  cal(D)_mu = partial_mu + i e A_mu
$
并令
$
  A_mu -> A_mu - (1 / e) partial_mu kt
$
于是
$
  cal(L) = mac(psi)(i kg^mu cal(D)_mu - m)psi
  - 1 / 4 F_(mu nu) F^(mu nu)
$
其中
$
  F_(mu nu) = partial_mu A_nu - partial_nu A_mu
$
展开协变导数就得到电磁相互作用项
$
  cal(L)_"int" = - e mac(psi) kg^mu psi A_mu
$
规范场质量项 $m_A^2 A_mu A^mu / 2$ 不满足上述规范变换, 所以光子不能直接带质量.

== Yang-Mills 理论

若规范群不是 Abel 群, 生成元满足
$
  [T^a, T^b] = i f^(a b c) T^c
$
协变导数写成
$
  cal(D)_mu = partial_mu + i g A_mu^a T^a
$
场强为
$
  F_(mu nu)^a =
  partial_mu A_nu^a - partial_nu A_mu^a
  - g f^(a b c) A_mu^b A_nu^c
$
最后一项来自非 Abel 性, 表示规范场本身也带荷并发生自相互作用.

这就是 Yang-Mills 理论的基本结构. 物质场属于某个规范群的表示, 规范场 $A_mu^a$
对应群的生成元 $T^a$, 相互作用由普通导数替换为协变导数产生. 规范场自身的动力学由
$
  cal(L)_"YM" = -1 / 4 F_(mu nu)^a F^(a mu nu)
$
给出. 当 $f^(a b c)=0$ 时, 它退化为 Abel 的 QED 型理论; 当 $f^(a b c) != 0$ 时,
场强中含有 $A A$ 项, 所以 Lagrange 量中会出现三规范 Boson 和四规范 Boson
相互作用.

一般地说, 规范群有几个生成元, 就需要几个规范场:

+ $"U"(1)$ 有 1 个生成元, 对应光子.
+ $"SU"(2)$ 有 3 个生成元, 对应 3 个弱同位旋规范场.
+ $"SU"(3)$ 有 8 个生成元, 对应 8 个胶子.

== QCD

QCD 的规范群是 $"SU"(3)_C$. 夸克是颜色三重态, 局域颜色规范不变性要求有 8
个胶子场 $A_mu^a$. 相互作用项可写成
$
  cal(L)_"int" = - g_s mac(q) kg^mu T^a q A_mu^a
$
因为胶子带色荷, QCD 有胶子自相互作用, 高能下渐近自由, 低能下禁闭.

== 电弱统一和 Higgs 机制

电弱理论的规范群是
$
  "SU"(2)_L times "U"(1)_Y
$
左手 Fermion 组成 $"SU"(2)_L$ 二重态, 右手 Fermion 是单态. 电荷满足
$
  Q = I_3 + Y / 2
$
对应的规范场是
$
  A_mu^1, A_mu^2, A_mu^3, B_mu
$
物理场为
$
  W_mu^plus.minus = (A_mu^1 minus.plus i A_mu^2) / sqrt(2)
$
以及
$
  A_mu & = sin kt_W A_mu^3 + cos kt_W B_mu \
  Z_mu & = cos kt_W A_mu^3 - sin kt_W B_mu
$
其中 $A_mu$ 是光子, $Z_mu$ 是中性弱 Boson.

弱带电流只耦合左手手征态, 顶点结构含有
$
  kg^mu (1 - kg^5)
$
这就是最大宇称破坏的数学表现.

规范场不能直接加质量项, 否则破坏局域规范不变性. Higgs
机制通过自发对称性破缺解决这个问题: Goldstone 自由度被规范场吸收, 成为 massive
vector boson 的纵向极化. 结果是 $W^plus.minus$ 和 $Z$ 获得质量,
光子仍保持无质量. Fermion 质量则来自 Yukawa 耦合和 Higgs 真空期望值.

具体做法是给 Lagrange 量加入一个标量二重态 $Phi$:
$
  Phi = mat(phi^+; phi^0), Y(Phi)=1
$
并加入规范不变的 Higgs 部分
$
  cal(L)_H = (cal(D)_mu Phi)^dagger (cal(D)^mu Phi) - V(Phi)
$
其中
$
  V(Phi) = - mu^2 Phi^dagger Phi + kl (Phi^dagger Phi)^2
$
当 $mu^2 > 0$ 时, 势能最低点不在 $Phi=0$, 而满足
$
  Phi^dagger Phi = v^2 / 2, v = mu / sqrt(kl)
$
选单位规范后可写
$
  Phi(x) = 1 / sqrt(2) mat(0; v + h(x))
$
其中 $h(x)$ 是物理 Higgs 粒子.

把这个真空期望值代入动能项 $(cal(D)_mu Phi)^dagger (cal(D)^mu Phi)$,
会自动产生规范场的二次项:
$
  (cal(D)_mu Phi)^dagger (cal(D)^mu Phi)
  = dots +
  (g^2 v^2) / 4 W_mu^+ W^(-mu)
  + (v^2) / 8 (g A_mu^3 - g' B_mu)^2
$
这就是质量项, 但它来自规范不变的 Higgs 动能项, 所以没有显式破坏规范不变性.
换成物理场后得到
$
  m_W = g v / 2,
  m_Z = v / 2 sqrt(g^2 + g'^2),
  m_A = 0
$
因此光子保持无质量, 而 $W^plus.minus$ 和 $Z$ 获得质量.

= 中微子振荡

太阳模型的中微子消失问题 (主要来自 $istp("B", a: 8)$, 因为 $istp("B", a: 8)$
的能量较高, 且通量比 hep 高), 让物理学家开始做大型的中微子实验.
结论是太阳模型预测的中微子通量并没有错, 只是因为中微子到达地球的途中发生了振荡,
即, 中微子的质量本征态和味本征态不是同一个态.

$ istp("B", a: 8) -> istp("Be", a: 8) + e^+ + nu_e $

如果不振荡, 那么地球上看到的全是电子中微子. 测到的就是理论的, 但振荡后,
只测量电子中微子的实验就看不全了.

因此 SNO 使用了重水, 探测下面三种反应:

/ CC: $nu_e +d^+ -> p^++p^++e^-$, $phi_"CC" =phi_e$
/ NC: $nu_x +d^+ -> p^++n+nu_x$, $phi_"NC" =phi_e + phi_(mu tau)$
/ ES: $nu_x +e^- ->nu_x +e^-$, $phi_"ES" =phi_e+ 0.1553 phi_(mu tau)$

#figure(image("sno.jpg"), caption: [Flux of $mu+tau$ neutrinos versus flux of
  electron neutrinos. CC, NC, and ES flux measurements are indicated by the
  filled bands. The total $istp("B", a: 8)$ solar neutrino flux predicted by the
  standard solar model is shown as dashed lines and that measured with the NC
  channel is shown as the solid band parallel to the model prediction. Taken
  from @aharmim_electron_2005.
]) <sno>

参考@sno, 太阳中微子问题得到了很好的说明.

同时, CKM 矩阵描述夸克在带电弱流中的味混合. 中微子的对应物是 PMNS 矩阵.
二者物理角色类似: 弱相互作用按味本征态产生和探测粒子,
但自由传播按质量本征态演化.

对中微子, 味本征态和质量本征态的关系写成
$
  mat(nu_e; nu_mu; nu_tau)
  =
  U_(ka i) mat(nu_1; nu_2; nu_3)
$
其中 $ka = e, mu, tau$, 而 $i = 1, 2, 3$. 常用参数化把 PMNS 矩阵写成三个混合角
和若干相位的乘积:
$
  U_"PMNS"
  =
  R_23 U_13 R_12 P_"Maj"
$
其中
$
  R_23 =
  mat(
    1, 0, 0;
    0, c_23, s_23;
    0, -s_23, c_23
  ),
  U_13 =
  mat(
    c_13, 0, s_13 e^(-i kd);
    0, 1, 0;
    -s_13 e^(i kd), 0, c_13
  ),
  R_12 =
  mat(
    c_12, s_12, 0;
    -s_12, c_12, 0;
    0, 0, 1
  )
$
这里 $c_(i j)=cos kt_(i j)$, $s_(i j)=sin kt_(i j)$. $kt_12, kt_23, kt_13$
是三个混合角, $kd$ 是 Dirac CP 相位. 若中微子是 Majorana 粒子, 还可以有
$
  P_"Maj" = dmat(1, e^(i ka_21 / 2), e^(i ka_31 / 2))
$
其中 $ka_21, ka_31$ 是 Majorana 相位. 它们不影响普通振荡概率, 但会影响无中微子双
$kb$ 衰变等过程.

普通双 $kb$ 衰变为 $(A, Z) -> (A, Z + 2) + 2 e^- + 2 mac(nu)_e$ (轻子数守恒).
无中微子双 $kb$ 衰变为$(A, Z) -> (A, Z + 2) + 2 e^-$. 末态没有反中微子.
若观测到, 则说明轻子数不守恒, 中微子是 Majorana 粒子.

#bibliography("main.bib")
