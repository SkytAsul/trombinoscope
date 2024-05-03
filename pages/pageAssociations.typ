#let display(path, name) = block(breakable: false)[
  == #name

  #let cells = ()

  #{
    let data = csv("associations/" + path + ".csv")
    let handled-roles = ()
    for i in range(data.len()) {
      let row = data.at(i)
      let role = row.at(0)

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
      cells += row.slice(1)
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

Dans cette partie vous retrouverez une liste (non exhaustive) des membres des bureaux des différents clubs et associations qui ont animé la vie associative de l'INSA sur cette année scolaire 2023/2024.

#show: it => columns(2, it)
#display("amicale", "Amicale")
#display("foyer", "Foy'")
#display("kfet", "Kfêt")
#display("sle", "Son & Lumières")
#display("rns", "Rock'n'Solex")
#display("uds", "Un Des Sens")
#display("fog", "Festival de l'Œil Glauque")
#display("gala", "GALA")
#display("fanfare", "Fanfare")
#display("insalan", "InsaLan")
#display("boom", "BOOM")
#display("bebop", "Bebop")
#display("weipa", "WEIPA XXIII")
#display("wei", "WEI")
#display("aei", "AEI")
#display("insatisfaites", "Insatisfait·es")
#display("photo", "Club photo")
#display("greensa", "Greensa")
#display("insindia", "Ins'India")
#display("ouest", "Ouest INSA")
#display("fgo", "Forum Grand Ouest (FGO)")
#display("as", "Association Sportive (AS)")
#display("eai", "Échange Afrique INSA (EAI)")
