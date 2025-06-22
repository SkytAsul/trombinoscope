# Trombinoscope / Face Book
This is a Typst/Python/Bash project that makes creation of a face book fast and easy.

It was originally created for the French engineering school INSA Rennes, but can easily be adapted to every school in the world.

## Instructions
1. Place in the `/raw` directory all the raw image files, following the `Department/Year/Group` hierarchy. They must be in the format `.JPG`.
1. Also place the `.xlsx` files in the same hierarchy.
> [!TIP]
> You can use the [rclone](https://rclone.org) util to automatically sync the contents of the Google Drive folder with your computer. It is a little challenging to setup but in the end it's worth it.  
> The command would look like this: `rclone sync -P --drive-shared-with-me ClubTrombi:"Club Trombinoscope/2025" ./`
3. Put the wanted background image in the `trombinoclean` directory, under the name `bg_big.jpg`.
1. Launch the `/convert-raw.sh` script. This will :
    1. Read pictures in `/raw` *that have not already been converted*
    1. Convert the green screen to the background image
    1. Detect the faces in those pictures
    1. Crop around those faces, or around a center point if the face detection has failed
    1. Resize the pictures to a much lower size (270 in width and keeping the same ratio, customizable)
    1. Save the edited picture in `/data` in the `.JPG` format
    1. Remove all previously existing `.csv` files in `/data`
    1. Convert all `.xlsx` files (Google Sheets export / Excel files) from `/raw` to `.csv` ones in `/data`  
    - yes, this step will take a long time and will burn your computer
1. Put the `GroupsData.csv` file in `/data`.
1. Do `typst compile trombi.typ`.
1. Ta-dam!

## Image dimensions
- Images should have the *same* dimensions as the background image (in 2024, 4000x6000).
- They can be rotated *if and only if* the file contains the necessary EXIF attributes to make the scripts understand their orientation (i.e., if you open the file with an image viewer, it is automatically in the right orientation).
- Images should have the `.JPG` format (case-sensitive).
- They are automatically cropped around detected face with customizable percentages. They are also resized to a smaller size (in 2024, 270x303).
- Those peculiarities can be changed in the `replacehsv.py` Python script.

## Fixing problems
In the Google Sheets, photographers often add or skip extra zeroes at the beginning of picture names.
To fix this automatically, you can use the `data/fix-images.py` script. It will also tell you which
images are missing.
