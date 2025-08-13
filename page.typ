#let conf(
  title: str,
  desc: str,
  doc,
) = {
  html.html({
    html.head({
      html.title(title)
      html.meta(name: "description", content: desc)
      html.meta(charset: "utf-8")
      html.meta(name: "viewport", content: "width=device-width, initial-scale=1.0")
    })
    html.main({
      doc
    })
  })
}
