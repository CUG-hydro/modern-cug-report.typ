#import "src/lib.typ": *
// #import "@preview/modern-cug-report:0.1.1"
// #show: (doc) => template(doc, size: 12pt, pagenum: true)
#show: (doc) => template(doc, size: 12pt, pagenum: true)

#show cite: it => {
  show regex("([\u4e00-\u9fa5]+.+?)et al\."): match => {
    match.text.replace(" et al.", "等")
  }
  // 将英文括号替换为中文括号（针对中文引用）
  show " （": "（"
  show "）": "）"
  it
}

#show bibliography: it => {
  set text(size: 10.5pt, font: ("Times New Roman")) // "SimSun"
  // set align(right)
  set par(spacing: 1.24em, leading: 1em, 
    hanging-indent: 10em, 
    justify: true,
    first-line-indent: (amount: -2em, all: true))
  // show par: set par(hanging-indent: 2em)
  show regex("([^.,:\s]+(?:期刊|杂志|学报|通报|科学|大学学报|研究|出版社)[^.,:\s]*)"): match => {
    strong(emph(match.text)) 
  }
  h(-2em) + it
}

#show heading.where(level: 2): it => {
  it
  v(0.25em)
}

#show heading.where(level: 3): it => {
  it
  v(0.25em)
}

// =
#align(center)[#text(size:14pt)[*报告正文*]]

#par(spacing: 1.24em, leading: 1.24em)[#text(size:13pt)[
#h(2em)
参照以下提纲撰写，要求内容翔实、清晰，层次分明，标题突出。\
#text(fill:blue)[*请勿删除或改动下述提纲标题及括号中的文字。*]
]]

#v(0.6em)
#h(2em)
#text(fill:blue, size:14pt)[
*（一）立项依据与研究内容（建议 8000 字以下）：*
]

// #set text(size:12pt)
// #set par(first-line-indent: (amount: 2em, all: true), 
//   spacing: 1.44em, leading: 1.24em
// )

// #h(2em)
= *1．项目的立项依据*（研究意义、国内外研究现状及发展动态分析，需结合科学研究发展趋势来论述科学意义；或结合国民经济和社会发展中迫切需要解决的关键科技问题来论述其应用前景。附主要参考文献目录）； // <!-- omit in toc -->

== 1.1 研究背景与意义
#v(0.4em)
// // #[@fan_incorporating_2007]
#h(2em)
参考文献的两种格式：#List(1)#[@Zhang_2019_Coupled @kangshaozhong_2014_shui @kong2020photoperiod]；#List(2) #cite(<XiaJun_2020_地球科学进展>, form: "prose")。


#cite(<Zhang_2010_Using>, form: none)
#cite(<Zhang_2019_Coupled>, form: none)


#v(0.4em)
== 1.2 研究现状及发展动态分析
#v(0.3em)

#h(2em)
#Blue[重点阐述部分]

// #include "Table2_植被生理限制方案.typ"


#show bibliography: it => {
  show grid.cell.where(x: 0): it => align(right, it)
  it
}

*参考文献*
#v(-1.4em)
#pad(left: 0em)[
  #bibliography("References2025.bib", title: none,
    style:"../csl/001gb-t-7714-2015-author-date-bilingual.csl")
]


#v(1em)
// #pagebreak()

// =
= *2. 项目的研究内容、研究目标，以及拟解决的关键科学问题*（此部分为重点阐述内容）；// <!-- omit in toc -->

== 2.1 研究目标

== 2.2 研究内容

// ==== （1）研究内容1 // <!-- omit in toc -->

// ==== （2）研究内容2 // <!-- omit in toc -->
// #v(0.4em)
== 2.3 关键科学问题
// #v(0.4em)

// *（1） 关键科学问题1。* #List(1)；#List(2)；#List(3)；

// #v(0.4em)
// *（2） 关键科学问题2。* #List(1)；#List(2)；#List(3)；




#v(1em)
// =
= *3. 拟采取的研究方案及可行性分析*（包括研究方法、技术路线、实验手段、关键技术等说明）； // <!-- omit in toc -->

== 3.1 技术路线

== 3.2 实验方案

// #v(1em)

== 3.3 研究方案

// === 3.3.1 土壤水限制时空异质性

== 3.4 可行性分析

// ==== （1）目标可行性 // <!-- omit in toc -->

// ==== （2）技术可行性 // <!-- omit in toc -->

#v(1em)


// =
= *4. 本项目的特色与创新之处；* // <!-- omit in toc -->

// ==== （1）特色之处 // <!-- omit in toc -->
// #v(0.2em)

// // #List-black(1) 
// // #List-black(2) 

// ==== （2）创新之处 // <!-- omit in toc -->
// // #v(0.2em)

// #List-black(1) 
// #List-black(2) 

#v(1em)
// =
= *5. 年度研究计划及预期研究结果*（包括拟组织的重要学术交流活动、国际合作与交流计划等）。 // <!-- omit in toc -->

// == 5.1 年度研究计划
// // 本项目计划在2026年1月至2029年12月四年内完成，详见表 2。

// == 5.2 预期研究成果

#v(1.5em)

= （二）*研究基础与工作条件*  // <!-- omit in toc -->

= 1．*研究基础*（与本项目相关的研究工作积累和已取得的研究工作成绩）； // <!-- omit in toc -->


#ref-list(
  [[1]],
  [
    Su, W., T. P. Charlock, and F. G. Rose, 2005: Deriving surface ultraviolet radiation from CERES surface and atmospheric radiation budget: Methodology. _*J. Geophys. Res.*_, 110(D14209), doi: 10.1029/2005JD005794.
  ],
  [[2]],
  [
    Su, W., T. P. Charlock, F. G. Rose, and D. Rutan, 2007: Photosynthetically active radiation from clouds and the earth’s radiant energy system (CERES) products. _*J. Geophys. Res.*_, 112(G02022), doi: 10.1029/2006JG000290.
  ],
  [[3]],
  [
    Rutan, D. A., S. Kato, D. R. Doelling, F. G. Rose, L. T. Nguyen, T. E. Caldwell, and N. G. Loeb, 2015: CERES synoptic product: Methodology and validation of surface radiant flux. _*J. Atmos. Oceanic Technol.*_, 32, 1121–1143, doi: 10.1175/JTECH-D-14-00165.1.
  ],
)


= 2．*工作条件*（包括已具备的实验条件，尚缺少的实验条件和拟解决的途径，包括利用国家实验室、全国重点实验室和部门重点实验室等研究基地的计划与落实情况）；// <!-- omit in toc -->

= 3．*正在承担的与本项目相关的科研项目情况*（申请人和主要参与者正在承担的与本项目相关的科研项目情况，包括国家自然科学基金的项目和国家其他科技计划项目，要注明项目的资助机构、项目类别、批准号、项目名称、获资助金额、起止年月、与本项目的关系及负责的内容等）；// <!-- omit in toc -->

= 4．*完成国家自然科学基金项目情况*（对申请人负责的前一个已资助期满的科学基金项目（项目名称及批准号）完成情况、后续研究进展及与本申请项目的关系加以详细说明。另附该项目的研究工作总结摘要（限500字）和相关成果详细目录）。// <!-- omit in toc -->




= （三）*其他需要说明的问题* // <!-- omit in toc -->

= 1. *申请人同年申请不同类型的国家自然科学基金项目情况*（列明同年申请的其他项目的项目类型、项目名称信息，并说明与本项目之间的区别与联系；已收到自然科学基金委不予受理或不予资助决定的，无需列出）。// <!-- omit in toc -->

#h(2em)无。

= 2. *具有高级专业技术职务（职称）的申请人或者主要参与者是否存在同年申请或者参与申请国家自然科学基金项目的单位不一致的情况*；如存在上述情况，列明所涉及人员的姓名，申请或参与申请的其他项目的项目类型、项目名称、单位名称、上述人员在该项目中是申请人还是参与者，并说明单位不一致原因。 // <!-- omit in toc -->

#h(2em)无。

= 3. *具有高级专业技术职务（职称）的申请人或者主要参与者是否存在与正在承担的国家自然科学基金项目的单位不一致的情况*；如存在上述情况，列明所涉及人员的姓名，正在承担项目的批准号、项目类型、项目名称、单位名称、起止年月，并说明单位不一致原因。// <!-- omit in toc -->

#h(2em)无。

= 4. *同年以不同专业技术职务（职称）申请或参与申请科学基金项目的情况*（应详细说明原因）。// <!-- omit in toc -->

#h(2em)无。

= 5. *其他*。// <!-- omit in toc -->

#h(2em)无。
