#show: it => align(horizon, it)

#let insa-colors = (
  primary: rgb("#e42618"),
  secondary: rgb("#f69f1d"),
  tertiary: rgb("#f5adaa"),
)

#align(center)[
  = Effectif des élèves-ingénieur·es\ (au début de l'année scolaire 2023/2024)
]

#v(2em)

#show table.cell: align.with(center)
#show table.cell.where(x: 0): set text(weight: "bold")
#set table(
  fill: (rgb("EAF2F5"), none)
)

*Valeurs pas à jour !*

== 1#super[er] cycle
#table(
  columns: 2,
  inset: (x: 1em),
  [1#super[ère] année], [300],
  [2#super[ème] année], [292],
  [*Total*], [592],
)

#v(2em)

#show table.cell.where(y: 0): set text(weight: "bold", size: 0.8em)
#show table.cell.where(y: 4): set text(weight: "bold")
#show table.cell.where(x: 9): set text(weight: "bold")
== 2#super[ème] cycle
#table(
  columns: (auto,) + (1fr,) * 9,
  inset: (x: 0.5em),
  [/], [EII], [E-SET], [E&T], [GCU], [GMA], [GPM], [INFO], [MA], [Total],
  [3ème Année], [38], [18], [23], [68], [68], [51], [71], [22], [359],
  [4ème Année], [46], [19], [35], [63], [68], [51], [72], [23], [377],
  [5ème Année], [46], [24], [43], [96], [87], [56], [71], [34], [457],
  [Total], [130], [61], [101], [227], [223], [158], [214], [79], [1193]
)

#v(2em)
#set text(size: 1.1em)

Nombre d'élèves-ingénieur·es Sportifs de Haut Niveau : *X*

Nombre d'élèves-ingénieur·es internationaux : *X*

Nombre d'élèves-ingénieures : *X*

#v(1em)

*Nombre total d'élèves-ingénieur·es : X*

#pagebreak()

#columns(2)[
  *À l'INSA, il y a :*

  - 19 Thomas
  - 15 Nathan et Clément
  - 13 Camille
  - 12 Arthur, Romain et Jules
  - 11 Lucas et Maxime
  - 10 Tom et Théo
  - 9 Titouan et Malo
  - 8 Tristan, Gabriel, Quentin, Alexandre, Baptiste et Léo
  #colbreak()
  *Parmi les dates recueillies :*

  - 10 personnes sont nées un 17 janvier.
  - 8 personnes sont nées un 13 avril, un 19 mars et un 23 janvier.
  - 2 personnes sont nées un 29 février
  - seules 63 personnes ont une date d'anniversaire unique
  - 341 personnes sont nées le même jour et la même année que quelqu'un d'autre
  - 9 personnes ont trouvé malin de dire être nées le 30 février et ont fait crash le programme de calcul de statistiques. Sachez que je connais vos noms et vos visages.
]

#v(3em)

#import "@preview/lilaq:0.3.0" as lq
#let months-counts = (0,) * 12

#{
  let date-regex = regex("(\d+)-(\d+)-(\d+)")
  let data = csv("stats/data.csv", row-type: dictionary)
  let dates = data.map(row => row.at("Date de naissance")).filter(date => date != "").map(date => {
    let matcher = date.match(date-regex)
    let (year, month, day) = matcher.captures
    return datetime(day: int(day), month: int(month), year: int(year))
  })

  for date in dates {
    months-counts.at(date.month() - 1) += 1
  }
}

#show: lq.set-grid(kind: "y")
#show: lq.set-tick(stroke: 0pt)
#figure(lq.diagram(
  width: 12cm,
  height: 6cm,
  xaxis: (
    ticks: range(1, 12 + 1).map(i => datetime(month: i, year: 0, day: 1).display("[month repr:long]"))
      .map(rotate.with(-45deg, reflow: true))
      .map(align.with(left))
      .enumerate(),
  ),
  yaxis: (
    ticks: (0, 25, 50, 75, 100)
  ),
  lq.bar(
    range(12),
    months-counts,
    fill: insa-colors.primary
  )
), caption: "Répartition des mois de naissance", supplement: none)
