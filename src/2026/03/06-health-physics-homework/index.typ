#import "/page.typ": *
#import "meta.typ": desc, title
#show: conf.with(title: title, desc: desc)

#let hw = [
  = 第一次作业

  == 简要分析 X 射线试鞋机的利益与风险

  X 射线试鞋机的利益主要是直接显示脚骨和鞋腔的相对位置, 帮助判断鞋是否合脚,
  并带来新奇的商业体验. 风险在于该照射没有医学诊断或治疗目的,
  所得信息又可由试穿, 测量等无照射方法替代, 因而收益很小而辐射暴露真实存在.
  按正当化原则, 只有收益明显大于风险的照射才合理; X 射线试鞋机属于不必要照射,
  被淘汰是合理的.

  == $kg$ 射线检查焊缝是否正当? 为什么?

  正当. 工业 $kg$ 射线探伤能发现焊缝内部孔隙, 裂纹和未焊透等缺陷,
  对压力容器和核设施等设备的结构安全有直接价值. 其社会收益是预防重大事故,
  降低人员和经济损失, 且该内部信息常难以由外观检查替代, 因而满足正当化要求.

  == 发展核能的风险和利益

  核能的利益是能量密度高, 发电稳定, 运行碳排放低, 有利于能源安全和减排,
  并带动核医学, 材料和工业应用. 风险是核事故后果严重, 放射性废物需长期管理,
  核设施成本高且依赖强监管和安全文化. 因而核能不是单纯的高风险或高收益技术,
  而是需要用高水平工程和制度控制风险的高价值技术.

  == 文献阅读笔记

  文章给我的主要印象是: 辐射防护标准是随证据, 技术和社会风险认知演进的.
  早期标准关注 X 射线皮肤红斑等确定性损伤; 镭工业和内照射问题出现后,
  防护转向体内沉积和职业照射; 核武器试验落下灰使遗传效应成为重点; 1970 年代以后,
  原爆幸存者资料推动标准转向致癌风险, 有效剂量, 内外照射合并评价和 ALARA.
  因此辐射防护既是科学判断, 也是社会选择: ICRP 和 NCRP 同时被批评过于保守
  或不够保守, 正说明防护标准是在不确定性中寻找可执行的平衡.

  = 第二次作业

  == $isotope("Na", a: 24)$ 和 $isotope("P", a: 32)$ 混合物何时活度相同

  设 1 为 $isotope("Na", a: 24)$, 2 为 $isotope("P", a: 32)$. 活度满足
  $A_i(t)=A_(i,0)e^(-kl_i t)$, 初始活度比 $(A_(1,0))/(A_(2,0))=(98)/(2)=49$. 令
  $A_1(t)=A_2(t)$ 得
  $
    t = (ln 49) / (kl_1 - kl_2).
  $
  取 $T_(1/2,1)=qty("14.96", "h")$, $T_(1/2,2)=qty("14.3", "d")
  = qty("343.2", "h")$, 且 $kl_i=(ln 2)/(T_(1/2,i))$, 则
  $t approx qty("88.0", "h") = qty("3.67", "d")$. 因此约 3.7 d 后二者活度相同.

  == 推导氡的平衡当量浓度公式

  记 $C_1=C(isotope("Po", a: 218))$, $C_2=C(isotope("Pb", a: 214))$,
  $C_3=C(isotope("Bi", a: 214))$. 对 alpha 潜能, $isotope("Po", a: 218)$
  后续还包含 $isotope("Po", a: 214)$ 的 alpha 衰变, 故
  $ke_1=6.00+7.69=qty("13.69", "MeV")$; 对 $isotope("Pb", a: 214)$ 和
  $isotope("Bi", a: 214)$, $ke_2=ke_3=qty("7.69", "MeV")$. 因 $C_i=kl_i N_i$,
  alpha 潜能浓度为 $S=sum_i (ke_i C_i)/(kl_i)$. 平衡等效氡浓度 $C_"eq"$ 满足
  $
    C_"eq" =
    ((ke_1 C_1)/(kl_1) + (ke_2 C_2)/(kl_2) + (ke_3 C_3)/(kl_3))
    /
    ((ke_1)/(kl_1) + (ke_2)/(kl_2) + (ke_3)/(kl_3)).
  $
  用 $kl_i=(ln 2)/(T_i)$, $T_1=qty("3.05", "min")$, $T_2=qty("26.8", "min")$,
  $T_3=qty("19.9", "min")$ 得
  $
    C_"eq" = 0.104 C(isotope("Po", a: 218))
    + 0.514 C(isotope("Pb", a: 214))
    + 0.382 C(isotope("Bi", a: 214)).
  $

  == 100 g 硝酸钾样品中的放射性强度

  $chem("K")chem("N")chem("O")_3$ 摩尔质量
  $M approx 39.1+14.0+3 times 16.0 = qty("101.1", "g/mol")$, 故
  $n=(100)/(101.1) approx qty("0.989", "mol")$, 钾原子数
  $N_K approx 0.989 N_A approx 5.95 times 10^23$. 天然丰度
  $f(isotope("K", a: 40))=0.0118%=1.18 times 10^(-4)$, 所以
  $N_40 approx 7.02 times 10^19$. 取 $T_(1/2)=qty("1.248e9", "a")$,
  $A=kl N_40=((ln 2)/(T_(1/2))) N_40$, 换算秒后得
  $A approx qty("1.24e3", "Bq") = qty("1.24", "kBq")$.

  == 与 1 g $isotope("Ra", a: 226)$ 平衡的 $isotope("Rn", a: 222)$ 体积

  1 g $isotope("Ra", a: 226)$ 近似为 $qty("1", "Ci")=qty("3.7e10", "Bq")$.
  平衡时 $A_"Rn"=A_"Ra"$. 取 $T_(1/2)(isotope("Rn", a: 222))=qty("3.82", "d")$,
  则
  $
    N_"Rn" = (A_"Rn" T_(1/2)) / (ln 2) approx 1.76 times 10^16.
  $
  物质的量 $n_"Rn"=(N_"Rn")/(N_A) approx qty("2.93e-8", "mol")$. 在
  $qty("0", "dC")$, 760 mmHg 下, $V=n_"Rn" times qty("22.4", "L")
  approx qty("6.56e-7", "L") = qty("0.656", "uL")$.

  == $isotope("Mo", a: 99)$-$isotope("Tc", a: 99m)$ 发生器再次淋洗的时间

  一次淋洗后取 $A_2(0)=0$. 母体 $isotope("Mo", a: 99)$ 活度
  $A_1=A_((1,0)) e^(-kl_1 t)$, 子体 $isotope("Tc", a: 99m)$ 活度由 Bateman
  公式给出, 因而
  $
    (A_2)/(A_1) = (kl_2)/(kl_2-kl_1) (1 - e^(-(kl_2-kl_1)t)).
  $
  令 $(A_2)/(A_1)=0.98$, 取 $T_(1/2,1)=qty("66.02", "h")$,
  $T_(1/2,2)=qty("6.02", "h")$, 得
  $
    t = (-1)/(kl_2-kl_1) ln(1 - (0.98 (kl_2-kl_1))/(kl_2))
    approx qty("21.1", "h").
  $
  因此一次淋洗后约等 21 h, 子体活度可达当时母体活度的 98%.

  = 第三次作业

  == 某纯 $kb$ 放射性核素的半衰期, 衰变常数和核素判断

  计数率满足 $R(t)=R_0 e^(-kl t)$. 对表中数据作 $ln R$ 对 $t$ 的线性拟合, 得
  $ln R=ln R_0-kl t$, 斜率给出 $kl approx qty("0.0493", "d^-1")$. 因此
  $T_(1/2)=(ln 2)/(kl) approx qty("14.1", "d")$,
  $kl approx (0.0493)/(24 times 3600)=qty("5.70e-7", "s^-1")$.
  半衰期最接近常见纯 $kb$ 核素 $isotope("P", a: 32)$ 的 $qty("14.3", "d")$,
  故该核素判断为 $isotope("P", a: 32)$.

  == 5 mg $isotope("Pb", a: 210)$ 样品 10 年后的活度

  $m=qty("5e-3", "g")$, $M=qty("210", "g/mol")$, 初始原子数
  $N_0=(m N_A)/(M) approx 1.43 times 10^19$. 取 $T_(1/2)=qty("22.3", "a")$,
  $kl=(ln 2)/(T_(1/2))$, 则 $A_0=kl N_0 approx qty("1.41e10", "Bq")$. 10 年后
  $A=A_0 2^((-10)/(22.3)) approx qty("1.03e10", "Bq")$, 即约
  $qty("10.3", "GBq")$.

  == 1 吨 $chem("U")_3 chem("O")_8$ 含量为 10% 的铀矿中 $isotope("U", a: 234)$ 的比活度

  1 吨矿石含 $chem("U")_3 chem("O")_8$ 约 $qty("100", "kg")$.
  $chem("U")_3 chem("O")_8$ 中铀质量分数
  $w_U=(3 times 238)/(3 times 238+8 times 16) approx 0.848$, 故总铀
  $m_U approx qty("84.8", "kg")$. 天然铀中 $isotope("U", a: 234)$ 质量分数取
  $5.3 times 10^(-5)$, 得 $m_234 approx qty("4.50", "g")$. 取
  $T_(1/2)=qty("2.455e5", "a")$, 纯 $isotope("U", a: 234)$ 比活度
  $a_234^*=((ln 2) N_A)/(M T_(1/2)) approx qty("2.30e8", "Bq/g")$. 总活度
  $A_234 approx 2.30 times 10^8 times 4.50 = qty("1.04e9", "Bq")$.
  按矿石质量定义, $a=(A_234)/(qty("1000", "kg")) approx qty("1.04", "MBq/kg")$.

  == 0.5 MeV $kg$ 辐射场中的粒子注量率

  能量注量率 $dot(Psi)=qty("5", "J/m^2/s")$, 单个光子能量
  $E_kg=qty("0.5", "MeV")=0.5 times qty("1.602e-13", "J")
  approx qty("8.01e-14", "J")$. 粒子注量率
  $dot(Phi)=(dot(Psi))/(E_kg) approx qty("6.24e13", "m^-2 s^-1")$.

  == $isotope("Cs", a: 137)$ 点源在 0.5 m 处的粒子注量率和能量注量率

  点源活度 $A=qty("1", "Ci")=qty("3.7e10", "s^-1")$, 取 $Y_kg=0.851$,
  $E_kg=qty("661.7", "keV")$, $r=qty("0.5", "m")$. 各向同性发射给出
  $
    dot(Phi)=(A Y_kg)/(4 pi r^2) approx qty("1.00e10", "m^-2 s^-1").
  $

  又 $E_kg=661.7 times 10^3 times qty("1.602e-19", "J")
  approx qty("1.06e-13", "J")$, 因此:
  $ dot(Psi)=E_kg dot(Phi) approx qty("1.06e-3", "J/m^2/s") $

  == 辐射损失率之比与电子在铅中的辐射损失比

  同一介质中轫致辐射损失率近似 $S_"rad"$ 正比于 $(z^2 E)/(m^2)$. 10 MeV 氘核和
  10 MeV 电子电荷数相同, 动能相同, 所以
  $((S_"rad")_d)/((S_"rad")_e)=((m_e)/(m_d))^2$.

  取 $m_e c^2=qty("0.511", "MeV")$, $m_d c^2=qty("1875.6", "MeV")$, 得比值为
  $7.4 times 10^(-8)$. 对 $qty("20", "MeV")$ 电子在铅中, 查表取
  $S_"col"=qty("1.277", "MeV cm^2/g")$, $S_"rad"=qty("2.554", "MeV cm^2/g")$, 故
  $(S_"rad")/(S_"col") approx 2.00$, 即辐射损失约为电离损失的 2 倍.

  = 第四次作业

  == 1 MeV 与 0.1 MeV $kg$ 射线束注量之比

  空气吸收能量相同意味着
  $Phi_1 E_1 ((mu_"en")/(rho))_1 = Phi_2 E_2 ((mu_"en")/(rho))_2$.

  取空气质量能量吸收系数
  $((mu_"en")/(rho))_(0.1 " MeV") approx qty("2.325e-2", "cm^2/g")$,
  $((mu_"en")/(rho))_(1 " MeV") approx qty("2.789e-2", "cm^2/g")$, 则
  $
    (Phi_1)/(Phi_2) = (E_2 ((mu_"en")/(rho))_2)/(E_1 ((mu_"en")/(rho))_1)
    approx 8.34 times 10^(-2)
  $

  因而 $Phi_(1 " MeV") : Phi_(0.1 " MeV") approx 0.083 : 1$, 光子束注量约为
  $qty("1", "MeV")$ 的 12 倍.

  == 5 Gy 辐射剂量引起的人体温度变化

  人体比热取 $c=qty("1", "cal/g/dC")=qty("4.186e3", "J/kg/dC")$. 吸收剂量
  $D=qty("5", "Gy")=qty("5", "J/kg")$, 所以
  $kD T=(D)/(c) approx qty("1.19e-3", "dC")$. 因此 $qty("5", "Gy")$ 只会造成约
  $qty("0.0012", "dC")$ 的温升, 热效应很小.

  == 0.5 MeV $kg$ 射线照射量率对应的组织吸收剂量率

  已知 $dot(X)=qty("25.4", "muC/(kg h)")=qty("100", "mR/h")
  =qty("0.1", "R/h")$. 空气比释动能率
  $dot(K)_"air"=0.00876 dot(X) approx qty("8.76e-4", "Gy/h")$. 对
  $qty("0.5", "MeV")$ 光子取
  $((mu_"en")/(rho))_"air" approx qty("2.966e-2", "cm^2/g")$,
  $((mu_"en")/(rho))_"tissue" approx qty("3.269e-2", "cm^2/g")$, 则
  $
    dot(D)_"tissue" = dot(K)_"air"
    (((mu_"en")/(rho))_"tissue" / ((mu_"en")/(rho))_"air")
    approx qty("9.65e-4", "Gy/h")
  $
  即组织吸收剂量率约 $qty("0.965", "mGy/h")$.

  == $isotope("Am", a: 241)$-Be 中子源照射下眼晶体年当量剂量

  中子注量率 $dot(Phi)=qty("1e6", "m^-2 s^-1")=qty("100", "cm^-2 s^-1")$,
  年工作时间 $t=15.0 times 12=qty("180", "h")=qty("6.48e5", "s")$, 年注量
  $Phi=dot(Phi)t=qty("6.48e7", "cm^-2")$.

  5 MeV 中子在软组织中的 比释动能因子取 $f_k approx qty("3.7e-11", "Gy cm^2")$,
  且 $D approx K$.

  因而 $D=Phi f_k approx qty("2.40e-3", "Gy")$. 取 $w_R=10$, 眼晶体当量剂量
  $H=w_R D approx qty("2.40e-2", "Sv")=qty("24.0", "mSv/a")$. 该值低于 GB
  18871-2002 的 $150$ mSv/a, 但略高于 ICRP 118 的 $qty("20", "m Sv/a")$ 推荐值.

  == 电子对效应下的比释动能与吸收剂量

  10 MeV 光子发生电子对效应, 产生 $e^-$ 和 $e^+$ 各 4.5 MeV.
  比释动能按不带电粒子 释放出的带电粒子初始动能计,
  $E_"tr"=4.5+4.5=qty("9.0", "MeV")$. 对 $m=qty("100", "g")=qty("0.1", "kg")$,
  $K=(E_"tr")/(m) approx qty("1.44e-11", "Gy")$. 吸收剂量按留在介质中的能量计:
  逃逸轫致辐射和湮灭光子能量 $E_"esc"=1.6+1.4+2.0+0.51+0.51=qty("6.02", "MeV")$,
  所以 $E_"abs"=10.0-6.02=qty("3.98", "MeV")$,
  $D=(E_"abs")/(m) approx qty("6.38e-12", "Gy")$. 因为部分能量以光子形式逃逸, 故
  $D<K$.

  = 第五次作业

  == 确定性效应与随机性效应的特点与差异

  确定性效应又称组织反应, 特点是有阈值: 低于阈值通常无可观察损伤,
  超过阈值后严重程度随剂量增加而加重, 生物学基础多是大量细胞死亡或组织功能受损,
  如皮肤红斑, 脱发, 白内障, 不育和急性放射病. 随机性效应通常按无阈处理:
  剂量增加主要提高发生概率, 不决定一旦发生后的严重程度,
  典型例子是致癌和遗传效应. 防护上, 前者目标是避免超过阈值,
  后者目标是在正当化前提下按 ALARA 降低概率风险.

  == 对线性无阈假设的观点

  LNT 假设认为辐射致癌风险与剂量线性相关且无安全阈值. 我的态度是审慎接受,
  有限使用: 在职业防护, 公众防护和法规制定中, LNT 形式简单, 偏保守,
  适合作为剂量限值和优化的工作假设; 在医学实践中, 不应把低剂量线性外推得到的微小
  理论风险当作个体患者的确定伤害. 原因是 $qty("100", "mSv")$ 以下人体证据有限,
  高剂量外推模型依赖强, 置信区间宽, 且 DNA 修复, 细胞凋亡, 免疫监视和分次效应
  都说明低剂量生物响应未必是简单线性. 更合适的表述是: 低剂量风险可能存在,
  量级很小且不确定性大, 因而应优化照射而不应制造不必要恐慌.

  = 第六次作业

  == 4 MeV alpha 粒子在石墨中的剂量率

  注量率 $dot(Phi)=qty("1.0e3", "m^-2 s^-1")=qty("0.10", "cm^-2 s^-1")$.
  对带电粒子, $dot(D)=dot(Phi)((S_"col")/(rho))$. 查 ASTAR 取 4 MeV alpha 在
  graphite 中 $(S_"col")/(rho) approx qty("6.5e2", "MeV cm^2/g")$, 得
  $dot(D)=0.10 times 6.5 times 10^2=qty("65", "MeV/g/s")$. 用
  $1 " MeV/g"=1.602 times 10^(-10) " Gy"$, 得
  $dot(D) approx qty("1.04e-8", "Gy/s")=qty("37.5", "uGy/h")$.

  == 2 MeV 电子在铅中的射程

  题给 2 MeV 电子在铝中的质量射程 $R_m("Al")=qty("1.22", "g/cm^2")$. MeV
  量级电子用质量厚度表示的 CSDA 射程在不同材料中同量级, 取
  $rho_"Pb"=qty("11.35", "g/cm^3")$, 则铅中线射程
  $R("Pb") approx (R_m)/(rho_"Pb")=(1.22)/(11.35) " cm" approx qty("1.08", "mm")$.
  因而可记为约 $qty("1", "mm")$.

  == 含 $isotope("Co", a: 60)$ 溶液直管的照射量率和空气比释动能率

  管长 $L=qty("2", "m")=qty("200", "cm")$, 截面积 $S=qty("1", "cm^2")$, 体积
  $V=qty("200", "cm^3")$. 活度浓度 $C_A=qty("2.1e9", "Bq/cm^3")$, 总活度
  $A=C_A V=qty("4.2e11", "Bq")=qty("11.35", "Ci")$. 取 $isotope("Co", a: 60)$
  照射量率常数 $Gamma=qty("1.32", "R m^2/(Ci h)")$. 对长 $L$ 的线源,
  距管轴中点垂直距离 $r=qty("2", "m")$ 处
  $
    dot(X)=Gamma A (2)/(L) arctan((L)/(2 r)).
  $
  代入 $L=qty("2", "m")$, $r=qty("2", "m")$ 得
  $dot(X) approx qty("3.47", "R/h")$. 用 $1 " R" approx 8.76 " mGy"$, 得
  $dot(K)_"air" approx qty("30.4", "mGy/h")$.

  == $isotope("Sr", a: 90)$ 点源容器的有机玻璃和铅屏蔽

  $isotope("Sr", a: 90)$-$isotope("Y", a: 90)$ 中 $isotope("Y", a: 90)$ 的
  $E_"max" approx qty("2.28", "MeV")$ 决定 beta 屏蔽. 经验式
  $R_m=0.542E_"max"-0.133$ 给出 $R_m approx qty("1.10", "g/cm^2")$. 取有机玻璃
  $rho_"PMMA"=qty("1.18", "g/cm^3")$, 厚度
  $d_"PMMA"=(R_m)/(rho_"PMMA") approx qty("0.94", "cm")$, 即内层可取约 1 cm.

  对外层铅, 点源活度 $A=qty("3.7e12", "Bq")$. 平衡链 beta 平均能量取
  $overline(E)_beta approx 0.196+0.934=qty("1.13", "MeV")$, beta 功率
  $P_beta=A overline(E)_beta times 1.602 times 10^(-13) approx qty("0.67", "W")$.
  低 $Z$ 材料轫致辐射份额取 $f approx 3.5 times 10^(-4) Z E_"max"$, 对 PMMA 取
  $Z_"eff" approx 6$, 得 $f approx 4.8 times 10^(-3)$,
  $P_gamma approx qty("3.2e-3", "W")$. 在 $r=qty("2", "m")$ 处
  $dot(Psi) approx (P_gamma)/(4 pi r^2) approx qty("6.4e-5", "J/(m^2 s)")$. 取
  $((mu_"en")/(rho))_"air" approx qty("3.0e-3", "m^2/kg")$, 得未屏蔽
  $dot(D)_0 approx qty("6.9e-4", "Gy/h")$. 要求 $dot(D)<=qty("5", "uGy/h")$,
  衰减倍数 $B approx (0.69 " mGy/h")/(5 " uGy/h") approx 1.4 times 10^2$. 对 MeV
  光子取 $mu_"Pb" approx qty("0.79", "cm^-1")$, 得
  $d_"Pb"=(ln B)/(mu_"Pb") approx qty("6.2", "cm")$. 因此屏蔽结构为内层约 1 cm
  有机玻璃, 外层约 6 cm 铅; 若把铅放内层会显著增加轫致辐射, 不合理.

  == Po-Be 中子源的石蜡屏蔽厚度

  源活度 $A=qty("7.4e11", "Bq")=qty("20", "Ci")$. 取 Po-Be 中子产额
  $Y_n approx qty("2.5e6", "n/(s Ci)")$, 源强 $S=20 Y_n=qty("5.0e7", "n/s")$. 在
  $r=qty("1", "m")$ 处
  $dot(Phi)_0=(S)/(4 pi r^2) approx qty("3.98e6", "m^-2 s^-1")$. 题给
  $h_Phi=qty("3.55e-14", "Sv m^2")$, 故
  $dot(H)_0=dot(Phi)_0 h_Phi approx qty("509", "uSv/h")$. 要求
  $dot(H)<=qty("7.5", "uSv/h")$, 衰减倍数 $B=(509)/(7.5) approx 67.8$.
  取石蜡去除截面 $Sigma_R=qty("0.12", "cm^-1")$, 指数衰减给出
  $x=(ln B)/(Sigma_R) approx qty("35", "cm")$.

  == $isotope("Cs", a: 137)$ 污染阀门维修所需铅屏蔽

  距阀门 $qty("30", "cm")$ 处 $dot(X)=qty("500", "R/h")$. 维修距离
  $qty("2", "m")$ 时按反平方关系
  $dot(X)_2=500 ((0.30)/(2.0))^2 approx qty("11.25", "R/h")$. 对 662 keV 光子取
  $1 " R" approx 10 " mSv"$, 4 h 未屏蔽剂量当量
  $H_0=11.25 times 4 times 10 = qty("450", "mSv")$. 要求 $H<=qty("1", "mSv")$,
  衰减倍数 $B=450$. 对铅取 $mu_"Pb" approx qty("1.25", "cm^-1")$, 即
  $"HVL"=(ln 2)/(mu_"Pb") approx qty("0.55", "cm")$. 窄束指数衰减要求
  $e^(-mu x)<=(1)/(B)$, 故 $x>=(ln 450)/(1.25) approx qty("4.9", "cm")$.

  = 第七次作业

  == $isotope("Po", a: 210)$ 沉积于肝时的 50 年待积当量剂量

  初始肝沉积 $q_0=qty("1", "Bq")$. 取物理半衰期 $T_p=qty("138.4", "d")$,
  肝中生物半排期 $T_b=qty("50", "d")$, 有效半衰期
  $T_"eff"=((1)/(T_p)+(1)/(T_b))^(-1) approx qty("36.7", "d")$. 50 年远大于
  $T_"eff"$, 故累积活度
  $tilde(A) approx (q_0)/(lambda_"eff") approx qty("4.58e6", "Bq s")$. 题给
  $S_w=qty("0.06", "MeV/g")$, 所以
  $D=tilde(A)S_w times 1.602 times 10^(-10) approx qty("4.4e-5", "Gy")$.
  $isotope("Po", a: 210)$ 为 alpha 发射体, 取 $w_R=20$, 得
  $H_50("肝" <- "肝")=w_R D approx qty("8.8e-4", "Sv")=qty("0.88", "mSv")$.

  == 吸入微量 $isotope("I", a: 131)$ 的年内照射剂量判断

  空气浓度 $C=qty("0.45", "Bq/m^3")$, 年工作时间 $50 times 40=2000$ h, 吸入率
  $qty("0.02", "m^3/min")$, 年吸入体积
  $V=0.02 times 2000 times 60=qty("2400", "m^3")$. 年摄入活度
  $I=C V approx qty("1.08e3", "Bq")$. 对职业人员吸入 $isotope("I", a: 131)$
  取剂量系数 $e(50) approx qty("1.1e-8", "Sv/Bq")$, 则
  $E(50)=I e(50) approx qty("1.2e-5", "Sv")=qty("0.012", "mSv")$.
  该值远低于职业照射有效剂量限值, 但实际防护仍应关注通风,
  碘化学形态和局部高浓度操作.

  == 每天吃 1 根香蕉所致待积有效剂量估算

  一根香蕉取 $qty("150", "g")$, 含钾 $qty("2.56", "mg/g")$, 即
  $m_K=qty("0.384", "g")$. 天然钾比活度约 $qty("31.1", "Bq/g")$, 故每根香蕉
  $isotope("K", a: 40)$ 活度 $A_K=0.384 times 31.1 approx qty("11.9", "Bq")$.
  每天 1 根, 年摄入 $I approx 11.9 times 365 = qty("4.35e3", "Bq")$. 成人摄入
  $isotope("K", a: 40)$ 取 $e(50) approx qty("6.2e-9", "Sv/Bq")$, 得
  $E(50) approx qty("2.7e-5", "Sv")=qty("27", "uSv")$, 即单根约
  $qty("0.074", "uSv")$. 由于人体维持钾稳态, 该数值主要用于说明天然本底量级.

  == 隔室模型的生物动力学方程组

  设第 $i$ 个隔室核素量为 $q_i(t)$, 生物廓清速率为 $lambda_i$, 物理衰变常数为
  $lambda_r$, 外部摄入速率为 $I$. 路径比例为 $a_12=1$, $a_23=0.30$, $a_24=0.70$,
  $a_32=0.50$, $a_34=0.50$. 因而
  $
    (d q_1)/(d t) = I - (lambda_1 + lambda_r) q_1,
  $
  $
    (d q_2)/(d t) = lambda_1 q_1 + 0.50 lambda_3 q_3
    - (lambda_2 + lambda_r) q_2,
  $
  $
    (d q_3)/(d t) = 0.30 lambda_2 q_2 - (lambda_3 + lambda_r) q_3,
  $
  $
    (d q_4)/(d t) = 0.70 lambda_2 q_2 + 0.50 lambda_3 q_3 - lambda_r q_4.
  $
  该模型本质上是多隔室一阶转移动力学: 输入来自摄入或上游转移,
  输出来自生物廓清和物理衰变; 隔室 4 是生物滞留终端, 只受物理衰变减少.

  = 第八次作业

  == 气体正比计数器的布拉格-戈瑞关系式

  设气体空腔足够小, 不明显扰动介质中带电粒子的能谱和注量.
  这是布拉格-戈瑞空腔理论的基本条件. 记被测介质为 $m$, 空腔气体为 $g$.
  对同一带电粒子能量注量谱 $Phi_E$, 介质中的吸收剂量可写为
  $D_m = integral Phi_E ((S_"col")/(rho))_m dif E$, 而空腔气体中的吸收剂量为
  $D_g = integral Phi_E ((S_"col")/(rho))_g dif E$.
  定义介质对气体的平均质量碰撞阻止本领比:
  $
    s_(m,g) =
    (integral Phi_E ((S_"col")/(rho))_m dif E)
    /
    (integral Phi_E ((S_"col")/(rho))_g dif E)
  $
  于是得到布拉格-戈瑞关系:

  $
    D_m = s_(m,g) D_g
  $

  对气体正比计数器, 设收集到的总电荷为 $Q$, 气体放大倍数为 $G$, 气体质量为
  $m_g = rho_g V$, 气体平均电离能为 $W_g$. 由于正比计数器的收集电荷包含气体放大,
  原初电离电荷应为 $(Q)/(G)$. 原初电离产生的离子对数为 $N_i = (Q)/(G e)$.
  气体中对应的能量沉积为 $epsilon_g = N_i W_g = (Q W_g)/(G e)$,
  所以气体吸收剂量为 $D_g = (epsilon_g)/(m_g) = (Q W_g)/(G e m_g)$.
  代回布拉格-戈瑞关系, 得到适用于气体正比计数器的形式:
  $
    D_m = (s_(m,g) Q W_g) / (G e rho_g V)
  $

  若 $Q$ 已经指原初电离电荷, 或使用无气体放大的普通电离室, 则取 $G = 1$.

  == 薄壁空气电离室测塑料体模吸收剂量

  题给空气电离室体积 $V = qty("0.5", "cm^3")$, 收集电荷
  $Q = qty("1.65e-9", "C")$, 塑料体模对空气的相对碰撞阻止本领为
  $s_("plastic,air") = 1.1$.

  薄壁空气电离室可按布拉格-戈瑞关系处理. 取标准状态空气密度
  $rho_"air" = qty("1.293e-6", "kg/cm^3")$, 则电离室中空气质量为:
  $
    m_"air" = rho_"air" V
    = 1.293 times 10^(-6) times 0.5
    = qty("6.47e-7", "kg")
  $

  空气的平均电离能取 $(W_"air")/(e) approx qty("33.97", "J/C")$, 空气吸收剂量为
  $D_"air" = ((Q)/(m_"air")) ((W_"air")/(e))
  = (1.65 times 10^(-9)) / (6.47 times 10^(-7)) times 33.97
  approx qty("8.67e-2", "Gy")$.

  因此电离室所在位置塑料体模中的吸收剂量为
  $D_"plastic" = s_("plastic,air") D_"air"
  = 1.1 times 8.67 times 10^(-2)
  approx qty("9.5e-2", "Gy")$.

  即:
  $ D_"plastic" approx qty("0.095", "Gy") approx qty("9.5", "rad") $

  = 第九次作业

  == 探测限 $L_D$ 的表达式

  记净计数为 $N=N_T-N_b$, 其中 $N_T$ 为样品总计数, $N_b$
  为按相同测量时间折算的本底计数. 当样品实际无放射性时, $N_T$
  和本底测量的期望都为 $N_b$, 计数涨落服从泊松统计, 因而净计数的标准偏差为:

  $
    ks_0 = sqrt(N_b + N_b) = sqrt(2 N_b)
  $

  判断限用于控制第一类错误. 取 $ka=0.05$, 有 $k_ka=1.645$, 所以:

  $
    L_C = k_ka ks_0 = k_ka sqrt(2 N_b)
  $

  探测限还要控制第二类错误. 若真实净计数为 $L_D$, 则总计数期望为 $N_b+L_D$,
  扣本底后的标准偏差为:

  $
    ks_n = sqrt(N_b + L_D + N_b) = sqrt(L_D + 2 N_b)
  $

  在置信水平取 $ka=kb=0.05$ 时, 探测限满足:

  $
    L_D = L_C + k_kb ks_n = k_ka sqrt(2 N_b) + k_kb sqrt(L_D + 2 N_b)
  $

  令 $k_ka=k_kb=k=1.645$, 解得:

  $
    L_D = k^2 + 2 k sqrt(2 N_b)
    approx 2.71 + 4.65 sqrt(N_b)
  $

  == 总计数率, 本底计数率和净计数率的标准偏差

  题给总计数 $N_T=560$, 测量时间 $t_T=qty("10", "min")$; 本底计数 $N_b=390$,
  本底测量时间 $t_b=qty("15", "min")$. 泊松计数的标准偏差为 $sqrt(N)$,
  计数率标准偏差为 $sqrt(N)/t$.

  总计数率:

  $
    R_T = (N_T)/(t_T) = 560 / 10 = qty("56.0", "min^-1")
    = qty("0.933", "s^-1")
  $

  $
    ks_(R_T) = (sqrt(N_T))/(t_T)
    = sqrt(560) / 10
    approx qty("2.37", "min^-1")
    = qty("0.0394", "s^-1")
  $

  本底计数率:

  $
    R_b = (N_b)/(t_b) = 390 / 15 = qty("26.0", "min^-1")
    = qty("0.433", "s^-1")
  $

  $
    ks_(R_b) = (sqrt(N_b))/(t_b)
    = sqrt(390) / 15
    approx qty("1.32", "min^-1")
    = qty("0.0219", "s^-1")
  $

  净计数率为:

  $
    R_n = R_T - R_b
    = qty("30.0", "min^-1")
    = qty("0.500", "s^-1")
  $

  由于总计数和本底计数相互独立, 净计数率标准偏差按平方和合成:

  $
    ks_(R_n) = sqrt(ks_(R_T)^2 + ks_(R_b)^2)
    = sqrt((2.37)^2 + (1.32)^2)
    approx qty("2.71", "min^-1")
    = qty("0.0451", "s^-1")
  $

  汇总为:

  #table(
    columns: 4,
    table.header([项目], [计数率], [标准偏差], [标准偏差]),

    [总计数率],
    [$qty("56.0", "min^-1")$],
    [$qty("2.37", "min^-1")$],
    [$qty("0.0394", "s^-1")$],

    [本底计数率],
    [$qty("26.0", "min^-1")$],
    [$qty("1.32", "min^-1")$],
    [$qty("0.0219", "s^-1")$],

    [净计数率],
    [$qty("30.0", "min^-1")$],
    [$qty("2.71", "min^-1")$],
    [$qty("0.0451", "s^-1")$],
  )

  == 擦拭样测量系统的 MDA

  空白擦拭样品测量 $qty("10", "min")$ 得到本底计数 $N_b=400$. 样品测量时间也为
  $qty("10", "min")$, 总探测效率为 $epsilon=10%=0.10$.

  先用上一题的 95% 置信水平探测限公式:

  $
    L_D = 2.71 + 4.65 sqrt(N_b)
    = 2.71 + 4.65 sqrt(400)
    approx num("95.7")
  $

  这表示至少需要约 $95.7$ 个净计数才能认为样品活度达到该系统的可探测水平.
  测量活时间 $t=qty("10", "min")=qty("600", "s")$, 故:

  $
    "MDA" = (L_D)/(epsilon t)
    = (95.7)/(0.10 times 600)
    approx qty("1.60", "Bq")
  $

  因此该擦拭样测量系统的最小可探测活度约为 $qty("1.6", "Bq")$.
  若某擦拭样品活度大于此值, 可判断该区域存在可探测的表面污染.
]

#hw
