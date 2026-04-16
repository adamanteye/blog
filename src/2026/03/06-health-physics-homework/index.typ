#import "/page.typ": *
#import "meta.typ": desc, title
#show: conf.with(title: title, desc: desc)

#let hw = [
  = 第一次作业
  == 简要分析 X 射线试鞋机的利益与风险

  / 利益:
  X 射线试鞋机能够直接看到脚在鞋内的位置和骨骼与鞋子的贴合情况,
  帮助顾客判断鞋子是否合脚, 减少因鞋码不合适带来的不适. 从商业角度看, 它新奇,
  能够吸引顾客, 提高销售体验.

  / 风险:
  它的主要问题是医疗获益极低, 但辐射暴露却真实存在. 试鞋并不是疾病诊断或治疗,
  得到的信息完全可以通过普通试穿, 测量和经验来替代, 因此其收益有限. 因此,
  这种应用违背了辐射防护中的正当化原则:
  即一种照射只有在带来的收益明显大于风险时才是合理的. X
  射线试鞋机娱乐性强于实用性, 属于不必要照射, 最终被淘汰是合理的.

  == $gamma$ 射线检查焊缝是否正当? 为什么?

  正当的.

  原因在于, 工业 $gamma$ 射线探伤能够发现金属焊接内部肉眼看不到的孔隙,
  裂纹和未焊透等缺陷, 这对于压力容器, 核设施等设备的安全非常重要.
  它能够预防重大事故, 避免设备失效造成的人员伤亡和经济损失,
  因此具有明确而现实的社会收益. 它所提供的信息是其他方法难以得到的.

  == 发展核能的风险和利益

  核能的主要利益在于发电稳定, 能量密度高, 运行过程中温室气体排放低,
  有助于保障能源安全和减少化石燃料污染. 核能还能推动核医学, 材料,
  工业等相关技术发展.

  其风险主要包括核事故可能造成环境污染和公众恐慌, 放射性废物需要长期安全处置,
  核设施建设成本高且管理要求严格. 总体看, 核能既有显著社会价值,
  也要求极高水平的安全文化, 监管体系和辐射防护措施.

  == 文献阅读笔记

  印象最深的是: 辐射防护标准并不是一开始就很完善, 而是在科学认识,
  社会关切和技术应用变化中不断演进的.

  文章按时间梳理了辐射防护理念的变化. 20 世纪早期, 人们最先关注的是 X
  射线引起的皮肤红斑等明显损伤, 因此早期限值主要围绕避免确定性损伤建立. 随后,
  随着镭的广泛使用, 表盘工人镭中毒事件以及内照射问题的出现,
  辐射防护开始关注体内沉积和职业照射控制. 到 20 世纪 50 年代,
  核武器试验落下灰引发公众强烈担忧, 防护重点逐渐转向遗传效应. 再到 1970
  年代以后, 随着广岛, 长崎原爆幸存者流行病学资料不断积累,
  防护体系进一步转向以致癌危险为基础, 形成了以危险度估计, 有效剂量,
  内外照射合并评价和 ALARA 为代表的现代辐射防护框架.

  辐射防护标准既是科学问题, 也是社会问题.
  标准的变化不仅来自新的生物学和流行病学证据, 也受到公众风险认知,
  核技术发展和防护成本的影响. 作者最后提到, ICRP 和 NCRP 一方面被批评低估危险,
  另一方面又被批评高估危险, 这说明辐射防护本质上是在不确定性中寻求合理平衡.

  = 第二次作业

  == $isotope("Na", a: 24)$ 和 $isotope("P", a: 32)$ 混合物何时活度相同

  设 1 对应 $isotope("Na", a: 24)$, 2 对应 $isotope("P", a: 32)$.
  两者活度随时间变化为
  $
    A_1(t) = A_(1,0) e^(-lambda_1 t), quad
    A_2(t) = A_(2,0) e^(-lambda_2 t)
  $

  题目给出初始活度占比为 98% 和 2%, 因而
  $
    A_(1,0) / A_(2,0) = 98 / 2 = 49
  $

  当两者活度相等时,
  $
    A_(1,0) e^(-lambda_1 t) = A_(2,0) e^(-lambda_2 t)
  $
  所以
  $
    49 = e^((lambda_1 - lambda_2) t), quad
    t = (ln 49) / (lambda_1 - lambda_2)
  $

  取半衰期
  $
    T_(1/2,1) = qty("14.96", "h"), quad
    T_(1/2,2) = qty("14.3", "d") = qty("343.2", "h")
  $
  则
  $
    lambda_1 = (ln 2) / T_(1/2,1), quad
    lambda_2 = (ln 2) / T_(1/2,2)
  $

  代入可得
  $
    t = (ln 49) / (ln 2 (1 / 14.96 - 1 / 343.2)) approx qty("88.0", "h")
  $
  即
  $
    t approx qty("3.67", "d")
  $

  因此, 约经过 3.7 d 后, $isotope("Na", a: 24)$ 和 $isotope("P", a: 32)$
  的活度相同.

  == 推导氡的平衡当量浓度公式

  记
  $
    C_1 = C(isotope("Po", a: 218)), quad
    C_2 = C(isotope("Pb", a: 214)), quad
    C_3 = C(isotope("Bi", a: 214))
  $

  设氡短寿命子体的 alpha 潜能浓度为 $S$. 对于 $isotope("Po", a: 218)$,
  其后续衰变还会经过 $isotope("Po", a: 214)$ 再放出一个 alpha 粒子, 因而每个
  $isotope("Po", a: 218)$ 原子对应的总 alpha 能量为
  $
    epsilon_1 = 6.00 + 7.69 = 13.69 " MeV"
  $
  而 $isotope("Pb", a: 214)$ 和 $isotope("Bi", a: 214)$ 最终都只对应
  $isotope("Po", a: 214)$ 的一次 alpha 衰变, 因而
  $
    epsilon_2 = 7.69 " MeV", quad
    epsilon_3 = 7.69 " MeV"
  $

  若三种子体的原子数浓度分别为 $N_1, N_2, N_3$, 则 alpha 潜能浓度为
  $
    S = epsilon_1 N_1 + epsilon_2 N_2 + epsilon_3 N_3
  $

  又因为活度浓度满足
  $
    C_i = lambda_i N_i, quad N_i = C_i / lambda_i
  $
  所以
  $
    S = epsilon_1 C_1 / lambda_1 + epsilon_2 C_2 / lambda_2 + epsilon_3 C_3 / lambda_3
  $

  设与之等效的平衡氡浓度为 $C_"eq"$. 在平衡状态下,
  三种短寿命子体的活度浓度都等于 $C_"eq"$, 因而
  $
    S = C_"eq" (epsilon_1 / lambda_1 + epsilon_2 / lambda_2 + epsilon_3 / lambda_3)
  $

  于是
  $
    C_"eq" = (epsilon_1 C_1 / lambda_1 + epsilon_2 C_2 / lambda_2 + epsilon_3 C_3 / lambda_3)
    / (epsilon_1 / lambda_1 + epsilon_2 / lambda_2 + epsilon_3 / lambda_3)
  $

  利用
  $
    lambda_i = (ln 2) / T_i
  $
  可知各项权重正比于 $epsilon_i T_i$. 取半衰期
  $
    T_1 = qty("3.05", "min"), quad
    T_2 = qty("26.8", "min"), quad
    T_3 = qty("19.9", "min")
  $
  则
  $
    C_"eq" = (13.69 times 3.05 C_1 + 7.69 times 26.8 C_2 + 7.69 times 19.9 C_3)
    / (13.69 times 3.05 + 7.69 times 26.8 + 7.69 times 19.9)
  $

  计算得
  $
    C_"eq" approx 0.104 C_1 + 0.514 C_2 + 0.382 C_3
  $

  即
  $
    C_"eq" = 0.104 C(isotope("Po", a: 218)) + 0.514 C(isotope("Pb", a: 214))
    + 0.382 C(isotope("Bi", a: 214))
  $

  == 100 g 硝酸钾样品中的放射性强度

  $"KNO"_3$ 的摩尔质量约为
  $
    M("KNO"_3) = 39.1 + 14.0 + 3 times 16.0 approx qty("101.1", "g/mol")
  $

  因而 100 g $"KNO"_3$ 的物质的量为
  $
    n = 100 / 101.1 approx qty("0.989", "mol")
  $

  每个 $"KNO"_3$ 分子含 1 个 K 原子, 所以钾原子总数为
  $
    N_K = n N_A approx 0.989 times 6.02 times 10^23 approx 5.95 times 10^23
  $

  其中 $isotope("K", a: 40)$ 的天然丰度为 0.0118%, 即
  $
    N_(isotope("K", a: 40)) = 1.18 times 10^(-4) N_K approx 7.02 times 10^19
  $

  $isotope("K", a: 40)$ 的半衰期取
  $
    T_(1/2) = 1.248 times 10^9 " a"
  $
  所以衰变常数为
  $
    lambda = (ln 2) / T_(1/2)
  $

  放射性强度为
  $
    A = lambda N_(isotope("K", a: 40))
  $

  将半衰期换算成秒后代入, 得
  $
    A approx 1.24 times 10^3 " Bq"
  $

  因此, 100 g 硝酸钾样品的放射性强度约为
  $
    A approx 1.24 " kBq"
  $

  == 与 1 g $isotope("Ra", a: 226)$ 处于平衡的 $isotope("Rn", a: 222)$ 体积

  1 g $isotope("Ra", a: 226)$ 的活度近似定义为
  $
    A_(isotope("Ra", a: 226)) = 1 " Ci" = 3.7 times 10^10 " Bq"
  $

  达到放射性平衡时,
  $
    A_(isotope("Rn", a: 222)) = A_(isotope("Ra", a: 226)) = 3.7 times 10^10 " Bq"
  $

  $isotope("Rn", a: 222)$ 的半衰期取
  $
    T_(1/2) = qty("3.82", "d")
  $
  故其原子数为
  $
    N_(isotope("Rn", a: 222)) = A_(isotope("Rn", a: 222)) T_(1/2) / (ln 2)
  $
  即
  $
    N_(isotope("Rn", a: 222)) approx 3.7 times 10^10 times (3.82 times 24 times 3600) / (ln 2)
    approx 1.76 times 10^16
  $

  于是物质的量为
  $
    n_(isotope("Rn", a: 222)) = N_(isotope("Rn", a: 222)) / N_A approx 2.93 times 10^(-8) " mol"
  $
  在 0 C, 760 mmHg 下, 1 mol 理想气体体积约为 22.4 L, 所以
  $
    V = n_(isotope("Rn", a: 222)) times 22.4 approx 6.56 times 10^(-7) " L"
  $

  因此, 与 1 g $isotope("Ra", a: 226)$ 处于平衡的 $isotope("Rn", a: 222)$
  体积约为
  $
    V approx 6.6 times 10^(-7) " L"
  $
  也就是约
  $
    V approx 0.656 " muL"
  $

  == $isotope("Mo", a: 99)$-$isotope("Tc", a: 99m)$ 发生器再次淋洗的时间

  设 1 对应 $isotope("Mo", a: 99)$, 2 对应 $isotope("Tc", a: 99m)$.
  一次淋洗后可认为
  $
    A_2(0) = 0
  $
  母体核素活度随时间变化为
  $
    A_1(t) = A_(1,0) e^(-lambda_1 t)
  $

  由 Bateman 公式, 子体核素活度为
  $
    A_2(t) = A_(1,0) lambda_2 / (lambda_2 - lambda_1) (e^(-lambda_1 t) - e^(-lambda_2 t))
  $

  因而二者活度比为
  $
    A_2(t) / A_1(t) = lambda_2 / (lambda_2 - lambda_1) (1 - e^(-(lambda_2 - lambda_1) t))
  $

  题目要求
  $
    A_2(t) / A_1(t) = 0.98
  $
  所以
  $
    0.98 = lambda_2 / (lambda_2 - lambda_1) (1 - e^(-(lambda_2 - lambda_1) t))
  $

  取半衰期
  $
    T_(1/2,1) = qty("66.02", "h"), quad
    T_(1/2,2) = qty("6.02", "h")
  $
  即
  $
    lambda_1 = (ln 2) / 66.02, quad
    lambda_2 = (ln 2) / 6.02
  $

  解得
  $
    t = -1 / (lambda_2 - lambda_1) ln(1 - 0.98 (lambda_2 - lambda_1) / lambda_2)
    approx qty("21.1", "h")
  $

  因此, 一次淋洗后约等待 21 h 再次淋洗, 可使淋洗得到的 $isotope("Tc", a: 99m)$
  活度达到当时 $isotope("Mo", a: 99)$ 活度的 98%.


  = 第三次作业

  == 某纯 $beta$ 放射性核素的半衰期, 衰变常数和核素判断

  设计数率满足指数衰减规律
  $
    R(t) = R_0 e^(-lambda t)
  $

  对表中数据作 $ln R$ 对 $t$ 的线性拟合, 得
  $
    ln R = ln R_0 - lambda t
  $
  其中
  $
    lambda approx qty("0.0493", "d^-1")
  $

  于是半衰期为
  $
    T_(1/2) = (ln 2) / lambda
    approx (ln 2) / 0.0493
    approx qty("14.1", "d")
  $

  若换算成 SI 单位, 则
  $
    lambda approx 0.0493 / (24 times 3600)
    approx qty("5.70e-7", "s^-1")
  $

  查常见纯 $beta$ 放射性核素, 半衰期最接近的是 $isotope("P", a: 32)$:
  $
    T_(1/2)(isotope("P", a: 32)) approx qty("14.3", "d")
  $

  因此该核素可判断为 $isotope("P", a: 32)$.

  == 5 mg $isotope("Pb", a: 210)$ 样品 10 年后的活度

  已知
  $
    m = qty("5", "mg") = qty("5e-3", "g"), quad
    M = qty("210", "g/mol")
  $

  样品中原子数为
  $
    N_0 = m N_A / M
    approx 5 times 10^(-3) times 6.02 times 10^23 / 210
    approx 1.43 times 10^19
  $

  $isotope("Pb", a: 210)$ 半衰期取
  $
    T_(1/2) = qty("22.3", "a")
  $
  故衰变常数为
  $
    lambda = (ln 2) / T_(1/2)
  $

  初始活度
  $
    A_0 = lambda N_0
    approx qty("1.41e10", "Bq")
  $

  10 年后活度
  $
    A(10 " a") = A_0 e^(-lambda times 10 " a")
    = A_0 2^(-10 / 22.3)
    approx qty("1.03e10", "Bq")
  $

  因此, 10 年后样品活度约为
  $
    A approx qty("10.3", "GBq")
  $

  == 1 吨 $U_3 O_8$ 含量为 10% 的铀矿中 $isotope("U", a: 234)$ 的比活度

  1 吨矿石中含
  $
    m(U_3 O_8) = 0.10 times 1000 = qty("100", "kg")
  $

  $U_3 O_8$ 中铀的质量分数约为
  $
    w_U = (3 times 238) / (3 times 238 + 8 times 16) approx 0.848
  $
  所以矿石中铀总质量约为
  $
    m_U approx 0.848 times 100 = qty("84.8", "kg")
  $

  天然铀中 $isotope("U", a: 234)$ 的质量分数约为
  $
    w_(234) approx 5.3 times 10^(-5)
  $
  故
  $
    m_(234) = w_(234) m_U
    approx 5.3 times 10^(-5) times 84.8 times 10^3
    approx qty("4.50", "g")
  $

  $isotope("U", a: 234)$ 的半衰期取
  $
    T_(1/2) = 2.455 times 10^5 " a"
  $
  其纯核素比活度为
  $
    a_(234)^* = (ln 2) N_A / (M T_(1/2))
    approx qty("2.30e8", "Bq/g")
  $

  于是这 1 吨矿石中 $isotope("U", a: 234)$ 的总活度约为
  $
    A_(234) = a_(234)^* m_(234)
    approx 2.30 times 10^8 times 4.50
    approx qty("1.04e9", "Bq")
  $

  若按矿石质量定义其比活度, 则
  $
    a = A_(234) / qty("1000", "kg")
    approx qty("1.04e6", "Bq/kg")
  $

  因此, 该铀矿中 $isotope("U", a: 234)$ 的比活度约为
  $
    a approx qty("1.04", "MBq/kg")
  $

  == 0.5 MeV $gamma$ 辐射场中的粒子注量率

  已知能量注量率
  $
    dot(Psi) = qty("5", "J/m^2/s")
  $
  单个 $gamma$ 光子的能量为
  $
    E_gamma = qty("0.5", "MeV")
    = 0.5 times 1.602 times 10^(-13) " J"
    approx qty("8.01e-14", "J")
  $

  粒子注量率为
  $
    dot(Phi) = dot(Psi) / E_gamma
    approx 5 / (8.01 times 10^(-14))
    approx qty("6.24e13", "m^-2 s^-1")
  $

  因此该处的粒子注量率约为
  $
    dot(Phi) approx qty("6.24e13", "m^-2 s^-1")
  $

  == $isotope("Cs", a: 137)$ 点源在 0.5 m 处的粒子注量率和能量注量率

  已知点源活度
  $
    A = qty("1", "Ci") = qty("3.7e10", "s^-1")
  $
  取 $isotope("Cs", a: 137)$ 每次衰变平均发出
  $
    Y_gamma approx 0.851
  $
  个能量为
  $
    E_gamma = qty("661.7", "keV")
  $
  的 $gamma$ 光子. 对各向同性点源, 在距离 $r = qty("0.5", "m")$ 处, 粒子注量率为
  $
    dot(Phi) = A Y_gamma / (4 pi r^2)
  $

  代入得
  $
    dot(Phi)
    = 3.7 times 10^10 times 0.851 / (4 pi times 0.5^2)
    approx qty("1.00e10", "m^-2 s^-1")
  $

  能量注量率为
  $
    dot(Psi) = E_gamma dot(Phi)
  $
  其中
  $
    E_gamma = 661.7 times 10^3 times 1.602 times 10^(-19) " J"
    approx qty("1.06e-13", "J")
  $
  因此
  $
    dot(Psi)
    approx 1.06 times 10^(-13) times 1.00 times 10^10
    approx qty("1.06e-3", "J/m^2/s")
  $

  所以距离源 0.5 m 处,
  $
    dot(Phi) approx qty("1.00e10", "m^-2 s^-1"), quad
    dot(Psi) approx qty("1.06e-3", "J/m^2/s")
  $

  == 辐射损失率之比与电子在铅中的辐射损失比

  对于同一介质中的带电粒子, 轫致辐射损失率近似满足
  $
    S_"rad" ∝ z^2 E / m^2
  $

  对于 10 MeV 氘核和 10 MeV 电子, 二者电荷数都为 1, 且动能相同, 因而
  $
    (S_"rad")_d / (S_"rad")_e = (m_e / m_d)^2
  $

  取
  $
    m_e c^2 = qty("0.511", "MeV"), quad
    m_d c^2 = qty("1875.6", "MeV")
  $
  则
  $
    (S_"rad")_d / (S_"rad")_e
    = (0.511 / 1875.6)^2
    approx 7.4 times 10^(-8)
  $

  因此 10 MeV 氘核在铅中的辐射损失率仅约为 10 MeV 电子的
  $
    7.4 times 10^(-8)
  $
  倍.

  对于 20 MeV 电子在铅中的情况, 查电子阻止本领表可得
  $
    S_"col" approx qty("1.277", "MeV cm^2/g"), quad
    S_"rad" approx qty("2.554", "MeV cm^2/g")
  $
  所以
  $
    S_"rad" / S_"col" = 2.554 / 1.277 approx 2.00
  $

  即 20 MeV 电子穿过铅时, 辐射损失约为电离损失的 2 倍.

  = 第四次作业

  == 1 MeV 与 0.1 MeV $gamma$ 射线束注量之比

  设 1 MeV 与 0.1 MeV $gamma$ 射线束的注量分别为 $Phi_1$ 和 $Phi_2$.
  单位体积空气吸收的能量相同, 即空气中的吸收剂量相同, 则有
  $
    Phi_1 E_1 (mu_"en"/rho)_1 = Phi_2 E_2 (mu_"en"/rho)_2
  $

  取空气的质量能量吸收系数
  $
    (mu_"en"/rho)_(0.1 " MeV") approx qty("2.325e-2", "cm^2/g"), quad
    (mu_"en"/rho)_(1 " MeV") approx qty("2.789e-2", "cm^2/g")
  $

  于是
  $
    Phi_1 / Phi_2
    = E_2 (mu_"en"/rho)_2 / (E_1 (mu_"en"/rho)_1)
    = (0.1 times 2.325e-2) / (1.0 times 2.789e-2)
    approx 8.34 times 10^(-2)
  $

  因此两种射线束注量之比为
  $
    Phi_(1 " MeV") : Phi_(0.1 " MeV") approx 0.083 : 1
  $
  也就是说, 若电离密度相同, 则 0.1 MeV $gamma$ 射线束的注量约为 1 MeV 的 $12.0$
  倍.

  == 5 Gy 辐射剂量引起的人体温度变化

  人体比热取
  $
    c = 1 " cal/(g degC)"
    = qty("4.186", "J/(g degC)")
    = qty("4.186e3", "J/(kg degC)")
  $

  吸收剂量
  $
    D = qty("5", "Gy") = qty("5", "J/kg")
  $

  故温度变化为
  $
    Delta T = D / c
    = 5 / (4.186 times 10^3)
    approx qty("1.19e-3", "degC")
  $

  因此 5 Gy 辐射剂量造成的人体温度升高约为
  $
    Delta T approx qty("1.2e-3", "degC")
  $
  即约 $0.0012$ C.

  == 0.5 MeV $gamma$ 射线照射量率对应的组织吸收剂量率

  已知照射量率
  $
    dot(X) = 25.4 " muC/(kg h)" = 100 " mR/h" = qty("0.1", "R/h")
  $

  先求空气中的比释动能率. 对光子有
  $
    dot(K)_"air" = 0.00876 dot(X)
  $
  于是
  $
    dot(K)_"air" = 0.00876 times 0.1
    approx qty("8.76e-4", "Gy/h")
  $

  再用质量能量吸收系数把空气中的结果换算到软组织. 对 0.5 MeV 光子,
  $
    (mu_"en"/rho)_("air")
    approx qty("2.966e-2", "cm^2/g"), quad
    (mu_"en"/rho)_("tissue")
    approx qty("3.269e-2", "cm^2/g")
  $

  故组织吸收剂量率为
  $
    dot(D)_("tissue")
    = dot(K)_("air") ((mu_"en"/rho)_("tissue") / (mu_"en"/rho)_("air"))
  $
  即
  $
    dot(D)_("tissue")
    = 8.76 times 10^(-4) times (3.269 / 2.966)
    approx qty("9.65e-4", "Gy/h")
  $

  因此其对组织的吸收剂量率约为
  $
    dot(D)_("tissue") approx qty("0.965", "mGy/h")
  $

  == $isotope("Am", a: 241)$-Be 中子源照射下眼晶体年当量剂量

  已知中子注量率
  $
    dot(Phi) = qty("1e6", "m^-2 s^-1") = qty("100", "cm^-2 s^-1")
  $

  工作人员每年工作时间为
  $
    t = 15.0 times 12 = qty("180", "h")
    = qty("6.48e5", "s")
  $

  因此年总注量为
  $
    Phi = dot(Phi) t
    = 100 times 6.48 times 10^5
    = qty("6.48e7", "cm^-2")
  $

  查 5 MeV 中子在软组织中的比释动能因子, 可取
  $
    f_k approx qty("3.7e-11", "Gy cm^2")
  $
  又由于题目说明在该能量下 $D$ 与 $K$ 可近似视为相等, 所以
  $
    D approx K = Phi f_k
    = 6.48 times 10^7 times 3.7 times 10^(-11)
    approx qty("2.40e-3", "Gy")
  $

  对 2--20 MeV 的中子, 取辐射权重因子
  $
    w_R = 10
  $
  则眼晶体年当量剂量为
  $
    H = w_R D
    approx 10 times 2.40 times 10^(-3)
    = qty("2.40e-2", "Sv")
  $
  即
  $
    H approx qty("24.0", "mSv/a")
  $

  若按我国现行基本标准 GB 18871-2002 中职业照射眼晶体年当量剂量限值 $150$ mSv
  计, 则未超过限值. 若按 ICRP 118 推荐的职业照射眼晶体剂量限值 $20$ mSv/a 计,
  则该值略高于 推荐限值.

  == 电子对效应下的比释动能与吸收剂量

  相互作用过程可简要表示为:

  + 入射光子: $gamma(10 " MeV")$
  + 电子对效应后: $e^- (4.5 " MeV") + e^+ (4.5 " MeV")$
  + 正负电子在介质中损失全部动能, 其中产生 3 个轫致辐射光子: $1.6$, $1.4$, $2.0$
    MeV, 均逃逸
  + 正电子停下后与介质电子湮灭, 产生 $2 times 0.51$ MeV 光子, 亦全部逃逸

  介质质量为
  $
    m = qty("100", "g") = qty("0.1", "kg")
  $

  比释动能定义为不带电粒子在该物质中释放出的全部带电粒子的初始动能除以质量.
  本题中释放出的带电粒子是正负电子, 故
  $
    E_"tr" = 4.5 + 4.5 = 9.0 " MeV"
  $

  于是比释动能为
  $
    K = E_"tr" / m
    = (9.0 times 1.602 times 10^(-13)) / 0.1
    approx qty("1.44e-11", "Gy")
  $

  吸收剂量应按真正留在该物质中的能量计算. 逃逸的光子总能量为
  $
    E_"esc" = 1.6 + 1.4 + 2.0 + 0.51 + 0.51 = 6.02 " MeV"
  $

  因此物质实际吸收的能量为
  $
    E_"abs" = 10.0 - 6.02 = 3.98 " MeV"
  $

  于是吸收剂量为
  $
    D = E_"abs" / m
    = (3.98 times 1.602 times 10^(-13)) / 0.1
    approx qty("6.38e-12", "Gy")
  $

  因此
  $
    K approx qty("1.44e-11", "Gy"), quad
    D approx qty("6.38e-12", "Gy")
  $

  其中 $D < K$, 是因为一部分能量以轫致辐射光子和湮灭光子的形式逃逸出了该物质.
]

#hw
