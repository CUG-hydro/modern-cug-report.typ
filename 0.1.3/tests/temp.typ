// #let font_default = ()
#import "../Base/size.typ": default_size, define_size, set_size

= 1 test-size

#let base = default_size(text: 13pt)
#let config = define_size(
  13pt,
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
)

#show: it => set_size(it, config)

$ y = a x^2 + b x + c $

inline math: $y = a x^2 + b x + c$



== 1.1 默认配置
#base

== 1.2 合并配置
#config

#figure(
  // image("./thumbnail.png", width: 70%),
  "图片",
  caption: [图名],
) <fig_>

#figure(
  caption: [表名],
  table(
    columns: 7, // (2.0cm, 1.9cm, 1.55cm),
    rows: (0.8cm, 0.8cm),
    align: (horizon),
  ),
) <table_>
