#import "@preview/showybox:2.0.4": showybox


#let nonum(eq) = math.equation(block: true, numbering: none, eq)

#let mybox(it, color, width: auto) = {
  context {
    showybox(
      it,
      frame: (
        // title-color: red.darken(30%),
        inset: (x: 0.4em, y: 0.55em),
        border-color: color.darken(30%),
        body-color: color.lighten(95%),
      ),
      width: width,
      // title: [*比热容*]
    )
    v(-0.2em)
  }
}

#let box-blue(it, width: auto) = mybox(it, blue, width: width)

#let box-green(it, width: auto) = mybox(it, green, width: width)

#let box-red(it, width: auto) = mybox(it, red, width: width)

#let beamer-block(value, color: black.lighten(10%)) = {
  let margin = -0.4em
  v(margin)

  let mar = 0.25em
  pad(left: mar)[
    #block(fill: luma(240), inset: (x: 0.4em, y: 0.6em), outset: 0em, stroke: (left: mar + color))[#value]
  ]

  v(margin)
}
