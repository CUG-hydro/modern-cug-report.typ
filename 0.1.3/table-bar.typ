#let cell-body(x) = if type(x) == content and x.func() == table.cell { x.body } else { x }

#let cell-text(x) = {
  let x = cell-body(x)
  if type(x) == str {
    x
  } else {
    let fields = x.fields()
    if "text" in fields {
      fields.text
    } else if "body" in fields {
      cell-text(fields.body)
    } else {
      fields.at("children", default: ()).map(cell-text).join()
    }
  }
}

#let bar-number(x) = float(cell-text(x).replace("−", "-"))

#let bar-cell(
  x,
  min: 0,
  max: 1,
  side: "one",
  colors: (pos: rgb("#c8e6c9"), neg: rgb("#ffcdd2")),
) = {
  let x = cell-body(x)
  let value = bar-number(x)
  let two = side == "two"
  let origin = if two { (min + max) / 2 } else { min }
  let positive = value >= origin
  let distance = if two { calc.abs(value - origin) } else { value - origin }
  let span = if two { (max - min) / 2 } else { max - min }
  let ratio = if span == 0 {
    0
  } else {
    calc.max(0, calc.min(distance / span, 1))
  }
  let ratio = if value == origin { 0 } else { calc.max(ratio, 0.02) }
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
  bar: none,
  min: none,
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
  
  let is-line(cell) = type(cell) == content and cell.func() in (table.hline, table.vline)
  let values = data.filter(cell => not is-line(cell))
  let column-max(col) = {
    let values = values.slice(col - 1).chunks(ncols)
    calc.max(..values.map(row => calc.abs(bar-number(row.first()))))
  }
  let bar = if bar == none { () } else { bar }
  let bar = bar.map(spec => {
    let upper = spec.at(
      "max",
      default: if max == none { column-max(spec.column) } else { max },
    )
    let lower = spec.at(
      "min",
      default: if min != none { min } else if side == "two" { -upper } else { 0 },
    )
    (column: spec.column, min: lower, max: upper)
  })
  let cells = data.enumerate().map(((i, cell)) => {
    if is-line(cell) {
      cell
    } else {
      let i = data.slice(0, i).filter(cell => not is-line(cell)).len()
      let col = calc.rem(i, ncols) + 1
      let spec = bar.find(spec => spec.column == col)
      if spec == none {
        cell
      } else {
        bar-cell(
          cell,
          min: spec.min,
          max: spec.max,
          side: side,
          colors: colors,
        )
      }
    }
  })
  table(columns: columns, ..args.named(), ..prefix, ..cells)
}
