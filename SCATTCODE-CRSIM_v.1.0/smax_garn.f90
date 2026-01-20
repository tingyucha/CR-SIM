  !! ----------------------------------------------------------------------------
  !! ----------------------------------------------------------------------------
  !!  *FILE*  smax_garn.f90 
  !!
  !!  *LAST CHANGES*
  !!
  !!
  !!  *DESCRIPTION* 
  !!
  !!  This file contains a single subroutine that computes the refractive index
  !!  of dielectrically dry hydrometeors using Maxwell Garnett (1904) mixing
  !!  formula.
  !!
  !!  Copyright (C) 2019 Aleksandra Tatarevic
  !!  Contact email address: aleksandra.tatarevic@mcgill.ca
  !!
  !!  This source code is free software: you can redistribute it and/or modify
  !!  it under the terms of the GNU General Public License as published by
  !!  the Free Software Foundation, either version 3 of the License, or
  !!  any later version.
  !!
  !!  This program is distributed in the hope that it will be useful,
  !!  but WITHOUT ANY WARRANTY; without even the implied warranty of
  !!  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  !!  GNU General Public License for more details.
  !!
  !!  You should have received a copy of the GNU  General Public License
  !!  along with this program.  If not, see <http://www.gnu.org/licenses/>.
  !!
  !!----------------------------------------------------------------------------------------------------------------- 
  !!-----------------------------------------------------------------------------------------------------------------
  !!
  subroutine  mg_refr_indx(cref_m, cref_i, fm, fi, cref_mg)
  ! -- cref_air, cref_ice, f_air,f_ice, out cref_mf
  !   fm=f_air=1=rho_p/rho_ice ; fi =f_ce=rho_p/rho_ice
  Implicit None
  !
  complex*16,Intent(In)           :: cref_m  ! complex refr. index of matrix
  complex*16,Intent(In)           :: cref_i  ! compl. refr index of inclusion
  real*8, Intent(In)              :: fm ! volume fraction of matrix (Vmatrix/Vtotal
  real*8, Intent(In)              :: fi   ! volume fraction of inclusion (Vinclusion/Vtotal), Vtotal=Vmatrix+Vinclusion)
  complex*16,Intent(Out)          :: cref_mg ! copmplex refr. index of mixure (air is matrix, ice inclusion)
  
  !real*8,parameter    :: rho_ice= 0.9167d0 ! gr/cm^3
  ! in the case of ice and air Vtotal =Vparticle  where Vparticle(<=Vice), and mass particle=mass ice
  ! and V particle=Vair + Vice
  ! and it follows that Vice =rho particle * V paricle / rho ice
  ! and Vair= Vparticle ( 1 - rho particle/ rho ice)
  ! so fice=rho particle/rho_ice
  ! and fair= 1- rho_particle/rho_ice
  ! and air is matrix and ice inclusion
  !
  !
  complex*16         :: beta1,beta2,beta3
  complex*16         :: p1,p2
    !
    !-------------------------------
    beta1=cmplx(2.d0)*cref_m/(cref_i-cref_m)
    beta2=(cref_i/(cref_i-cref_m)) * cmplx(log(cref_i/cref_m))  - cmplx(1.d0)
    beta3=beta1*beta2
    !
    p1=cmplx(1.d0-fi)*cref_m + cmplx(fi)*beta3*cref_i
    p2=cmplx(1.d0 - fi) + cmplx(fi)*beta3
    !
    cref_mg=p1/p2
    !-------------------------------
    !
  return
  end subroutine  mg_refr_indx
