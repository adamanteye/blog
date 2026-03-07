#import "/page.typ": *
#import "meta.typ": desc, title
#show: conf.with(title: title, desc: desc)

= Probabilistic Programming Languages

PyMC@abril-pla_pymc_2023 is a probabilistic programing language (PPL) with rich
history and wide usage. It has implemented general-purpose algorithms including
Metropolis-Hastings sampler, Hamiltonian Monte Carlo and No-U-Turn-Sampler.

PPL can reduce the great burden of computing manually. The best introduction to
PyMC that I found is their paper@abril-pla_pymc_2023.

#bibliography("main.bib")
