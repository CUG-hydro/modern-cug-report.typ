#let str_npad(n, width: 3) = {
  let s = str(n)
  while s.len() < width { s = "0" + s }
  s
}

#let read_csv(file) = {
  let raw = csv(file)
  let header = raw.at(0)
  let rows = raw.slice(1)
  rows.map(row => {
    let d = (:)
    for (k, v) in header.zip(row) { d.insert(k, v) }
    d
  })
}
