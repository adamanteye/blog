#{
  html.html({
    html.head({
      html.title("Adamanteye's Blog")
      html.meta(
        name: "description",
        content: "",
      )
      html.meta(charset: "utf-8")
      html.meta(
        name: "viewport",
        content: "width=device-width, initial-scale=1.0",
      )
      html.link(rel: "stylesheet", href: "./common.css")
      html.link(rel: "stylesheet", href: "./index.css")
      html.link(rel: "icon", type: "image/webp", href: "./favicon.webp")
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
