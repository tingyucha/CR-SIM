#! /bin/sh
#set -eax
set -e +ax
#export fr="5.5d0"
#export fr="9.5d0"
#export fr="35.d0"
#export fr="94.0d0"

export hydro_type="ice_ar0.20"
export rad1="0.5d0" # radius in um
export rad2="750.d0" # radius in um
export nr="1500"
export rad2="748.d0" # radius in um
export nr="300"
export phaseID="3" # mixure of ice and air
export hdensity="0.5d0"  #  gr/cm^3
export axis_ratioID="0.2d0" # 101 = brandes et al (2002); 102=Andsager et al(1999)
export set_elID="-90.d0" # if positive,create look up table only for given fixed value of elevation,if negative create luts for elevs from 0 to 90. 

#----------------------ice  starts from here

export fr="13.6d0"
export temp="243.16d0"

export hdensity="0.4d0"
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID
export hdensity="0.5d0"
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID
export hdensity="0.6d0"
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID
export hdensity="0.7d0"
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID
export hdensity="0.8d0"
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID
export hdensity="0.9d0"
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID





#----------------------------------------------------------------------


