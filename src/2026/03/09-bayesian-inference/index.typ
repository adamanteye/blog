#import "/page.typ": *
#import "meta.typ": desc, title
#show: conf.with(title: title, desc: desc)

#import "@preview/exercise-bank:0.4.0": exo, exo-setup

= Bayes Theorem

Bayes theorem:
$ p(kt|y)=(p(y|kt)p(kt))/p(y)prop p(y|kt)p(kt) $

Prior predictive distribution:
$ p(y)=int_kT (y|kt)p(kt) dd(kt) $

Posterior predictive distribution:
$
  p(tilde(y)|y) & =int_kT p(tilde(y),kt|y)dd(kt) \
                & =int_kT p(tilde(y)|kt,y) p(kt|y) dd(kt) \
                & =int_kT p(tilde(y)|kt) p(kt|y) dd(kt) \
$

= Fundamental Distributions

#let phi = $phi.alt$

#figure(
  table(
    columns: 5,
    table.header([Name], [PDF/PMF], [Mean], [Variance], [Mode]),
    [$"Beta" (y|alpha,beta)$],
    [$Gamma(alpha+beta)/(Gamma(alpha)Gamma(beta)) y^(alpha-1) (1-y)^(beta-1)$],
    [$alpha/(alpha+beta)$],
    [$(alpha beta)/((alpha+beta)^2(alpha+beta+1))$],
    [$(alpha-1)/(alpha+beta-2)$],

    [$"Binomial" (y|n,p)$],
    [$binom(n, y)p^y (1-p)^(n-y)$],
    [$n p$],
    [$n p(1-p)$],
    [],

    [$"Exponential" (y|lambda)$],
    [$lambda e^(-lambda x) = "Gamma"(y|1,lambda)$],
    [$1/lambda$],
    [$(ln 2)/lambda$],
    [$0$],

    [$"Gamma" (y|alpha,beta)$],
    [$beta^alpha /Gamma(alpha) y^(alpha-1) e^(-beta y)$],
    [$alpha/beta$],
    [$alpha/beta^2$],
    [$(alpha-1)/beta$],

    [$"InvGamma" (y|alpha,beta)$],
    [$beta^alpha /Gamma(alpha) y^(-alpha-1) e^(-beta\/y)$],
    [$kb/(ka-1)$],
    [$kb^2/((ka-1)^2(ka-2))$],
    [$kb/(ka-1)$],

    [$"LogNormal" (y|ka,kb)$],
    [$1/(y ks sqrt(2 pi)) exp(-(ln y-mu)^2/(2 ks^2))$],
    [$exp(mu+ks^2/2)$],
    [$(exp(ks^2)-1)exp(2mu+ks^2)$],
    [$exp(mu-ks^2)$],

    [$"Possion" (y|kl)$], [$(kl^y e^(-kl))/(y!)$], [$kl$], [$kl$], [],

    [$"NegBinomial" (k|r,p)$],
    [$binom(k+r-1, k)(1-p)^k p^r$],
    [$(r(1-p))/p$],
    [$(r(1-p))/p^2$],
    [],

    [$"Normal" (y|mu,sigma^2)$],
    [$1/(sqrt(2pi)sigma) exp(-(y-mu)^2/(2sigma^2))$],
    [$mu$],
    [$sigma^2$],
    [$mu$],

    [$"Uniform" (y|a,b)$], [$1/(b-a)$], [$(a+b)/2$], [$(b-a)^2/12$], [],
  ),
  caption: [Fundamental Distributions],
)

= Functions

== Beta Function

$ B(z_1,z_2)=int_0^1 t^(z_1-1) (1-t)^(z_2-1) dd(t) $

Properties:
- $B(z_1,z_2)=B(z_2,z_1)$
- $B(z_1,z_2)=(kG(z_1)kG(z_2))/kG(z_1+z_2)$
- $B(m,n)=((m-1)!(n-1)!)/(m+n-1)! =(m+n)/(m n)\/binom(m+n, m)$

= Conjugate Prior
The idea of *conjugate prior* is that for a give likelihood we choose a prior
distribution such that, after observing data and applying Bayes' theorem, the
posterior distribution belongs to the same family as the prior.

That is, if $p(theta)$ and $p(theta | y)$ have the same distributional form,
then the prior is called a *conjugate prior* for the likelihood model.

This is useful because it makes Bayesian updating analytically tractable.
Instead of performing difficult integration or numerical approximation, we can
often derive the posterior parameters in closed form.

= Conjugate Prior for Exponential Families
Note general exponential family:

$
  p(y_i|theta)=markhl(f(y_i), tag: #<base>, color: #blue) exp(
    markhl(phi(theta)^TT, color: #red, tag: #<model>) markhl(u(y_i), tag: #<data>)
    -markhl(g(theta), color: #gray, tag: #<norm>)
  )
  #annot(<base>, pos: top + left)[base measure]
  #annot(<model>, pos: bottom + left)[natural parameter]
  #annot(<data>, pos: top + right)[sufficient statistic]
  #annot(<norm>, pos: bottom + right)[log normalizer]
$

Likelihood of a sequence of i.i.d.samples:

$
  p(y|theta)=markhl(product_(i=1)^n (f(y_i)), color: #blue) exp(
    markhl(phi(theta)^TT, color: #red,) markhl(sum_(i=1)^n u(y_i), tag: #<data2>)
    -markhl(n g(theta), color: #gray)
  )
  #annot(<data2>, pos: top)[$t(y)=sum_(i=1)^n u(y_i)$]
$

So conjugate prior for that likelihood is
$ p(theta)prop exp(phi(theta)^TT nu-n_0 g(theta)) $

Posterior is
$ p(theta|y)prop exp(phi(theta)^TT (nu+t(y))-(n_0+n) g(theta)) $

= Proper and Improper Prior Distributions
A prior is called *proper* if it is a valid probability distribution:
$
  p(theta)>=0, forall theta in Theta, integral_(theta in Theta) p(theta) dd(theta) =1
$

And *improper* if
$
  p(theta)>=0, forall theta in Theta, integral_(theta in Theta) p(theta) dd(theta) =infinity
$

- If a prior is proper, so must the posterior.
- If a prior is improper, the posterior could be proper or improper.

In theory, all priors are acceptable, as long as the posterior is proper.

= Linear Algebra

== Convex Combination

A subset $A$ of a vector space $V$ is said to be convex if
$kl va(x)+(1-kl) va(y)$ for all vectors $va(x),va(y) in A$, and all scalars $kl$
in $[0,1]$.

Via induction, this can be seen to be equivalent to the requirement that
$etc(1, n, kl va(x)) in A$ for all vectors $etc(1, n, va(x))in A$, and for all
scalars $etc(1, n, kl)>=0$ such that $sum k_i=1$.
