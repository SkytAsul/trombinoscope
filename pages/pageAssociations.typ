#let display(path, name) = block(breakable: false)[
  == #name

  #let cells = ()

  #{
    let data = csv("associations/" + path + ".csv")
    let handled-roles = ()
    for i in range(data.len()) {
      let (role, surname, name, group) = data.at(i)

      if role not in handled-roles {
        let role-count = 1
        for j in range(i+1, data.len()) {
          let next-role = data.at(j).at(0)
          if next-role == role {
            role-count += 1
          } else if next-role == "" {
            role-count += 1
            data.at(j).at(0) = role
          } else {
            break
          }
        }

        if (role-count > 1) {
          handled-roles.push(role)
        }

        cells.push(table.cell(rowspan: role-count, align: horizon, role))
      }
      cells += ([#upper(surname) #name], group)
    }
  }

  #set text(size: 0.8em)
  #table(
    columns: (auto, auto, auto),
    ..cells
  )
]

#align(center)[= Associations & Clubs]

#v(1em)

Dans cette partie vous retrouverez une liste (non exhaustive) des membres des bureaux des différents clubs et associations qui ont animé la vie associative de l'INSA sur cette année scolaire 2024/2025.

#show: it => columns(2, it)
#display("amicale", "Amicale")
#display("photo", "Club photo")
#display("fanfare", "Fanfare")
#display("fog", "Festival de l'Œil Glauque")
#display("gala", "GALA")
#display("insatisfaites", "Insatisfait·es")
#display("uds", "Un Des Sens")
#display("insindia", "Ins'India")
#display("weipa", "WEIPA XXIV")
#display("greensa", "Greensa")
#display("boom", "BOOM")
#display("aei", "AEI")
#display("eai", "Échange Afrique INSA (EAI)")
#display("foyer", "Foy'")
#display("bebop", "Bebop")
#display("insamap", "INS'AMAP")
#display("insarcenciel", "INS'arc·en·ciel")
#display("sle", "Son & Lumières")
#display("trip", "Trip Club")
#display("inscape", "Ins'cape Game")
#display("imagineca", "Imagine Ça")
#display("insalan", "InsaLan")
#display("kfet", "Kfêt")
#display("rns", "Rock'n'Solex")
#display("wei", "WEI")
#display("solidalim", "Solid'Alim")
#display("ouest", "Ouest INSA")
#display("fgo", "Forum Grand Ouest (FGO)")
#display("as", "Association Sportive (AS)")
