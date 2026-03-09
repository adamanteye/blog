#import "/page.typ": *
#import "meta.typ": desc, title
#show: conf.with(title: title, desc: desc)

= Week 3

== Fundamental Distributions

=== Beta
$
  p(y|alpha,beta)=Gamma(alpha+beta)/(Gamma(alpha) Gamma(beta)) y^(alpha-1) (1-y)^(beta-1)
$

=== Binomial
$ p(y|theta)=binom(n, y)theta^y (1-theta)^(n-y) $

=== Exponential
$ p(y|lambda)=lambda e^(-lambda x) = "Gamma"(y|1,lambda) $

=== Gamma
$ p(y|alpha,beta)=beta^alpha /Gamma(alpha) y^(alpha-1) e^(-beta x) $

=== Possion
$ p(y|theta)=(theta^y e^(-theta))/(y!) $

== Conjugate Prior
The idea of *conjugate prior* is that we choose a prior distribution such that,
after observing data and applying Bayes' theorem, the posterior distribution
belongs to the same family as the prior.

That is, if $p(theta)$ and $p(theta | y)$ have the same distributional form,
then the prior is called a *conjugate prior* for the likelihood model.

This is useful because it makes Bayesian updating analytically tractable.
Instead of performing difficult integration or numerical approximation, we can
often derive the posterior parameters in closed form.

== Problem 1 Conjugate Prior
