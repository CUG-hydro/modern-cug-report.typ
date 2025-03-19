#let List(i, fill: rgb(0, 0, 255)) = {
  let nums = ("①", "②", "③", "④", "⑤", "⑥", "⑦", "⑧", "⑨", "⑩")
  // type(i)
  let it = if type(i) == int { nums.at(i - 1) } else { i }
  // it
  text(fill: fill)[*#it*]
}

#let List-black(i) = {
  List(i, fill: rgb(0, 0, 0))
}

#let blue-num(it) = {
  text(fill: rgb(0, 0, 255))[*#it*]
}
