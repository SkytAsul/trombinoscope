"""This small script passes through all CSV files and checks if the images
specified are present or not. If not, it will try to find an image that could
match in the same folder, by adding or removing extra zeroes.
"""

import csv
import os
import shutil

count = 0

def read_csv(dir: str, file: str):
    global count
    updated_rows = []
    updated = False
    with open(file, newline='') as csvfile:
        print(f"Processing file {file}")
        reader = csv.reader(csvfile, delimiter=',')
        updated_rows.append(next(reader, None))
        for row in reader:
            updated_rows.append(row)
            pic_name = row[5]
            if pic_name == "" or pic_name == "DSC0" or pic_name == "DSC00":
                continue
            count += 1

            if os.path.exists(os.path.join(dir, pic_name + ".JPG")):
                continue

            
            pic_name_2 = pic_name[:3] + "0" + pic_name[3:] # adding leading zero
            if os.path.exists(os.path.join(dir, pic_name_2 + ".JPG")):
                print(f"Found a picture with a leading zero: {pic_name_2}")
                row[5] = pic_name_2
                updated = True
                continue

            if len(pic_name) > 4 and pic_name[3] == "0":
                pic_name_2 = pic_name[:3] + pic_name[4:] # removing first character if 0
                if os.path.exists(os.path.join(dir, pic_name_2 + ".JPG")):
                    print(f"Found a picture without a leading zero: {pic_name_2}")
                    row[5] = pic_name_2
                    updated = True
                    continue
            
            print(f"Cannot find picture {dir}/{pic_name}")
    if updated:
        shutil.copy(file, file + "_original")
        with open(file, "w", newline='') as csvfile:
            writer = csv.writer(csvfile)
            writer.writerows(updated_rows)


for dirpath, dirnames, filenames in os.walk("./"):
    if dirpath == "./": continue
    dirpath = os.path.relpath(dirpath, "./")
    for filename in filenames:
        base, ext = os.path.splitext(filename)
        if ext.lower() == ".csv":
            fileNamePath = os.path.join(dirpath, filename)
            read_csv(dirpath, fileNamePath)

print(count)