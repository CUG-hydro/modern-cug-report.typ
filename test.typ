#import "@local/modern-cug-report:0.1.1":*
// #import "../../typst/lib.typ": *

#show: (doc) => template(doc, 
  _numbering: none
  // footer: "CUG水文气象学2024",
  // header: "地下水运动"
)

// #counter(heading).update(0)
#set par(leading: 1.24em)
#let delta(x) = $Delta #x$

// #
// #
// #
== 3.1 土壤水运动模型
// #show "../../images": "../../../../images"

// #beamer-block()[本章理论主要参考#cite(<bonan2019climate>, form: "prose") chapter 8。]

// #figure(
//   image("../../images/Bonan_Soil_SM.png", width: 55%),
//   caption: [土壤分层与土壤水运动示意图。]
// ) <fig_soil>

*核心公式：*

// ^(n+1)
$ q = -K pdv(psi + z, z) $
$ (Delta theta_(i)) / (Delta t)  Delta z_i = -q_(i-1) + q_(i) - e_i $

$
  q_i = -K_(i+1/2) ( (psi_(i+1) + z_(i+1)) -  (psi_(i) + z_(i))) / (z_(i+1) - z_(i))
$

$
  q_(i-1) = -K_(i-1/2) ( (psi_i + z_i) -  (psi_(i-1) + z_(i-1))) / (z_i - z_(i-1))
$
