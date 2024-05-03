#set page(width: 5cm, height: 2cm)
#show heading: {}

Page 1 that should *not* have a header.
#pagebreak()

#heading("Random hidden heading")

#set page(header: "This is the header")
Page 2 that *should* have a header.

#pagebreak()
Page 3 that *should* also have the header.