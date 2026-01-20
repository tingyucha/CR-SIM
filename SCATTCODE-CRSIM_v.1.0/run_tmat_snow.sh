#! /bin/sh
#set -eax
set -e +ax
# configuration for spectrum
#export LD_LIBRARY_PATH=/aos/shared/lib/centos6/netcdf/4/intel/lib:$LD_LIBRARY_PATH
#export LD_LIBRARY_PATH=/aos/shared/lib/centos6/hdf5/default/intel/lib:$LD_LIBRARY_PATH

#configuration for tejas
#export LD_LIBRARY_PATH=/aos/shared/lib/centos5/netcdf/default/intel/lib:$LD_LIBRARY_PATH
#export LD_LIBRARY_PATH=/aos/shared/lib/centos5/hdf5/default/intel/lib:$LD_LIBRARY_PATH
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

export hydro_type="snow_ar0.60"
export rad1="50.d0" # radius in um
export rad2="25000.d0" # radius in um
export nr="4991"
export nr="500"
export phaseID="3" # mixure of ice and air
export hdensity="0.1d0"  #  gr/cm^3
export axis_ratioID="0.6d0" # 101 = brandes et al (2002); 102=Andsager et al(1999)
export set_elID="-88.d0" # if positive,create look up table only for given fixed value of elevation,if negative create luts for elevs from 0 to 90. 

#----------------------snow  starts from here

export fr="13.6d0"
export temp="243.16d0"

#export hdensity="0.1d0"
#./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID
#export hdensity="0.2d0"
#./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID
#export hdensity="0.3d0"
#./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID
#export hdensity="0.4d0"
#./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID
#export hdensity="0.5d0"
#./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID
#export hdensity="0.6d0"
#./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID

#export fr="3.d0"
#export hdensity="0.01d0"
#./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID
#export hdensity="0.05d0"
#./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID

#export fr="5.5d0"
#export hdensity="0.01d0"
#./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID
#export hdensity="0.05d0"
#./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID

#export fr="9.5d0"
#export hdensity="0.01d0"
#./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID
#export hdensity="0.05d0"
#./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID

export fr="35.d0"
export hdensity="0.01d0"
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID
export hdensity="0.05d0"
./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID

#export fr="94.d0"
#export hdensity="0.01d0"
#./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID
#export hdensity="0.05d0"
#./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity $axis_ratioID $rad1 $rad2 $nr $set_elID





#----------------------------------------------------------------------


