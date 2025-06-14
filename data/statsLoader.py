import csv

with open("data.csv", newline='') as csvfile:
    reader = csv.reader(csvfile, delimiter=',')
    
    for (nom, prenom, date) in reader:
        print(nom, prenom, date)