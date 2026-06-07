#import "page.typ": *
#import "@preview/touying:0.7.4": *
#import themes.university: *
#let conf(
  title: str,
  desc: str,
  doc,
) = context {
  show figure.where(kind: table): set block(breakable: true)
  show: hep
  set math.equation(numbering: "(1)")
  set text(font: (
    (name: "Libertinus Serif", covers: "latin-in-cjk"),
    "Source Han Serif SC",
  ))
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
    config-methods(cover: utils.semi-transparent-cover),
  )
  set text(size: 17pt, font: (
    (name: "Libertinus Serif", covers: "latin-in-cjk"),
    "Source Han Serif",
  ))
  show math.equation: set text(font: "TeX Gyre Pagella Math")
  title-slide()
  doc
}
