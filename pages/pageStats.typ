#show: it => align(horizon, it)

#let insa-colors = (
  primary: rgb("#e42618"),
  secondary: rgb("#f69f1d"),
  tertiary: rgb("#f5adaa"),
)

#align(center)[
  = Effectif des élèves-ingénieur·es\ (au début de l'année scolaire 2024/2025)
]

#v(2em)

#show table.cell: align.with(center)
#show table.cell.where(x: 0): set text(weight: "bold")
#set table(
  fill: (rgb("EAF2F5"), none)
)
#show table.cell.where(y: 0): set text(weight: "bold", size: 0.8em)

== 1#super[er] cycle
#{
show table.cell.where(x: 4): set text(weight: "bold")
show table.cell.where(y: 3): set text(weight: "bold")
table(
  columns: 5,
  inset: (x: 1em),
  [/], [Classique], [FIRE], [FISP], [Total],
  [1#super[ère] année], [217], [44], [41], [302],
  [2#super[ème] année], [209], [38], [33], [280],
  [*Total*], str(217+209), str(44+38), str(41+33), str(302+280),
)
}

#v(2em)

== 2#super[ème] cycle
#{
show table.cell.where(y: 4): set text(weight: "bold")
show table.cell.where(x: 9): set text(weight: "bold")
table(
  columns: (auto,) + (1fr,) * 9,
  inset: (x: 0.5em),
  [/], [EII], [E-SET], [E&T], [GCU], [GMA], [GPM], [INFO], [MA], [Total],
  [3ème Année], [59], [17], [48], [112], [83], [56], [77], [25], str(59+17+48+112+83+56+77+25),
  [4ème Année], [43], [15], [25], [61], [70], [50], [63], [22], str(43+15+25+61+70+50+63+22),
  [5ème Année], [36], [27], [61], [72], [75], [60], [87], [26], str(36+27+61+72+75+60+87+26),
  [Total], str(59+43+36), str(17+15+27), str(48+25+61), str(112+61+72), str(83+70+75), str(56+50+60), str(77+63+87), str(25+22+26), str(477+349+444)
)
}

#v(2em)
#set text(size: 1.1em)

Nombre de Sportifs de Haut Niveau : *107*

Nombre d'Artistes de Haut Niveau : *18*

Proportion d'élèves ingénieures : *33,91%*

#v(1em)

*Nombre total d'élèves-ingénieur·es : #str(582+1270)*

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
  - 9 personnes ont trouvé malin de dire être nées le 30 février et ont fait crash le programme de calcul de statistiques. On vous voit.
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

#let months = ("Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre")

#show: lq.set-grid(kind: "y")
#show: lq.set-tick(stroke: 0pt)
#figure(lq.diagram(
  width: 12cm,
  height: 6cm,
  xaxis: (
    ticks: range(0, 12)
      .map(i => text(size: .9em, months.at(i)))
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
), caption: [*Répartition des mois de naissance*], supplement: none)
