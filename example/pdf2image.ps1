# pdf2image a.pdf
param (
  [string]$f
  # [int]$p = 1
)

for ($p = 1; $p -le 3; $p++) {
  # replace .pdf to .png
  $fout = "ch03_$p.png"
  # $fout = $f -replace ".pdf", "_$p.png"

  # echo "$args to $f.png"
  inkscape $f --pdf-poppler --export-dpi=300 `
    -b FFFFFF `
    --export-background-opacity=0 --export-type=png --pages=$p --export-filename $fout
}
