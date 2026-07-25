#import "./table-bar.typ": table-bar, bar-number

#let fixed-number(x, digits: 3, signed: false) = {
  let x = calc.round(x, digits: digits)
  let parts = str(calc.abs(x)).split(".")
  let frac = parts.at(1, default: "")
  let zeros = range(digits - frac.len()).map(_ => "0").join()
  let sign = if x < 0 { "−" } else if signed and x > 0 { "+" } else { "" }
  sign + parts.first() + "." + frac + zeros
}

#let repeat-header(stroke: 0.8pt, repeat: true, ..cells) = table.header(
  repeat: repeat,
  ..cells.pos().map(cell => table.cell(stroke: (bottom: stroke), strong(cell))),
)


#let wrap-table(
  body,
  caption: [],
  summary-fn: none,
  summary-label: none,
  table-fn: table-bar,
  ..args,
) = {
  let fields = body.fields()
  let cells = fields.remove("children")
  let columns = fields.at("columns", default: (auto,))
  let ncols = if type(columns) == int { columns } else { columns.len() }
  if cells.len() > 0 and cells.first().func() != table.header {
    let header = cells.slice(0, ncols).map(cell => cell.body)
    cells = (repeat-header(..header),) + cells.slice(ncols)
  }
  if summary-fn != none {
    assert(summary-fn in ("mean", "sum"), message: "summary-fn must be mean or sum")
    let is-line(cell) = cell.func() in (table.hline, table.vline)
    let rows = cells.slice(1).filter(cell => not is-line(cell)).chunks(ncols)
    let signed = args.named().at("side", default: "one") == "two"
    let summary = range(1, ncols).map(col => {
      let values = rows.map(row => bar-number(row.at(col)))
      let value = values.sum()
      fixed-number(
        if summary-fn == "mean" { value / values.len() } else { value },
        signed: signed,
      )
    })
    let label = if summary-label != none {
      summary-label
    } else if summary-fn == "mean" {
      [平均]
    } else {
      [合计]
    }
    cells += (table.hline(stroke: 0.8pt), strong(label)) + summary
  }
  let body = table-fn(..fields, ..args.named(), ..cells)

  figure([], kind: table, caption: caption)
  v(-0.7em)
  align(center)[#body]
}

#let table-long(
  columns: (auto,),
  header: none,
  caption: [],
  table-fn: table,
  ..args,
) = {
  let ncols = if type(columns) == int { columns } else { columns.len() }
  let cells = args.pos()
  let auto-header = header == none
  let header = if auto-header { cells.slice(0, ncols) } else { header }
  let cells = if auto-header { cells.slice(ncols) } else { cells }
  let header = if type(header) == content and header.func() == table.header {
    header
  } else {
    repeat-header(..header)
  }

  wrap-table(
    table-fn(columns: columns, ..args.named(), header, ..cells),
    caption: caption,
  )
}
