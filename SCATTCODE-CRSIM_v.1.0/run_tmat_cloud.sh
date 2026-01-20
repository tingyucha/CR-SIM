#! /bin/sh
#set -eax
set -e +ax

#export fr="3.d0"
#export fr="5.5d0"
#export fr="9.5d0"
#export fr="35.d0"
#export fr="94.0d0"

export hydro_type="cloud"
export rad1="0.5d0" # radius in um
export rad2="125.d0" # radius in um
export nr="250"
export phaseID="1" # water
export hdensity="1.d0"  #  gr/cm^3
export axis_ratioID="1.000001d0" # 101 = brandes et al (2002); 102=Andsager et al(1999)
export set_elID="90.d0" # if positive,create look up table only for given fixed value of elevation,if negative create luts for elevs from 0 to 90. 

#----------------------cloud  starts from here

export fr="13.6d0"


export temp="244.16d0"
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID

export temp="246.16d0"
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID

export temp="248.16d0"
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID

export temp="250.16d0"
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID

export temp="252.16d0"
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID

export temp="254.16d0"
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID

export temp="256.16d0"
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID

export temp="258.16d0"
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID

export temp="260.16d0"
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID

export temp="262.16d0"
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID

export temp="264.16d0"
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID

export temp="266.16d0"
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID

export temp="268.16d0"
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID

export temp="270.16d0"
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID

export temp="272.16d0"
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

#----------------------------------------------------------------------


