#let conf(
  title: str,
  desc: str,
  doc,
) = {
  html.html({
    html.head({
      html.title(title + " - adamanteye")
      html.meta(name: "description", content: desc)
      html.meta(charset: "utf-8")
      html.meta(
        name: "viewport",
        content: "width=device-width, initial-scale=1.0",
      )
      html.link(rel: "stylesheet", href: "../page.css")
      html.link(rel: "stylesheet", href: "../common.css")
      html.link(rel: "icon", type: "image/webp", href: "/favicon.webp")
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
