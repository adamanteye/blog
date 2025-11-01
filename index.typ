#{
  html.html({
    html.head({
      html.title("adamanteye's blog")
      html.meta(
        name: "description",
        content: "a blog about technology and life",
      )
      html.meta(charset: "utf-8")
      html.meta(
        name: "viewport",
        content: "width=device-width, initial-scale=1.0",
      )
      html.link(rel: "stylesheet", href: "../common.css")
      html.link(rel: "stylesheet", href: "../index.css")
    })
    html.body({
      html.header({ include "header.typ" })
      html.main({
        html.nav({ include "src/nav.typ" })
      })
      html.footer({ include "footer.typ" })
    })
  })
}
