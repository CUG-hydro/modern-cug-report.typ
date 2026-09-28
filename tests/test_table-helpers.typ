#import "../0.1.3/table-bar.typ": table-bar, bar-cell, bar-number
#import "../0.1.3/graph-table.typ": wrap-table, fixed-number

#assert.eq(bar-number(table.cell(strong[−0.125])), -0.125)
#assert.eq(bar-number([+0.#emph[25]]), 0.25)
#assert.eq(fixed-number(1.2), "1.200")
#assert.eq(fixed-number(-1.2346), "−1.235")
#assert.eq(fixed-number(1, signed: true), "+1.000")
#assert.eq(fixed-number(0, signed: true), "0.000")

// 分隔线不占数据列；自动范围与显式范围应生成相同柱状单元格。
#for side in ("one", "two") {
  let lower = if side == "two" { -0.5 } else { 0 }
  let cells = ([甲], "−0.25", table.vline(), [乙], "0.5")
  for header in (([站点], [数值]), (table.header([站点], [数值]),)) {
    assert.eq(
      table-bar(columns: 2, side: side, bar: ((column: 2),), ..header, table.hline(), ..cells),
      table(
        columns: 2,
        ..header,
        table.hline(),
        [甲], bar-cell("−0.25", min: lower, max: 0.5, side: side),
        table.vline(),
        [乙], bar-cell("0.5", min: lower, max: 0.5, side: side),
      ),
    )
  }
}

// 汇总仍保留重复表头、符号和三位小数。
#for summary in ("mean", "sum") {
  let check-table(side: none, ..args) = {
    let cells = args.pos()
    assert.eq(cells.first().func(), table.header)
    assert.eq(cells.last(), if summary == "mean" { "+0.500" } else { "+1.000" })
    table(..args)
  }
  wrap-table(
    table(columns: 2, [站点], [数值], [甲], "−0.5", table.hline(), [乙], "1.5"),
    summary-fn: summary,
    side: "two",
    table-fn: check-table,
  )
}
