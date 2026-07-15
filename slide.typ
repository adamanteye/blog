#import "page.typ": *
#import "@preview/touying:0.7.4": *
#import themes.university: *
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
  show link: it => underline(text(fill: olive.lighten(20%), it))
  show heading: set block(below: 1.5em)
  set grid(column-gutter: 2em)
  show: university-theme.with(
    config-info(
      title: title,
      subtitle: desc,
      date: datetime.today(),
      author: "Xuelin Yang",
      institution: "Tsinghua University",
    ),
    config-colors(
      primary: black.lighten(40%),
      secondary: blue.lighten(40%),
      tertiary: olive.lighten(10%),
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
