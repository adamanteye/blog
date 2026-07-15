#import "page.typ": *
#import "@preview/touying:0.7.4": *
#import "@preview/numbly:0.1.0": numbly
#import themes.dewdrop: *
#let conf(
  title: str,
  desc: str,
  bib: none,
  doc,
) = context {
  show figure.where(kind: table): set block(breakable: true)
  set table(stroke: none)
  show table: set text(size: 0.9em)
  show: hep
  set math.equation(numbering: "(1)")
  set heading(numbering: numbly("{1}.", default: "1.1"))
  set grid(gutter: 2em)
  show: dewdrop-theme.with(
    navigation: none,
    config-info(
      title: title,
      subtitle: desc,
      date: datetime.today(),
      author: "Xuelin Yang",
      institution: "Tsinghua University",
    ),
    config-colors(
      neutral: rgb("7f7f89"),
      primary: rgb("0033a0"),
      secondary: rgb("61c5d3"),
      tertiary: rgb("e15e32"),
    ),
    config-methods(cover: utils.alpha-changing-cover.with(alpha: 15%)),
    config-common(show-bibliography-as-footnote: bib),
  )
  set text(size: 17pt, font: (
    (name: "Libertinus Serif", covers: "latin-in-cjk"),
    "Source Han Serif",
  ))
  show math.equation: set text(font: "TeX Gyre Pagella Math")
  title-slide()
  doc
}
