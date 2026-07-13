#let home = link(
  "../../../",
)[Home]

#let site = "https://blog.adamanteye.cc"
#let source-path = sys.inputs.at("src", default: none)
#let canonical = if source-path == none {
  site + "/"
} else {
  // Strip the leading "src/" (4 chars) and trailing "index.typ" (9 chars).
  site + "/" + source-path.slice(4, source-path.len() - 9)
}

#let source = if source-path == none {
  "https://github.com/adamanteye/blog"
} else {
  "https://github.com/adamanteye/blog/blob/master/" + source-path
}
#let source = link(
  source,
)[Source]

#import "meta.typ": footer
#import "@preview/physica:0.9.8": *
#import "@preview/unify:0.8.1": *
#import "@preview/lilaq:0.6.0" as lq
#import "@preview/finite:0.5.1" as finite: automaton

#let isotope(element, a: none, z: none) = {
  let a-content = if type(a) == int { [#a] } else { a }
  let z-content = if type(z) == int { [#z] } else { z }
  math.attach(math.op(element), tl: a-content, bl: z-content)
}

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
#let hbar = $planck$
#let ol = it => $overline(it)$
#let istp = isotope
#let chem = it => math.op(it)
#let cps = $compose$
#let ts = tensor
#let mac = it => $macron(it)$

#let etc(start, end, sym) = $sym_start, sym_2, ..., sym_end$

#let mmev = $unit("MeV/c^2", per: "\\/")$
#let pmev = $unit("MeV/c", per: "\\/")$
#let u235 = $isotope("U", a: 235)$
#let canvas(it) = context {
  set align(center)
  if target() == "html" { html.frame(it) } else { it }
}
#let html-image(it) = {
  let fields = it.fields()
  let alt = fields.at("alt")
  html.img(
    src: it.source,
    alt: if alt == none { "" } else { alt },
    loading: "lazy",
    decoding: "async",
  )
}
#let giscus = (
  repo: "adamanteye/blog",
  repo-id: "R_kgDONil4tA",
  category: "General",
  category-id: "DIC_kwDONil4tM4DAqQh",
)
#let comments = {
  if giscus.category-id != "" {
    html.elem("section", attrs: (class: "comments"))[
      #html.elem("script", attrs: (
        src: "https://giscus.app/client.js",
        "data-repo": giscus.repo,
        "data-repo-id": giscus.repo-id,
        "data-category": giscus.category,
        "data-category-id": giscus.category-id,
        "data-mapping": "pathname",
        "data-strict": "1",
        "data-reactions-enabled": "1",
        "data-emit-metadata": "0",
        "data-input-position": "top",
        "data-theme": "noborder_light",
        "data-lang": "en",
        crossorigin: "anonymous",
        async: "",
      ))
    ]
  }
}
#let conf(
  title: str,
  desc: str,
  slide: false,
  doc,
) = context {
  show figure.where(kind: table): set block(breakable: true)
  set bibliography(style: "/styles/aps-with-doi.csl")
  show bibliography: set text(lang: "en")
  show: hep
  set heading(numbering: "1.")
  set math.equation(numbering: "(1)")
  show: lq.set-diagram(width: 6cm, height: 6cm)
  if target() == "html" {
    show image: html-image
    html.html({
      html.head({
        include "meta.typ"
        html.title()[#title]
        html.meta(
          name: "description",
          content: desc,
        )
        html.link(rel: "canonical", href: canonical)
        html.link(rel: "stylesheet", href: "../../../common.css")
      })
      html.body({
        html.header({
          html.h1(class: "header")[#title]
          html.nav([
            #home
            \/
            #source
            \/
            #link(
              "index.pdf",
            )[Print]
            #if slide [
              \/
              #link(
                "main.pdf",
              )[Slide]
            ]

            #desc
          ])
        })
        html.main({
          html.article({
            doc
          })
          comments
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
    set page(numbering: "1", paper: "a4", margin: (y: 1cm, x: 1cm))
    set table(stroke: none)
    show table: set text(size: 0.9em)
    set image(width: 90%)
    set grid(column-gutter: 1em, row-gutter: 1em)
    set text(
      font: (
        (name: "Libertinus Serif", covers: "latin-in-cjk"),
        "Source Han Serif",
      ),
      size: 12pt,
    )
    show math.equation: set text(font: "TeX Gyre Pagella Math")
    show link: it => underline(text(fill: rgb("b91c1c"), it))
    show ref: it => text(fill: rgb("b91c1c"), it)
    set par(leading: 1em)
    set par(spacing: 1.5em, justify: true)
    show heading: set block(below: 1.5em)
    set document(title: title)
    align(center, text(1.4em)[
      *#title*
    ])
    [#desc]
    line(length: 100%)
    doc
  }
}
