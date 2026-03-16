#import "/page.typ": *
#import "meta.typ": desc, title
#show: conf.with(title: title, desc: desc)

= History

The first literature on the poisson point process dates back to
1958@mandel_fluctuations_1958.

= Poisson Point Process

A process $N(t)$ is called inhomogenous poisson process if:

$
       N(0) & =0 \
  N(t)-N(s) & ~"Poisson"(int_s^t kl(u) dd(u)), quad forall 0<=s<t
$

== Likelihood

Observing events at times ${etc(1, n, t)}$ in a time inteveral $[0,T]$ is:

$
  L(kl(t))=exp (-int_0^T kl(t) dd(t))
  product_(i=1)^n kl(t_i)
$

#bibliography("main.bib")
