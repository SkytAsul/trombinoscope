#import "data/trombi.typ" : add-images

#set page("a5", margin: (top: 1cm, left: 0.5cm, right: 0.5cm, bottom: 1cm), footer: context [
  #if calc.even(counter(page).get().at(0)) {
    align(left, counter(page).display())
  } else {
    align(right, counter(page).display())
  }
], footer-descent: 30%)

#page(background: image("pages/Couverture.svg"), footer: none)[]

#page(footer: none)[]

#counter(page).update(1)
#include("pages/pageIntro.typ")

#page(footer: none)[]

#add-images(promo => [
  #pagebreak(to: "odd")
  #page(background: image("pages/" + str(promo) + "A.svg"), footer: none, [])
])

#include("pages/pageStats.typ")
#pagebreak()
#include("pages/pageAssociations.typ")
#pagebreak()
#include("pages/pageRemerciements.typ")

#page(footer: none)[]
#page(footer: none)[]

#page(background: image("pages/4e-Couverture.svg"), footer: none)[]