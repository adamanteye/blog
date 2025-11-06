#let conf(
  title: str,
  desc: str,
  doc,
) = {
  html.html({
    html.head({
      html.title(title + " - adamanteye")
      html.meta(
        name: "description",
        content: desc,
      )
      include "meta.typ"
      html.link(rel: "stylesheet", href: "../common.css")
      html.link(rel: "stylesheet", href: "../page.css")
    })
    html.body({
      html.header({ include "header.typ" })
      html.main({
        html.nav({ include "src/nav-side.typ" })
        html.article({
          html.h1(title)
          doc
        })
      })
      html.footer({ include "footer.typ" })
    })
  })
}
