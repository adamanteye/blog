#import "/page.typ": *
#import "meta.typ": desc, title
#show: conf.with(title: title, desc: desc)

= Bayes Theorem

== Bayes theorem
$ p(kt|D)=(p(D|kt)p(kt))/p(D)prop p(D|kt)p(kt) $

== Prior predictive distribution
$ p(D)=int_kT p(D|kt)p(kt) dd(kt) $

== Posterior predictive distribution
$
  p(tilde(y)|D) & =int_kT p(tilde(y),kt|D)dd(kt) \
                & =int_kT p(tilde(y)|kt,D) p(kt|D) dd(kt) \
                & =int_kT p(tilde(y)|kt) p(kt|D) dd(kt) \
$

= Fundamental Distributions

#let phi = $phi.alt$

#figure(
  table(
    columns: 5,
    table.hline(),
    table.header([Name], [PDF/PMF], [Mean], [Variance], [Mode]),
    table.hline(),
    [$"Beta" (y|ka,kb)$],
    [$kG(ka+kb)/(kG(ka)kG(kb)) y^(ka-1) (1-y)^(kb-1)$],
    [$ka/(ka+kb)$],
    [$(ka kb)/((ka+kb)^2(ka+kb+1))$],
    [$(ka-1)/(ka+kb-2)$],

    [$"Binomial" (y|n,p)$],
    [$binom(n, y)p^y (1-p)^(n-y)$],
    [$n p$],
    [$n p(1-p)$],
    [],

    [$"Dirichlet" (va(y)|va(ka))$],
    [$(kG(ka_0))/(product_(i=1)^K kG(ka_i))
    product_(i=1)^K y_i^(ka_i-1)$],
    [$ka_i/ka_0$],
    [$(ka_i(ka_0-ka_i))/(ka_0^2(ka_0+1))$],
    [$(ka_i-1)/(ka_0-K), ka_i>1 forall i$],

    [$"Exponential" (y|kl)$], [$kl e^(-kl y)$], [$1/kl$], [$(ln 2)/kl$], [$0$],

    [$"Erlang" (y|kl,k)$],
    [$(kl^k y^(k-1) e^(-kl y))/((k-1)!)$],
    [$k/kl$],
    [$k/kl^2$],
    [$1/kl (k-1)$],

    [$"ExGauss" (y|mu, ks, kl)$],
    [$kl/2 exp(kl/2 (2mu + kl ks^2 -2y)) "erfc" ((mu + kl ks^2 - y)/(sqrt(2) ks)$],
    [],
    [],
    [],

    [$"Gamma" (y|ka,kb)$],
    [$kb^ka /kG(ka) y^(ka-1) e^(-kb y)$],
    [$ka/kb$],
    [$ka/kb^2$],
    [$(ka-1)/kb$],

    [$"InvGamma" (y|ka,kb)$],
    [$kb^ka /kG(ka) y^(-ka-1) e^(-kb\/y)$],
    [$kb/(ka-1)$],
    [$kb^2/((ka-1)^2(ka-2))$],
    [$kb/(ka-1)$],

    [$"LogNormal" (y|ka,kb)$],
    [$1/(y ks sqrt(2 pi)) e^(-(ln y-mu)^2/(2 ks^2))$],
    [$e^(mu+ks^2/2)$],
    [$(e^(ks^2)-1)e^(2mu+ks^2)$],
    [$e^(mu-ks^2)$],

    [$"Possion" (y|kl)$], [$(kl^y e^(-kl))/(y!)$], [$kl$], [$kl$], [],

    [$"NegBinomial" (k|r,p)$],
    [$binom(k+r-1, k)(1-p)^k p^r$],
    [$(r(1-p))/p$],
    [$(r(1-p))/p^2$],
    [],

    [$"Normal" (y|mu,ks^2)$],
    [$1/(sqrt(2pi)ks) exp(-(y-mu)^2/(2ks^2))$],
    [$mu$],
    [$ks^2$],
    [$mu$],

    [$"Student" (y|nu)$],
    [$kG((nu+1)/2)/(sqrt(pi nu) kG(nu/2))(1+y^2/nu)^(-(nu+1)/2)$],
    [$0$],
    [$nu/(nu-2)$],
    [$0$],

    [$"Uniform" (y|a,b)$], [$1/(b-a)$], [$(a+b)/2$], [$(b-a)^2/12$], [],
    table.hline(),
  ),
  caption: [Common Probability Distributions],
)

= Functions

== Beta Function

$ B(z_1,z_2)=int_0^1 t^(z_1-1) (1-t)^(z_2-1) dd(t) $

Properties:
- $B(z_1,z_2)=B(z_2,z_1)$
- $B(z_1,z_2)=(kG(z_1)kG(z_2))/kG(z_1+z_2)$
- $B(m,n)=((m-1)!(n-1)!)/(m+n-1)! =(m+n)/(m n)\/binom(m+n, m)$

= Conjugate Prior
The idea of a *conjugate prior* is that for a given likelihood we choose a prior
distribution such that, after observing data and applying Bayes' theorem, the
posterior distribution belongs to the same family as the prior.

That is, if $p(kt)$ and $p(kt | D)$ have the same distributional form, then the
prior is called a *conjugate prior* for the likelihood model.

This is useful because it makes Bayesian updating analytically tractable.
Instead of performing difficult integration or numerical approximation, we can
often derive the posterior parameters in closed form.

= Conjugate Prior for Exponential Families
Note general exponential family:

$
  p(y_i|kt)=f(y_i) exp(
    phi(kt)^TT u(y_i)
    - g(kt)
  )
$

For the data set $D={y_1, dots, y_n}$ of i.i.d. observations, the likelihood is

$
  p(D|kt)=product_(i=1)^n (f(y_i)) exp(
    phi(kt)^TT sum_(i=1)^n u(y_i)
    - n g(kt)
  )
$

So conjugate prior for that likelihood is
$ p(kt)prop exp(phi(kt)^TT nu-n_0 g(kt)) $

Posterior is
$ p(kt|D)prop exp(phi(kt)^TT (nu+sum_(i=1)^n u(y_i))-(n_0+n) g(kt)) $

= Proper and Improper Prior Distributions
A prior is called *proper* if it is a valid probability distribution:
$
  p(kt)>=0, forall kt in kT, int_(kt in kT) p(kt) dd(kt) =1
$

And *improper* if
$
  p(kt)>=0, forall kt in kT, int_(kt in kT) p(kt) dd(kt) =inft
$

- If a prior is proper, so must the posterior.
- If a prior is improper, the posterior could be proper or improper.

In theory, all priors are acceptable, as long as the posterior is proper.

= Fisher Information Matrix

$
  va(I)(va(kt))=E((grad log p(y|va(kt))) (grad log p(y|va(kt)))^TT)
  =-E(grad^2 log p(y|va(kt)))
$

= Jeffreys' Prior

$ pi_J (va(kt))~sqrt(abs(va(I)(va(kt)))^2) $

= Pivotal Quantities

For the binomial and other single-parameter models, different principles give
(slightly) different noninformative prior distributions. But for two
cases—location parameters and scale parameters—all principles seem to
agree@gelman2013bayesian.

== Location Parameter

$ p(kt) ~ 1 $

== Scale Parameter

$ p(kt) ~ 1/kt $

= Predictive Accuracy

People care about the accuracy in two different ways. First to assume that the
model is all we known and check posterior predictions. The second is to compare
several candidate models. Even if all of the models being considered have
mismatches with the data, it can be informative to evaluate their predictive
accuracy, compare them, and consider where to go next@gelman_understanding_2014.

= KL Divergence

= Linear Algebra

== Convex Combination

A subset $A$ of a vector space $V$ is said to be convex if
$kl va(x)+(1-kl) va(y)$ for all vectors $va(x),va(y) in A$, and all scalars $kl$
in $[0,1]$.

Via induction, this can be seen to be equivalent to the requirement that
$etc(1, n, kl va(x)) in A$ for all vectors $etc(1, n, va(x))in A$, and for all
scalars $etc(1, n, kl)>=0$ such that $sum k_i=1$.

= Reversible Jump MCMC

Reversible Jump Markov chain Monte Carlo (RJMCMC) samples jointly over a family
of candidate models $cal(M)={M_k: k in K}$ and their parameters. Under model
$M_k$, let $va(kt)_k in kT_k subset.eq RR^(n_k)$. For a fixed observed data set
$D$, the joint posterior is the product of the likelihood and the joint prior,
$p(k,va(kt)_k)=p(va(kt)_k|k)p(k)$@brooks_handbook_2011:

$
  pi(k, va(kt)_k|D)
  = (cal(L)(D|k, va(kt)_k)p(va(kt)_k|k)p(k))
  /(sum_(m in K) int_(kT_m) cal(L)(D|m, va(kt)_m)
  p(va(kt)_m|m)p(m) dd(va(kt)_m)).
$

Unlike ordinary MCMC, the state space is the disjoint union
$union.dot_(k in K) ({k} times kT_k)$, so a jump between $M_k$ and $M_(k')$ may
change the dimension of the parameter vector.

== Sampler Configuration

An RJMCMC sampler is specified by the following components:

- a within-model kernel $K_k$ that leaves $pi(va(kt)_k|k, D)$ invariant
- jump-selection probabilities $r(k'|k)$ for $k' != k$, satisfying
  $sum_(k' != k) r(k'|k) <= 1$
- auxiliary proposal densities $q_(k,k')(va(u)|va(kt)_k)$
- a differentiable bijection $T_(k,k')$ paired with its reverse $T_(k',k)$
  $T_(k,k'): kT_k times cal(U)_(k,k') arrow.r
  kT_(k') times cal(U)_(k',k)$, with the dimension-matching condition
  $n_k+d_(k,k')=n_(k')+d_(k',k)$, where $d_(k,k')=dim cal(U)_(k,k')$.

Starting from $(k,va(kt)_k)$, select a destination model $k'$ with probability
$r(k'|k)$, draw $va(u) ~ q_(k,k')(dot|va(kt)_k)$, and apply

$
  (va(kt)_(k'),va(u)')=T_(k,k')(va(kt)_k,va(u))
$

The corresponding Jacobian factor is:

$
  J_(k,k')(va(kt)_k,va(u))
  = abs(
    det(
      partial (va(kt)_(k'),va(u)')
      / partial (va(kt)_k,va(u))
    )
  )
$

Accept the proposed state $(k',va(kt)_(k'))$ with probability:

$
  ka((k,va(kt)_k), (k',va(kt)_(k')))
  = min(
    1,
    (pi(k', va(kt)_(k')|D) r(k|k')
    q_(k',k)(va(u)'|va(kt)_(k')))
    /(pi(k, va(kt)_k|D) r(k'|k)
    q_(k,k')(va(u)|va(kt)_k))
    J_(k,k')(va(kt)_k,va(u))
  )
$

The posterior's normalizing constant cancels from this ratio. If the proposal is
rejected, retain $(k,va(kt)_k)$. With the remaining probability
$1-sum_(k' != k) r(k'|k)$, apply $K_k$ to update the parameters within the
current model. Together, these updates preserve $pi(k, va(kt)_k|D)$ as the
stationary distribution.

#bibliography("main.bib")
