  !!----------------------------------------------------------------------------
  !!----------------------------------------------------------------------------
  !!
  !!  *FILE*  axis_ratio.f90
  !!
  !!  *LAST CHANGES*
  !!
  !!
  !!  *DESCRIPTION* 
  !!
  !!  This file contains a single subroutine that computes the axis ratio
  !!  of the single particle according to chosen parameterisation. 
  !!  (spherical (default),Brandes et al, 2002 for rain,  Andsager et al, 1999
  !!  for rain, Ryzhkov et al, 2011 fro graupel and hail. 
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
  subroutine get_axis_ratio(radius,axis_ratioID,ax_ratio)
  Implicit None
  !
  real*8, Intent(In)      :: radius ! mm
  real*8, Intent(In)      :: axis_ratioID ! > 100  ID for parameterisation
  real*8,Intent(Out)      :: ax_ratio  ! axis ratio, a/b for oblate > 1 and increases with size
  !
  real*8             :: Dmm,Dcm
    !-----------------------------------------------------------------
    ax_ratio=1.000001D0 
    !---------------------------------------------------------------------------------------
    if (int(axis_ratioID)==101) then ! Brandes et al, 2002
      Dmm=2.d0*radius
      Dcm=Dmm*1.d-1
      if (Dcm>0.05d0) then !
           ax_ratio=max(1.000001D0,1.0d0/ &
          (0.9951d0 + 0.0251d0 * Dmm - &
          0.03644d0 * Dmm*Dmm + &
          0.005303d0 * Dmm*Dmm*Dmm - &
          0.0002492d0 * Dmm*Dmm*Dmm*Dmm))
      endif
    endif
    !---------------------------------------------------------------------------------------
    !
    !---------------------------------------------------------------------------------------
    if (int(axis_ratioID)==102) then ! Andsager et al, 1999
      Dmm=2.d0*radius
      Dcm=Dmm*1.d-1
           ax_ratio=max(1.000001D0,1.0d0/ &
          (1.0048d0 + 0.0057d0 * Dcm  &
          -2.628d0 * Dcm*Dcm  &
          +3.682d0 * Dcm*Dcm*Dcm  &
          -1.677d0 * Dcm*Dcm*Dcm*Dcm))
    endif
    !---------------------------------------------------------------------------------------
    ! 
    !---------------------------------------------------------------------------------------
    if (int(axis_ratioID)==103) then ! Ryzhkov et al, 2011, dry graupel/hail
      Dmm=2.d0*radius
      Dcm=Dmm*1.d-1
      if (Dmm<10.0d0) then !
           ax_ratio=max(1.000001D0,1.0d0/(1.0d0 - 0.02d0 * Dmm))
      endif
      if (Dmm>=10.0d0) then !
           ax_ratio=1.0d0/0.8d0
      endif
      !
    endif
    !---------------------------------------------------------------------------------------
    ! 
  return
  end subroutine  get_axis_ratio
