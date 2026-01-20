#! /bin/sh
#set -eax
set -e +ax
#
# rain
# export hydro_type="rainb"
#export rad1="50.d0"
#export rad2="4500.d0"
#export nr="501"


#export fr="3.d0"
#export fr="5.5d0"
#export fr="9.5d0"
#export fr="35.d0"
#export fr="94.0d0"

export hydro_type="rainb"
export rad1="50.d0" # radius in um
export rad2="4500.d0" # radius in um
#export nr="891" # Number of radii : should be changed to get less resolution same as CRSIM LUTs
export nr="446" # Number of radii : should be changed to get less resolution same as CRSIM LUTs

export phaseID="1" # 1:water, 2:ice, 3: mixture of ice and air (will add 4:mixtutr of ice, air, and water)
export hdensity="1.d0"  #  gr/cm^3
export axis_ratioID="101.d0" # 101 = brandes et al (2002); 102=Andsager et al(1999)
export set_elID="-90.d0" # if positive,create look up table only for given fixed value of elevation,if negative create luts for elevs from 0 to 90. 


export fr="13.6d0" #Frequency GHz

#----------------------rain starts from here

export temp="272.16d0" # Temperature in K
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID
export temp="274.16d0"
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID
export temp="276.16d0"
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID
export temp="278.16d0"
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID
export temp="280.16d0"
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID
export temp="282.16d0"
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID
export temp="284.16d0"
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID
export temp="286.16d0"
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID
export temp="288.16d0"
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID
export temp="290.16d0"
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID
export temp="292.16d0"
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID
#
#----------------------------------------------------------------------



