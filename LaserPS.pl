#!/usr/bin/perl -i 

use strict;
use warnings;

my $skip = 0;

# Laser intensity (0-255). Default is MAX power =255
my $laser_power = 255;
my $laser_found = 0;
# Commands to set Laser Off
my $laser_off = "M106 S0 ; Laser off\n";

# Change the "end_value" number below to the layer you want to cut.
# In this example it will only print layer 0 and through 3 (4 layers).
# This is also a parameter in the start gcode settings of the slic3r profile

my $layers_found=0;
my $end_value=4;
my $end_string = "\Qmove to next layer ($end_value)";

while (<>) {
     # modify $_ here before printing
     # If LASER_POWER value is stored in Start GCODE of Slic3r
     # the new value is stored, else 255 is default
     if (($laser_found == 0) and ($_ =~ m/LASER_POWER=/)) {($laser_power) = ($_=~ /LASER_POWER=(\w+)/); $laser_found=1;}
     # If LAYERS_COUNT value is stored in Start GCODE of Slic3r
     # the new value is stored, else 2 is default
     if (($layers_found == 0) and ($_ =~ m/LAYERS_COUNT=/)) {($end_value) = ($_=~ /LAYERS_COUNT=(\w+)/); print "MAX LAYERS FOUND--",$end_value;$layers_found=1;}
     # if (($_ =~ m/$end_string/) or ($_ =~ m/\QM84/) or ($_ =~ m/extra/)) {$skip=1;}
     if (($_ =~ m/\Qmove to next layer ($end_value)/) or ($_ =~ m/\QM84/) or ($_ =~ m/extra/)) {$skip=1;}
     if ($_ =~ m/\QEND_OF_PRINT/) {$skip=0;}
     if ($skip==0) {
     	# Remove Extrusion movements to
     	# stop unecessary movement 
     	# of extruder motor
     	$_=~s/E[-]?[0-1]\.[0-9]{5}//;
     	# Disables moving Z after layer change
     	$_=~s/^G1 Z50\.[0-9]{3} F[0-9]{1,5}\.{0,1}[0-9]{0,3} //;
     	#converts unretraction to Laser ON
     	if ($_ =~ m/unretract/) { $_="M106 S$laser_power ; Laser On\n";} 
     	elsif ($_ =~ m/; retract/) { $_=$laser_off;}
     	print ;
     }
     else {next;}
}
