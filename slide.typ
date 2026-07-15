#import "page.typ": *
#import "@preview/touying:0.7.4": *
#import "@preview/numbly:0.1.0": numbly
#import themes.dewdrop: *

#let cern-neutral = rgb("7f7f89")
#let cern-primary = rgb("0033a0")
#let cern-secondary = rgb("61c5d3")
#let cern-tertiary = rgb("e15e32")

#let cern-background = rgb("f2f2f3")
#let cern-foreground = rgb("2f2f2f")
#let cern-border = rgb("bebec8")

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
      neutral: cern-neutral,
      primary: cern-primary,
      secondary: cern-secondary,
      tertiary: cern-tertiary,
    ),
    config-methods(
      cover: utils.alpha-changing-cover.with(alpha: 15%),
    ),
    config-common(
      show-bibliography-as-footnote: bib,
    ),
  )

  show heading.where(level: 1): set text(
    fill: cern-primary,
  )
  show heading.where(level: 2): set text(
    fill: cern-primary.darken(15%),
  )
  show heading.where(level: 3): set text(
    fill: cern-secondary.darken(35%),
  )

  set list(
    marker: (
      text(fill: cern-primary)[•],
      text(fill: cern-secondary.darken(20%))[‣],
      text(fill: cern-tertiary)[–],
    ),
  )

  show link: set text(fill: cern-primary)
  show ref: set text(fill: cern-primary)
  show strong: set text(fill: cern-tertiary.darken(10%))

  show quote: set block(
    fill: cern-primary.lighten(92%),
    stroke: cern-primary.lighten(55%),
  )

  show raw.where(block: false): set text(
    fill: cern-primary.darken(25%),
  )
  show raw.where(block: true): set block(
    fill: cern-neutral.lighten(88%),
    stroke: cern-border,
  )

  show figure.caption: set text(
    fill: cern-neutral.darken(20%),
  )

  set text(
    size: 15pt,
    fill: cern-foreground,
    font: (
      (name: "Libertinus Serif", covers: "latin-in-cjk"),
      "Source Han Serif",
    ),
  )

  show math.equation: set text(
    font: "TeX Gyre Pagella Math",
  )

  title-slide()
  doc
}
