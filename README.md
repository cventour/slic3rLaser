# slic3rLaser
Converting your Slic3r GCODE files for Laser Cutting
----------------------------------------------------

What made me write this
-----------------------
I've followed the great work of @vandenmar at https://www.instructables.com/id/Laser-Engraving-on-Your-Prusa-MK3/ to add a laser module to my 3D printer. I started using Laribo the tool that comes with the instructions, but it was not exactly what I 
was looking for. My intention was to create STL files in Fusion360 and use their perimeter for laser cutting. I tried the CAM option from Fusion360 at first, along with a Postprocessing file I edited to match the MK3 GCODE but I noticed that the output code was not as good with curves as slic3er was. So after some research and brushing up my Perl skills, I ended up with my own Slic3r profile and a postprocessing script. 

Requirements
------------
Apart from the obvious hardware you will need (refer to instructables article above) you will need to download the LaserPrusa.ini and LaserPS.pl files from my github. For the post processing code to run you will need to have Perl installed on your Windows machine (OSX and Linux should have it installed by default). Nothing else you need to do after installing Perl on your box.

Making it Work
--------------
After you download the files, open your Slic3er application and File -> Load Config and point to where you saved the LaserPrusa.ini file. This will make all the necessary changes to the profile so that whenever you slice an STL, the perimeters of the STL will be converted to GCODE for your laser engraver to cut. You will also need to point to the LaserPS.pl file by going to 

Print Settings -> Output Options -> Post-Processing Scripts , and type the path where you saved the .pl file.

Extra Slicing Options
---------------------
I have added two extra user configurable options for the slicing. You can find them at Printer Settings -> Custom G-CODE -> Start G-CODE. These are :

LASER_POWER and LAYERS_COUNT

*** WARNING ****	
DO NOT UNCOMMENT THOSE LINES. THEY STILL WORK

LASER_POWER Setting
-------------------
Takes a value between 0-255 with 255 being the maximum power of the laser, and 0 being like turning the laser off. Based on your laser power in Watts, the material you cut and the speed you have you will need to adjust the power. I start by 200 on my 2.5W module and adjust up or down based on the material I want to cut or engrave.

LAYERS_COUNT Setting
--------------------
You might need to have to pass the ladser over your design more than one times to have the result you want (dereper cutting, darker engraving). In that case, you will increase the counter so that more "layers" aka passes will be kept. Bear in mind that your STL will have to be like a block extrusion and not have pyramid shape as it gets higher. I usually take my Sketch and extrude 2-3mm and then configure the layers I need to keep on the Slic3r profile.



I hope you enjoy laser cutting with Slic3r and your Prusa as much as I do :)
