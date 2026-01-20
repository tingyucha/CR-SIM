#! /bin/sh
#set -eax
set -e +ax

# export fr="3.d0"
# export fr="5.5d0"
# export fr="9.5d0"
# export fr="35.d0"
export fr="94.0d0"

export hydro_type="graupel_wdm_ar0.8"
#export hydro_type="gh_ryzh"
export rad1="2.5d0" # radius in um
export rad2="25000.d0" # radius in um
export nr="501"
export phaseID="3" # mixure of ice and air
# export hdensity="0.5d0"  #  gr/cm^3 #CHANGE!!!!
export axis_ratioID="0.8d0" # 101 = brandes et al (2002); 102=Andsager et al(1999); 103=Ryzhkov et al. (2011)
#export axis_ratioID="103.d0" #  103=Ryzhkov et al. (2011)
export set_elID="-90.d0" # if positive,create look up table only for given fixed value of elevation,if negative create luts for elevs from 0 to 90. 

#----------------------ice  starts from here

# export fr="94.0d0"
export temp="243.16d0"

# export fr="13.6d0"
export hdensity="0.05d0"  #  gr/cm^3
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID
# export hdensity="0.5d0"  #  gr/cm^3
# ./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID
# export hdensity="0.9d0"  #  gr/cm^3
# ./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID

#export fr="3.d0"
#./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID

#export fr="5.5d0"
#./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID

#export fr="9.5d0"
#./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID

#export fr="35.d0"
#./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID

#export fr="94.d0"
#./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID






#----------------------------------------------------------------------


