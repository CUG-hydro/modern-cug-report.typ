// #import "../Base/size.typ": default_size, define_size, set_size, table-styled
#import "@local/modern-cug-report:0.1.3": *


= 表格样式测试

#let config-table = (text: 11pt, math: 10pt)
#let set-table(config) = {
  it => {
    set text(size: config-table.text)
    show math.equation: set text(size: config-table.math)
    it
  }
}

// 若在外部锁定之后，内部则无法设定了；table的特殊设定
// #show table.cell: set-table(config-table) // 外部依然无法覆盖

== 少数特殊表格：自定义样式

#table-styled(
  figure(
    caption: [特殊样式表格 - 文字 14pt, 数学 13pt],
    table(
      columns: 3,
      rows: (0.8cm, 0.8cm),
      align: horizon,
      [文字], [数字], [公式],
      [测试], [123], [$y = a x^2 + b x + c$],
      [测试], [456], [$E = m c^2$],
    ),
  ),
  config: (text: 14pt, math: 13pt),
)

#table-styled(
  figure(
    caption: [特殊样式表格 - 文字 14pt, 数学 13pt],
    table(
      columns: 3,
      rows: (0.8cm, 0.8cm),
      align: horizon,
      [文字], [数字], [公式],
      [测试], [123], [$y = a x^2 + b x + c$],
      [测试], [456], [$E = m c^2$],
    ),
  ),
  config: (text: 16pt, math: 18pt),
)

== 总结

- 大部分表格：用 `table-default(figure(table(...)), config)` 应用统一样式
- 少数特殊表格：用 `table-styled(figure(table(...)), text-size: 14pt, math-size: 13pt)` 自定义
- 每个表格的样式互不干扰，完全可控
