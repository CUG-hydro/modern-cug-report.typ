#import "base.typ": is-scalar, merge-dict

// 必须要定义为show function才能生效
#let set_size(it, config) = {
  set text(size: config.text)
  
  show math.equation: set text(size: config.math.text)
  show math.equation.where(block: true): set text(size: config.math.block)
  
  show figure.caption: set text(size: config.figure) // 图名
  show figure.caption.where(kind: table): set text(size: config.table) // 表名
  
  show raw: set text(size: config.raw)
  
  show heading.where(level: 1): set text(size: config.heading.H1)
  show heading.where(level: 2): set text(size: config.heading.H2)
  show heading.where(level: 3): set text(size: config.heading.H3)
  show heading.where(level: 4): set text(size: config.heading.H4)
  show heading.where(level: 5): set text(size: config.heading.H5)
  show heading.where(level: 6): set text(size: config.heading.H6)
  it
}

#let default_size(text: 13pt) = {
  (
    text: text,
    math: (
      text: text, // 插入正文的公式
      block: text, // 单独一行的公式
    ),
    figure: text - 1pt, // 图件标题
    table: text - 1pt, // 表格标题
    raw: text - 2pt, // 代码
    heading: (
      default: text, //
      H1: text + 1pt, // default + 1
      H2: text, // default
      H3: text, // default
      H4: text, // default
      H5: text, // default
      H6: text, // default
    ),
  )
}

#let define_size(text, config) = {
  let base_size = default_size(text: text)
  merge-dict(base_size, config)
}
