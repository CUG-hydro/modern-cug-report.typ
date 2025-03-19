#let font = (
  四号: 14pt, 
  小四: 12pt, 
  五号: 10.5pt
)

#let p-compact(it, spacing: 1.24em, leading: 1em) = {
  // leading: 行距; spacing: 段距
  set par(spacing: spacing, leading: leading)
  it
}

#let set-heading(it, size:font.四号, fake-par: false, margin: 0.15em) = {
  // https://github.com/typst/typst/issues/1896
  // https://github.com/shuosc/SHU-Bachelor-Thesis-Typst/issues/12
  show heading: it => {
    // v(margin)
    it
    // v(margin)
  }

  show heading.where(level: 1): it => {
    // set text(size: 14pt, fill: blue, weight: "regular") 
    set text(size: 14pt, fill: blue) 
    // counter(math.equation).update(0)
    // counter(figure.where(kind: image)).update(0)
    // counter(figure.where(kind: table)).update(0)
    // counter(figure.where(kind: raw)).update(0)
    // // h(2em)
    // it.fields()
    v(0.25em)
    // h(2em)
    // it.body
    it
    // v(0.25em)// it
  }

  show heading.where(level: 2): it => {
    // h(2em)
    it
    v(-0.1em)
  }

  show heading.where(level: 3): it => {
    // set text(fill: blue, size:14pt)
    it
    v(-0.1em)
    // v(0.25em)
  }

  show heading.where(level: 4): it => {
    it
    v(0.25em)
  }

  show heading.where(level: 5): it => {
    it
    v(0.25em)
  }
  it
}
