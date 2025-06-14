#!/bin/python3
import os
import csv
import re
from datetime import date

data = []

def parse_date(date_str):
    if date_str == "":
        return None
    matcher = re.fullmatch(r"\s*(\d{1,2})[ /.-](\d{1,2})[ /.-](\d{1,4})\s*", date_str)
    if matcher == None:
        print(f"No match: {date_str}")
        return None
    day = int(matcher.group(1))
    month = int(matcher.group(2))
    year = int(matcher.group(3))
    if year < 100:
        new_year = 2000 + year
        print(f"Year<100: {year}, falling back to {new_year}")
        year = new_year
    return date(year, month, day)

def read_csv(file, promo):
    print(f"Reading {file}")
    with open(file, newline='') as csvfile:
        reader = csv.reader(csvfile, delimiter=',')
        next(reader, None)
        for row in reader:
            surname = row[0].strip()
            name = row[1].strip()
            try:
                date = parse_date(row[2])
            except ValueError as ex:
                print("Failed to parse date of ", surname, name, row[2], ex)
                date = None
            if surname != "" or name != "":
                data.append([surname, name, date, promo])

with open("GroupsData.csv", newline='') as groups_file:
    reader = csv.reader(groups_file)
    next(reader, None)
    for row in reader:
        if len(row) == 0:
            continue
        promo, depart, group, csv_name, data_path = row
        read_csv(data_path + "/" + csv_name + ".csv", f"{promo}{depart}")

# for dirpath, dirnames, filenames in os.walk("./"):
#     if dirpath == "./": continue
#     dirpath = os.path.relpath(dirpath, "./")
#     for filename in filenames:
#         base, ext = os.path.splitext(filename)
#         if ext.lower() == ".csv":
#             fileNamePath = os.path.join(dirpath, filename)
#             read_csv(fileNamePath)

with open("data.csv", "w") as file:
    writer = csv.writer(file)
    writer.writerow(("Nom", "Prénom", "Date de naissance", "Promo"))
    writer.writerows(data)
    #for row in data:
    #    file.write(date.isoformat() + "\n")