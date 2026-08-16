#import "/page.typ": *
#import "meta.typ": desc, title
#show: conf.with(title: title, desc: desc)

= History
An early application of the Poisson point process to photoelectron counting can
be found in Mandel (1958)@mandel_fluctuations_1958.

Mandel assumes that, conditioned on the instantaneous optical intensity $P(t)$,
the probability of ejecting one photoelectron in a sufficiently small interval
$[t, t + dd(t)]$ is

$
  P(dd(N)(t) = 1 | P(t))
  = ka P(t) dd(t) + o(dd(t))
$

This leads to a Poisson distribution for the number of photoelectrons in a
finite time interval, conditioned on $P(t)$.

= Poisson Point Process

Let $N(t)$ denote the number of events observed in the interval $[0,t]$.

A counting process $N(t)$ is called an *inhomogeneous Poisson process* with
intensity function $lambda(t) >= 0$ if $N(0) = 0$, it has *independent
increments*, and

$
  N(t) - N(s)
  ~ "Poisson"(kL(s, t))\
  kL(s, t) := int_s^t kl(u) dd(u),
  0 <= s < t
$

Here $kl(t)$ is the *intensity* or *rate* of the process.

$ E[dd(N)(t)] = kl(t) dd(t) $

Equivalently, for a sufficiently small interval $dd(t)$,

$
   P(dd(N)(t) = 1) & = kl(t) dd(t) + o(dd(t)) \
   P(dd(N)(t) = 0) & = 1 - kl(t) dd(t) + o(dd(t)) \
  P(dd(N)(t) >= 2) & = o(dd(t))
$

The expected number of events in an interval $[s,t]$ is

$
  E[N(t) - N(s)]
  =
  kL(s, t)
  =
  int_s^t kl(u) dd(u)
$

For a *homogeneous* Poisson process $kl(t) = kl$, and therefore

$ N(t) - N(s) ~ "Poisson"(kl t- kl s) $

== Event Times

Suppose $n$ events are observed in $[0,T]$ at ordered times

$
  0 < t_1 < t_2 < dots < t_n < T
$

For infinitesimal, mutually disjoint intervals around the observed events
$[t_i, t_i + dd(t_i)]$, the probability of observing one event in every such
interval is approximately

$ product_(i=1)^n kl(t_i) dd(t_i) $

At the same time, the probability of observing no additional events in the
remaining part of $[0,T]$ is

$ exp(- int_0^T kl(t) dd(t)) $

Combining the two gives the joint probability density of the observed point
configuration.

== Likelihood

Observing events at times
${t_1, t_2,...,t_n}$
in the interval $[0,T]$ gives the point-process likelihood

$
  L(kl)
  = exp(- int_0^T kl(t) dd(t))
  product_(i=1)^n kl(t_i)
$

The corresponding log-likelihood is

$ log L(kl) = - integral_0^T kl(t) dd(t) + sum_(i=1)^n log kl(t_i) $

The two terms have simple interpretations:

$- integral_0^T lambda(t) dd(t)$
penalizes the expected total number of events, while
$sum_(i=1)^n log lambda(t_i)$
rewards a model that assigns high intensity to the locations where events are
actually observed.
#bibliography("main.bib")
