#{
  html.html({
    html.head({
      html.title("Adamanteye's Blog")
      html.meta(
        name: "description",
        content: "",
      )
      include "meta.typ"
      html.link(rel: "stylesheet", href: "./common.css")
      html.link(rel: "stylesheet", href: "./index.css")
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
