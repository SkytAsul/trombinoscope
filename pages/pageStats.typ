#show: it => align(horizon, it)

#align(center)[
  = Effectif des élèves-ingénieur·es\ (au début de l'année scolaire 2023/2024)
]

#v(2em)

#show table.cell: align.with(center)
#show table.cell.where(x: 0): set text(weight: "bold")
#set table(
  fill: (rgb("EAF2F5"), none)
)

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

Nombre d'élèves-ingénieur·es Sportifs de Haut Niveau : *112*

Nombre d'élèves-ingénieur·es internationaux : *285*

Nombre d'élèves-ingénieures : *591*

#v(1em)

*Nombre total d'élèves-ingénieur·es : 1785*

#pagebreak()

#columns(2)[
  *À l'INSA, il y a :*

  - 15 Thomas
  - 13 Camille
  - 12 Clément
  - 11 Théo et Alexandre
  - 10 Antoine, Malo et Arthur
  - 9 Titouan, Léo, Pierre, Romain et Emma
  - 8 Valentin, Lucas, Paul, Maxime
  - 7 Eva, Pauline, Louis et Jules
  #colbreak()
  *Parmi les dates recueillies :*

  - 8 personnes sont nées le 13 avril, le 23 janvier et le 15 mars.
  - 7 personnes sont nées le 4 août et le 19 février.
  - 2 personnes sont nées le 29 février
  - seules 71 personnes ont une date de naissance unique
  - 267 personnes sont nées le même jour que quelqu'un d'autre
]

#v(3em)

#figure(image("stats/birth months.svg", width: 90%), caption: "Répartition des mois de naissance", supplement: none)