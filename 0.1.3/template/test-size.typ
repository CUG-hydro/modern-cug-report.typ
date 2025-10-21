// #let font_default = ()
// #import "../Base/size.typ": default_size, define_size, set_size, table-styled
#import "@local/modern-cug-report:0.1.3": *

= 1 test-size

#let base = default_size(text: 13pt)
#let config = define_size(
  13pt, // base_size
  (
    text: 13pt,
    math: (text: 13pt, block: 15pt),
    table: 16pt,
    figure: 10pt,
    raw: 11pt,
    heading: (
      H1: 14pt,
      H2: 20pt,
      H3: 14pt,
    ),
    table-cell: (
      text: 11pt,  // 大部分表格使用 11pt
      math: 10pt,  // 大部分表格数学公式使用 10pt
    ),
  ),
)

#show: it => set_size(it, config)

// == 1.1 默认配置
// #base

== 1.2 合并配置
#config

#show math.equation: set text(size: 12pt) // 这里会覆盖全局设定

$ y = a x^2 + b x + c $
inline math: $y = a x^2 + b x + c$

#[
  #show table.cell: it => {
    set text(size: 22pt)
    show math.equation: set text(size: 12pt) // 无法覆盖掉内部的设定
    it
  }

  #figure(
    caption: [表名],
    table(
      columns: 3,
      // (2.0cm, 1.9cm, 1.55cm),
      rows: (0.8cm, 0.8cm),
      align: (horizon),
      [测试字体], [测试字体], [$y = a x^2 + b x + c$],
      [测试字体], [测试字体], [$y = a x^2 + b x + c$],
    ),
  ) <table_>
]


#show math.equation: set text(size: 24pt) // 外部作用域会被覆盖

// 方案1: 使用局部作用域，新的 show 规则会覆盖外部的
// 需要将 table 放在一个新的作用域中
#[
  
  #show table.cell: it => {
    set text(size: 22pt)
    it
  }

  #figure(
    caption: [表名],
    table(
      columns: 3,
      rows: (0.8cm, 0.8cm),
      align: (horizon),
      [测试字体], [测试字体], [$y = a x^2 + b x + c$],
      [测试字体], [测试字体], [$y = a x^2 + b x + c$],
    ),
  ) <table_2>
]


#figure(
  // image("./thumbnail.png", width: 70%),
  "图片",
  caption: [图名],
) <fig_>
