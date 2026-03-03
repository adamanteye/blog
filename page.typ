#let home = link(
  "../../../",
)[Home]

#let source = link(
  "https://github.com/adamanteye/blog",
)[Source]

#import "meta.typ": footer
#import "@preview/physica:0.9.8": *
#import "@preview/unify:0.7.1": *
#let mmev = $unit("MeV/c^2", per: "\\/")$
#let pmev = $unit("MeV/c", per: "\\/")$
#let mev = $unit("MeV")$
#let kev = $unit("keV")$
#let cm = $unit("cm")$

#let conf(
  title: str,
  desc: str,
  doc,
) = context {
  set image(width: 90%)
  set bibliography(style: "american-physics-society")
  show bibliography: set text(lang: "en")
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
    set document(title: title)
    align(center, text(1.4em)[
      *#title*
    ])
    [#desc]
    line(length: 100%)
    doc
  }
}
