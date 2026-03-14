#import "/page.typ": *
#import "meta.typ": desc, title
#show: conf.with(title: title, desc: desc)
#let hw = [
  = 第一次作业

  估算一个百万千瓦的压水反应堆每年需要的核燃料质量 ($istp("U")istp("O")_2$,
  假设其中 $u235$ 丰度 5%, 乏燃料中 $u235$ 丰度 1%):

  考虑一年发电量为 $qty("3.1536e16", "J")$, 取热效率 33%, 需要能量
  $qty("9.56e16", "J")$.

  假设每次 $u235$ 裂变释放能量约 $E_f=200$ MeV. 将其换算为焦耳:

  $ E=200 times 10^6 times num("1.602e-19") = qty("3.204e-11", "J") $

  则一年内需要的裂变次数为 $N approx num("2.98e27")$.

  单个 $u235$ 原子质量约为 $qty("3.90e-25", "kg")$.

  因此一年裂变掉的 $u235$ 质量为 $qty("1.16", "t")$.

  题设给出新燃料中 $u235$ 丰度为 5%, 乏燃料中为 1%, 即需要的质量为
  $qty("1.16", "t") / 0.04 approx qty("29.0", "t")$.

  最终换成 $istp("U")istp("O")_2$ 的摩尔质量:
  $ M = 1.134 M_U approx qty("33.0", "t") $

  = 第二次作业

  == 1

  已知六氟化铀在空气中与水蒸气发生水解反应:

  $
    istp("U")istp("F")_6 + 2istp("H")_2istp("O")
    -> istp("U")istp("O")_2istp("F")_2 + 4istp("H")istp("F")
  $

  若产物完全为无水 $istp("U")istp("O")_2istp("F")_2$, 则固体质量为:

  $
    m = 2.84 times 308 approx qty("875", "g")
  $

  但是题目中说明六氟化铀暴露在空气中缓慢和水蒸气反应,
  所得固体产物往往会吸附水分, 也可能形成不同水合程度的固体,
  因此其组成不是唯一确定的.

  若按无水产物计, 其理论质量约为 $qty("875", "g")$.

  若将固体产物加热到, 认为其中的吸附水和结晶水基本除去, 最终剩余固体近似为无水
  $istp("U")istp("O")_2istp("F")_2$, 剩余固体质量为 $qty("875", "g")$.

  == 2

  将水解和中和过程合并，可得总反应为:

  $
    istp("U")istp("F")_6 + 2istp("Na")_2istp("C")istp("O")_3
    -> istp("U")istp("O")_2istp("F")_2 + 4istp("Na")istp("F") + 2istp("C")istp("O")_2
  $

  所以至少需要 $qty("301", "g")$.

  = 第三次作业

  对于扩散膜, 为保证孔内气体流动属于分子流, 需要满足克努森数判据

  $
    K_n = lambda / L > 10
  $

  因此膜孔的最大等效孔径应满足

  $
    L < lambda / 10
  $

  其中分子的平均自由程为

  $
    lambda = 1 / (sqrt(2) pi d^2 n)
  $

  对理想气体，有

  $
    n = P / (k_B T)
  $

  故可得

  $
    lambda = k_B T / (sqrt(2) pi d^2 P)
  $

  下面取室温 $T = 298 K$, 膜前压强为 $100$ mmHg.

  == 分离铀同位素时的最大孔径 $L_0$

  分离铀同位素时, 考虑气体为 $istp("U")istp("F")_6$.

  查得 $istp("U")istp("F")_6$ 的等效分子直径可取

  $
    d_(istp("U")istp("F")_6) approx qty("5.5e-10", "m")
  $

  于是其平均自由程为

  $
    lambda_(istp("U")istp("F")_6)
    = k_B T / (sqrt(2) pi d^2 P)
  $

  即

  $
    lambda_(istp("U")istp("F")_6) approx qty("0.23", "um")
  $

  为了保证 $K_n > 10$，最大孔径应满足

  $
    L_0 = lambda_(istp("U")istp("F")_6) / 10
    approx qty("2.3e-8", "m") = qty("23", "nm")
  $

  == 以氢气为介质分离时的孔径 $L$

  若采用氢气作为介质, 则取氢气分子直径为

  $
    d_(istp("H")_2) approx qty("2.89e-10", "m")
  $

  即

  $
    lambda_(istp("H")_2) approx qty("0.832", "um")
  $

  因此相应的最大孔径为

  $
    L = lambda_(istp("H")_2) / 10
    approx qty("8.3e-8", "m") = qty("83", "nm")
  $
]

#hw
