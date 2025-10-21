#import "@preview/mitex:0.2.5": mi, mitex
#import "@preview/showybox:2.0.4": showybox
#import "@preview/physica:0.9.6": *
#import "@preview/cuti:0.3.0": show-cn-fakebold
#import "@preview/mannot:0.3.0": *

#import "./paragraph.typ": *
#import "./table.typ": *
#import "./list.typ": *

#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

#let boxed = markrect.with(outset: (x: 0.3em, y: 0.3em))
// #let delta(x) = $Delta#x$
// #let pi = markhl.with(color: yellow)
// #let pj = markhl.with(color: red)

#let Blue(it) = {
  text(fill: blue)[*#it*]
}

#let rm-bracket(it) = {
  show "{": ""
  show "}": ""
  it
}

#let beamer-block(value) = {
  let margin = -0.6em
  v(margin)
  block(fill: luma(240), inset: 0.6em, stroke: (left: 0.25em))[#value]
  v(margin)
}

#let set-supplement(it) = {
  it
}

#let num-include-chapter(num) = {
  numbering("1.1", counter(heading).get().first(), num)
}

#let ref-zh(it) = {
  let el = it.element
  let eq = math.equation
  let obj
  let count
  let head = counter(heading).get().first()

  // el.fields()
  // el.kind == image
  if el != none {
    if el.func() == eq {
      count = counter(eq).at(el.location())
    } else if el.kind == image {
      count = counter(figure.where(kind: image)).at(el.location())
    } else if el.kind == table {
      count = counter(figure.where(kind: table)).at(el.location())
    } else if el.kind == raw {
      count = counter(figure.where(kind: raw)).at(el.location())
    }
    // numbering("1.1", head, count)
    link(el.location(), numbering("1", ..count))
  } else {
    it
  }
}

#let btext(x, color: red, bg: rgb("fffd11a1")) = {
  highlight(fill: bg)[
    #text(x, fill: color)
  ]
}

#let set-figure(body) = {
  set figure(numbering: it => strong[#numbering("1.1", it)])
  set figure.caption(separator: ". ")
  // set figure(numbering: it => strong[#numbering("1.1", it)])
  set figure(numbering: num => numbering("1", num))
  // set figure(numbering: num => numbering("1.1", counter(heading).get().first(), num))
  show figure.caption: it => {
    set text(size: 12pt)
    set par(spacing: 0.9em, leading: 0.8em)
    it
  }
  
  show figure.where(kind: image): set figure(supplement: text("图", weight: "bold"))
  show figure.where(kind: table): set figure(supplement: text("表", weight: "bold"))
  show figure.where(kind: table): set figure.caption(position: top)
  body
}


#let template(doc, size: (heading: 13pt, text: 13pt, math: 11pt), 
  pagenum: true, footer: "", header: "") = {
  
  let text_size = if type(size) == "dictionary" { size.text } else { size }
  let math_size = if type(size) == "dictionary" { size.math } else { size_math }
  
  set text(size: text_size) // font: ("Microsoft YaHei")
  set list(indent: 1em)

  set par(spacing: 1.24em + 0.2em, leading: 1.24em)
  set par(justify: true)

  show math.equation: rm-bracket
  show math.equation: set text(size: math_size)
  show math.equation.where(block: true): set par(spacing: 0.7em, leading: 0.8em)
  set math.equation(numbering: "(1)")
  // numbering("(1.1)", counter(heading).get().first(), num)

  set underline(offset: 2pt)
  show: set-table
  show: set-figure
  // set heading(numbering: "1.1")
  // 代码
  show: codly-init.with()
  codly(stroke: 1pt + blue)
  codly(display-icon: true)
  codly(languages: codly-languages)

  show ref: ref-zh // 引用

  // // https://github.com/typst/typst/issues/1896
  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    it
  }
  show heading: it => set-heading(it, size: text_size)
  show: show-cn-fakebold

  // 链接
  show link: underline
  show link: set text(fill: rgb(0, 0, 255))

  // 代码
  show raw: set text(font: ("consolas", "Microsoft Yahei", "SimSun"), size: 10pt)

  show regex("==(\w+)=="): x => {
    // let txt = x.fields().text // content object
    let txt = x.text
    txt = txt.replace("==", "")
    btext(txt)
  }

  // 页眉页脚
  // footer
  if pagenum {
    set page(
      footer: context [
        #text(footer, weight: "bold")
        #h(1fr)
        #counter(page).display("1/1", both: true)
      ],
      header: align(right)[#text(header, weight: "bold")],
      numbering: "1",
    )
    doc
  } else {
    doc
  }
}

#let nonum(eq) = math.equation(block: true, numbering: none, eq)

#let box-blue(it) = {
  showybox(
    it,
    frame: (
      // title-color: red.darken(30%),
      border-color: blue.darken(30%),
      body-color: blue.lighten(95%),
    ),
    // title: [*比热容*]
  )
}

#let box-red(it) = {
  showybox(
    it,
    frame: (
      // title-color: red.darken(30%),
      border-color: red.darken(30%),
      body-color: red.lighten(95%),
    ),
    // title: [*比热容*]
  )
}

#let box-green(it) = {
  showybox(
    it,
    frame: (
      // title-color: red.darken(30%),
      border-color: green.darken(30%),
      body-color: green.lighten(95%),
    ),
    // title: [*比热容*]
  )
}
