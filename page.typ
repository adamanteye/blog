#let home = link(
  "../../../",
)[Home]

#let source = link(
  "https://github.com/adamanteye/blog",
)[Source]

#import "meta.typ": footer
#import "@preview/physica:0.9.8": *
#import "@preview/unify:0.7.1": *
#import "@preview/lilaq:0.6.0" as lq
#import "@preview/mannot:0.3.2": *

#let hep = it => {
  show lq.selector(lq.diagram): set text(0.85em)
  show: lq.set-diagram(
    fill: none,
    xaxis: (
      subticks: 4,
      mirror: (ticks: true, tick-labels: false),
    ),
    yaxis: (
      subticks: 4,
      mirror: (ticks: true, tick-labels: false),
    ),
  )
  show: lq.set-grid(stroke: none)
  show: lq.set-spine(stroke: black + 0.8pt)
  show: lq.set-tick(
    stroke: black + 0.8pt,
    inset: 4pt,
    outset: 0pt,
    pad: 0.35em,
    shorten-sub: 45%,
  )
  show: lq.set-legend(
    stroke: none,
    fill: none,
    radius: 0pt,
    pad: 0.3em,
  )
  it
}

#let ka = $alpha$
#let kt = $theta$
#let kT = $Theta$
#let kb = $beta$
#let kd = $delta$
#let kD = $Delta$
#let ke = $epsilon$
#let kE = $Epsilon$
#let kg = $gamma$
#let kG = $Gamma$
#let kl = $lambda$
#let kL = $Lambda$
#let ks = $sigma$
#let kS = $Sigma$
#let ko = $omega$
#let kO = $Omega$
#let int = $integral$
#let inft = $infinity$
#let ol = it => $overline(it)$
#let istp = it => $isotope(it)$
#let cps = $compose$
#let diff = it => $difference(it)$

#let etc(start, end, sym) = $sym_start, sym_2, ..., sym_end$

#let mmev = $unit("MeV/c^2", per: "\\/")$
#let pmev = $unit("MeV/c", per: "\\/")$
#let u235 = $isotope("U", a: 235)$
#let canvas(it) = context {
  if target() == "html" { html.frame(it) } else { it }
}
#let conf(
  title: str,
  desc: str,
  doc,
) = context {
  show figure.where(kind: table): set block(breakable: true)
  set image(width: 90%)
  show bibliography: set text(lang: "en")
  show: hep
  show: lq.set-diagram(width: 6cm, height: 6cm)
  if target() == "html" {
    html.html({
      html.head({
        include "meta.typ"
        html.title()[#title]
        html.meta(
          name: "description",
          content: desc,
        )
        html.link(rel: "stylesheet", href: "../../../common.css")
      })
      html.body({
        html.header({
          html.h1(class: "header")[#title]
          html.nav([
            #home
            \/
            #source

            #desc
          ])
        })
        html.main({
          html.article({
            show math.equation: html.frame
            show math.equation.where(block: false): box
            doc
          })
        })
        html.footer({
          html.nav([
            #home
            \/
            #source
            \/
            #link(
              "mailto:xuelin@adamanteye.cc",
            )[Email]
            \/
            #link(
              "../../../atom.xml",
            )[Feed]
          ])

          footer
        })
      })
    })
  } else {
    show link: it => underline(text(fill: olive.lighten(20%), it))
    set document(title: title)
    align(center, text(1.4em)[
      *#title*
    ])
    [#desc]
    line(length: 100%)
    doc
  }
}
