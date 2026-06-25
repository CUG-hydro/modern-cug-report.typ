#import "@local/modern-cug-report:0.1.3":*
// #import "../../typst/lib.typ": *

#show: (doc) => template(doc, 
  size:20pt
  // footer: "CUG水文气象学2024",
  // header: "地下水运动"
)

// #counter(heading).update(0)
#set par(leading: 1.24em)
#let delta(x) = $Delta #x$


// #set text(font: ("Times New Roman", "KaiTi"))
// #set text(font: ("Times New Roman", "SimSun"))

默认文字字体。


#figure(
  // image("Figures", width: 70%),
  [], 
  caption: [
    你好
  ]
) <fig_>
