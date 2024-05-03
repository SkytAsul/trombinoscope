#import "data/trombi.typ" : add-images

#set page("a5", margin: (top: 1cm, left: 0.5cm, right: 0.5cm, bottom: 0.5cm), footer: context [
  #if calc.even(counter(page).get().at(0)) {
    align(left, counter(page).display())
  } else {
    align(right, counter(page).display())
  }
], footer-descent: -10%)

#add-images(promo => [
  #page(background: image("pages/" + str(promo) + "A.svg"), footer: none, [])
])

#include("pages/pageStats.typ")
#pagebreak()
#include("pages/pageAssociations.typ")
#pagebreak()
#include("pages/pageRemerciements.typ")

#page(background: image("pages/4e-Couverture.svg"), footer: none)[]