#let cell-text(x) = {
  if type(x) == str {
    x
  } else {
    let fields = x.fields()
    if "text" in fields {
      fields.text
    } else {
      fields.at("children", default: ()).map(cell-text).join()
    }
  }
}

#let bar-number(x) = float(cell-text(x).replace("−", "-"))

#let bar-cell(
  x,
  max: 1,
  side: "one",
  colors: (pos: rgb("#c8e6c9"), neg: rgb("#ffcdd2")),
) = {
  let value = bar-number(x)
  let positive = value >= 0
  let ratio = calc.min(calc.abs(value) / max, 1)
  let two = side == "two"
  let width = ratio * if two { 50% } else { 100% }
  let align = if two and not positive { right } else { left }
  let dx = if two { if positive { 50% } else { -50% } } else { 0% }
  
  table.cell(inset: 0pt)[
    #block(width: 95%, height: 1.2em)[
      #place(align + horizon, dx: dx, rect(
        width: width,
        height: 96%,
        fill: if positive { colors.pos } else { colors.neg },
      ))
      #if side == "two" {
        place(left + horizon, dx: 50%, rect(
          width: 0.5pt,
          height: 100%,
          fill: gray,
        ))
      }
      #place(center + horizon, text(size: 11pt)[#x])
    ]
  ]
}

#let table-bar(
  columns: (auto,),
  bar: (),
  max: none,
  side: "one",
  colors: (pos: rgb("#c8e6c9"), neg: rgb("#ffcdd2")),
  ..args,
) = {
  let ncols = if type(columns) == int { columns } else { columns.len() }
  let data = args.pos()
  let has-header = data.len() > 0 and type(data.first()) == content and data.first().func() == table.header
  let offset = if has-header { 1 } else { ncols }
  let prefix = data.slice(0, offset)
  let data = data.slice(offset)
  
  let column-max(col) = {
    let values = data.slice(col - 1).chunks(ncols)
    calc.max(..values.map(row => calc.abs(bar-number(row.first()))))
  }
  let bar = bar.map(spec => {
    let fallback = if max == none { column-max(spec.column) } else { max }
    (
      column: spec.column,
      max: spec.at("max", default: fallback),
    )
  })
  let cells = data
    .enumerate()
    .map(((i, cell)) => {
      let col = calc.rem(i, ncols) + 1
      let spec = bar.find(spec => spec.column == col)
      if spec == none {
        cell
      } else {
        bar-cell(
          cell,
          max: spec.max,
          side: side,
          colors: colors,
        )
      }
    })
  table(columns: columns, ..args.named(), ..prefix, ..cells)
}
