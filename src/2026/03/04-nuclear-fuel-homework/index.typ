#import "/page.typ": *
#import "meta.typ": desc, title
#show: conf.with(title: title, desc: desc)

= 第一次作业

估算一个百万千瓦的压水反应堆每年需要的核燃料质量 ($isotope("U")isotope("O")_2$,
假设其中 $u235$ 丰度 5%, 乏燃料中 $u235$ 丰度 1%):

考虑一年发电量为 $qty("3.1536e16", "J")$, 取热效率 33%, 需要能量
$qty("9.56e16", "J")$.

假设每次 $u235$ 裂变释放能量约 $E_f=200mev$. 将其换算为焦耳:

$ E=200 times 10^6 times num("1.602e-19") = qty("3.204e-11", "J") $

则一年内需要的裂变次数为 $N approx num("2.98e27")$.

单个 $u235$ 原子质量约为 $qty("3.90e-25", "kg")$.

因此一年裂变掉的 $u235$ 质量为 $qty("1.16", "t")$.

题设给出新燃料中 $u235$ 丰度为 5%, 乏燃料中为 1%, 即需要的质量为
$qty("1.16", "t") / 0.04 approx qty("29.0", "t")$.

最终换成 $isotope("U")isotope("O")_2$ 的摩尔质量:
$ M = 1.134 M_U approx qty("33.0", "t") $
