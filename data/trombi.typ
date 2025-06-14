// This function allows to display a text with a variable size so it fits the available space the best.
// It works by trying to display it multiple times, and decreasing the font size each time until it fits.
// It is probably not the best way and can crash the compiler if there are too many iterations.
#let fit-text(content-text, size) = {
  layout(avail-size => {
    let real-size = measure(block(width: avail-size.width, text(size: size, content-text)))
    if real-size.height <= avail-size.height{
      text(size: size, content-text)
    } else {
      fit-text(content-text, size - 0.4pt)
    }
  })
}

#let _accept-missing-photos = false
#let pictures-counter = counter("total-pictures")

// author: laurmaedje
// Renders an image or a placeholder if it doesn't exist.
// Don’t try this at home, kids!
#let maybe-image(path, ..args) = context {
  let path-label = label(path)
   let first-time = query((context {}).func()).len() == 0
   if first-time or query(path-label).len() > 0 {
    [#image(path, ..args)#path-label]
  } else {
    image("no_picture.jpg", ..args)
  }
}

#let display-student(group-data-path, line) = {
  // As the CSVs do not always have the same amount of columns, we cannot directly destructure
  // the line to a tuple (name, surname, birthdate...).
  let name = upper(line.at(0))
  let surname = line.at(1)
  let birthdate = line.at(2)
  let quote = line.at(3)
  let picture = group-data-path + line.at(5) + ".JPG"

  if surname == "Youenn" and name == "LE JEUNE " {
    quote = [
      Vous connaissez Typst ? C'est vraiment mieux que LaTeX vous savez#footnote[
        Votre serviteur y croit tellement que ce trombinoscope, que vous tenez entre les mains, est entièrement fait à l'aide de Typst !
      ]
    ]
  }

  if quote == "Slay" {
    quote = box(text(fill: gradient.linear(..color.map.rainbow), quote, weight: "bold"))
  }

  pictures-counter.step()
  let image-func = if _accept-missing-photos { maybe-image } else { image }
  align(center, grid(
    rows: (auto, 10pt, 9pt, 1fr),
    gutter: 4pt,
    image-func(picture, width: 95pt, height: 303pt/270pt * 95pt),
    {
      set text(weight: "bold")
      block(width: 95%, fit-text(name.trim(" ") + " " + surname.trim(" "), 11pt))
    },
    text(size: 9pt, birthdate),
    fit-text(quote, 10pt)
  ))
}

#let display-group(promo, depart, group-row) = {
  let group-name = group-row.at("Group")
  let full-group-name = depart
  // Sometimes there is only 1 Group in a Department so the group-name is empty and we should not display it.
  if group-name != "" {
    full-group-name += " - " + group-name
  }

  let header = [
    #h(1fr)
    *#promo\A - #full-group-name*
    #h(0.3cm)
  ]
  set page(header: header)
  heading(level: 2, full-group-name)

  let group-data-path = group-row.at("DataPath")
  let group-data = csv(group-data-path + group-row.at("CsvName") + ".csv")
  // We must not load the csv as dictionary because all sheets do not have the same columns headers...
  _ = group-data.remove(0)
  if group-data.at(0).len() <= 5{
    panic("Group " + depart + " " + promo + " " + group-name + " has wrong amount of columns")
  }

  let students = group-data.filter(line => line.at(5) != "DSC0" and line.at(5) != "DSC00" and line.at(5) != "") // there must be a better way to do that
  students = students.sorted(key: line => upper(line.at(0)))
  for students-chunk in students.chunks(9, exact: false){
    let students-boxes = students-chunk.map(line => display-student(group-data-path, line))
    grid(columns: (1fr, 1fr, 1fr), rows: (1fr, 1fr, 1fr), gutter: 0.1cm, ..students-boxes)
  }
}

#let add-images(promo-function) = [
  // We do not want to *display* the headings: we only want them so they can be shown in the
  // PDF index (and eventually in the #outline function if needed).
  #show heading: it => {}

  #let groups-data = csv("GroupsData.csv", row-type: dictionary)
  #let promos = groups-data.map(x => x.at("Promo")).dedup()
  #for promo in promos {
    //heading(level: 1, "Année " + str(promo))
    // first page headers are not shown if we keep that, see problem-demo.typ
    promo-function(promo)
    let departs = groups-data.filter(x => x.at("Promo") == promo).map(x => x.at("Depart")).dedup()
    for depart in departs{
      for group-row in groups-data.filter(x => x.at("Promo") == promo and x.at("Depart") == depart){
        display-group(promo, depart, group-row)
      }
    }
  }
]

// Example :
/*
#set page("a5", margin: (top: 1cm, left: 0.5cm, right: 0.5cm, bottom: 0.5cm))
#add-images(promo => align(center+horizon, box(stroke: 2pt, inset: 15pt, text(size: 60pt, weight: "extrabold", str(promo) + "A"))))
*/