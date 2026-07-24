#let repeat-header(stroke: 0.8pt, repeat: true, ..cells) = table.header(
  repeat: repeat,
  ..cells.pos().map(cell => table.cell(stroke: (bottom: stroke), cell)),
)


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

  figure([], kind: table, caption: caption)
  v(-0.7em)
  align(center)[
    #table-fn(columns: columns, ..args.named(), header, ..cells)
  ]
}
