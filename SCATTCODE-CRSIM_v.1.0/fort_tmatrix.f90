  !!----------------------------------------------------------------------------
  !!----------------------------------------------------------------------------
  !!
  !!  *FILE*  fort_tmatrix.f90 
  !!
  !! *USAGE*: ./fort_tmatrix $hydro_type $fr $phaseID $temp $hdensity
  !!            $axis_ratioID $rad1 $rad2 $nr $set_elID
  !!
  !!
  !!
  !!  *LAST CHANGES*
  !!
  !!
  !!  *DESCRIPTION* 
  !!
  !! This file contains the main code that creates LUTs used by CR-SIM. 
  !! The CR-SIM employs the T-matrix method for computation of scattering
  !! characteristics for cloud water, cloud ice, rain, snow, graupel and hail and
  !! allows the specifications of the following radar frequencies for scattering
  !! calculations: 3 GHz, 5.5 GHz, 9.5 GHz, 35 GHz and 94 GHz. 
  !! Given the particles size distributions (explicit or reconstructed from the
  !! provided PSD moments), polarimetric radar variables can be calculated if the
  !! scattering amplitudes are known. The complex scattering amplitudes are
  !! pre-computed and stored as look-up tables (LUTs) for equally spaced particle
  !! sizes using the Mishchenko’s T-matrix code for a non-spherical particle at a
  !! fixed orientation (Mishchenko, 2000) and for elevation angles from 0° to 90°
  !! with a spacing of 1°, for specified radar frequencies, temperatures and
  !! different possibilities of particles densities and aspect ratios. A hydrometeor
  !! class for which the look-up tables were pre-built by setting a fixed number of
  !! assumptions prior to running the T-matrix is referred as the “scattering type”.
  !! Each hydrometeor category present in the WRF output has to be assigned to the
  !! corresponding scattering type in the Configuration File. For example, if the
  !! oblateness of raindrops is assumed to change with size according to Brandes et
  !! al. (2002), the scattering type that has to be chosen is “rainb”, while, if it
  !! is assumed that the rain aspect ratio increases with size as in Andsager et al.
  !! (1999), the assigned scattering type would be “raina”. The details about the
  !! built look-up tables and present scattering types are given in the CR-SIM User
  !!  Guide Section 4.4. This approach involving the assigning of the specific 
  !! scattering type to each WRF  hydrometeor class in the CR-SIM Configuration 
  !! File allows an addition of the new look-up tables without the need to change
  !! the CR-SIM source code.
  !! The T-matrix code used by this program is the T-matrix code for non-sperical
  !! particles in a fixed orientation developed by Michael  Mishchenko at the NASA
  !! Goddard Institute for Space Studies,New York to compute the elements of the 
  !! amplitude matrix for different scattering particles and for different desired
  !! directions of the incident and scattered beams. This code is available 
  !! at webpage: https://www.giss.nasa.gov/staff/mmishchenko/t_matrix.html
  !!
  !!
  !!  The input parameters are specified on the command lines at the time of
  !!  execution and are listed below:
  !!
  !!  hydro_type - string parameter - the name of scattering type - for example rainb
  !!  fr - double precision defined Frequency GHz 
  !!  phaseID -  integer parameter 1:water, 2:ice, 3: mixture of ice and air (future
  !!              work 4: mixure of ice, air, and water)
  !!  temp - double precision defined Temperature in K
  !!  hdensity - double precision defined density in gr/cm^3
  !!  axis_ratioID - double precision parameter; if ==101.d0 brandes et al (2002)
  !!               if == 102 Andsager et al(1999); if == 103 Ryzhkov et al. (2011)
  !!  rad1 - double precision parameter - value of the  radius in the first bin in um
  !!  rad2 - double precision parameter - value of the radius in the last bin in um
  !!  nr -  integer parameter - Number of bin radii. NOTE: the bin number for different 
  !!        species should be  the same as the one in CR-SIM LUTS
  !!  set_elID - double precision  parameter -if positive,create look up table only for 
  !!            given fixed value of  elevation,if negative create luts for elevs from
  !              0 to 90.
  !! 
  !!  If the incorrect number of command line arguments are given then an error message is 
  !!  printed along with a help message.
  !!
  !!  The output of this code are the the LUTs files in the suitable format to be
  !!  used by CR-SIM.
  !! 
  !! REFERENCES 
  !!
  !! Tatarevic, A., Kollias, P., Oue, M., Wang, D., and Yu, K.: User’s Guide
  !! CR-SIM SOFTWARE, Brookhaven National Laboratory - Stony Brook
  !! University - McGill University Radar Science Group, 2018. 
  !! [Available at  https://www.bnl.gov/CMAS/cr-sim.php; 
  !! https://you.stonybrook.edu/radar/research/radar-simulators/.]
  !!
  !! Mishchenko M. I.  and Travis L. D., 1998: Capabilities and limitations of a
  !! current FORTRAN implementation of the T-matrix method for randomly oriented,
  !! rotationally symmetric scatterers, J. Quant. Spectrosc. Radiat. Transfer 60,
  !! 309–324.
  !!
  !! Mishchenko, M. I., 2000: Calculation of the amplitude matrix for a nonspherical
  !! particle in a fixed orientation. Appl. Opt., 39, 1026–1031.
  !!
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
  program fort_tmatrix
  Implicit None
  !
  integer    :: nr,nelev
  real*8     :: radius  ! 
  real*8     :: rad_min,rad_max
  integer    :: ir,ielev,ielev_start, ielev_end
  real*8     :: elev
  real*8     :: ax_ratio,ref_re,ref_im
  real*8     :: hdensity ! gr/cm^3
  real*8     :: temp
  real*8     :: pi
  integer,parameter  :: id=1
  complex*8          :: work
  complex*8          :: REFWAT
  complex*8          :: REFICE
  complex*16         :: workc
  integer            :: nelev1
  real*8             :: den
  real*8             :: relev
  complex*16         :: airc
  real*8             :: frac,rho_ice,rho_p
  complex*16         :: cref_mg
  !
  integer            :: phaseID  ! =1 water
  real*8             :: set_elID ! =if positive,create look up table only for given fixed
                                 !  value of elevation,if negative create luts for elevs from 0 to 90.
  real*8   :: Z11,Z12,Z13,Z14
  real*8   :: Z21,Z22,Z23,Z24
  real*8   :: Z31,Z32,Z33,Z34
  real*8   :: Z41,Z42,Z43,Z44
  !
  real*8   :: Sigma_scaIV,Sigma_scaIH
  real*8   :: sigma_sca,sigma_sca_v,sigma_sca_h
  real*8   :: P_11
  real*8   :: EXT_matr11,EXT_matr12,EXT_matr34
  !
  real*8             :: axis_ratioID
  real*8   :: Dmm,Dcm
  character :: frq_str*4,frq_str2*10,t_str*5,el_str*4,el_str2*10,rho_str*5,rho_str2*10
  
  character :: hydro_type*80
  character(len=365)  :: OutFileName
  integer       :: status
  real*8     :: fr,wv
  integer    :: i
  real*8     :: r1,r2 ! input radii in um
  !
  !---------------
  Real*8    :: AXI   ! -    equivalent-sphere radius  in um
  Real*8    :: RAT   ! -    = 1 - particle size is specified in terms of the  equal-volume-sphere radius
                     !      /=1 - particle size is specified in terms of the equal-surface-area-sphere radius
  Real*8    :: LAM   ! -    WAVELENGTH OF INCIDENT LIGHT in  um
  Real*8    :: MRR   ! -    real part of the refractive index
  Real*8    :: MRI   ! -    imaginary part of the refractive index
  Integer   :: NP    ! -    shape parameter:
                     !        spheroids NP=-1
                     !        cylinders NP=-2
                     ! -      Chebyshev particles
                     !                  NP>0
                     !                  NP=-3 generalized Chebyshev particles (describing the shape of distorted water drops)
  Real*8    :: EPS   ! -    shape parameter:
                     !        spheroids- the ratio of the horizontal to rotational axes
                     !                (larger than 1 for oblate spheroids and smaller than 1 for prolate spheroids)
                     !        cylinders- the ratio of the diameter to the length 
                     !        Chebyshev particles - the deformation parameter (Ref. 5)
  Real*8    :: DDELT ,DDELT0! -    accuracy of the computations 
  Integer   :: NDGS,NDGS0  ! -    parameter controlling the number of division points      
                           !             in computing integrals over the particle surface (Ref. 5).        
                           !             For compact particles, the recommended value is 2.       
                           !             For highly aspherical particles larger values (3, 4,...) 
                           !             may be necessary to obtain convergence.                  
                           !             The code does not check convergence over this parameter. 
                           !             Therefore, control comparisons of results obtained with  
                           !             different NDGS-values are recommended.
 
 
  Real*8    :: ALPHA   ! - Euler angles (in degrees) specifying the orientation of the scattering particle 
                       !      relative to the laboratory reference frame (Refs. 6 and 7)
  Real*8    :: BETA    ! - Euler angles (in degrees) specifying the orientation of the scattering particle
                       !      relative to the laboratory reference frame (Refs. 6 and 7)
  !
  Real*8    :: THET0   ! - zenith angle of the incident beam in degrees
  Real*8    :: THET    ! - zenith angle of the scattered beam in degrees
  Real*8    :: PHI0    ! - azimuth angle of the incident beam in degrees 
  Real*8    :: PHI     ! - azimuth angle of the scattered beam in degrees  (Refs. 6 and 7)
  COMPLEX*16 ::  S11,S12,S21,S22
  COMPLEX*16 ::  S011,S012,S021,S022
  
  INTEGER   :: NMAX    ! 
  !
  !  parameters 
  !C   Larger and/or more aspherical particles may require larger
  !C   values of the parameters NPN1, NPN4, and NPNG1 in the file
  !C   ampld.par.f.  It is recommended to keep NPN1=NPN4+25 and
  !C   NPNG1=3*NPN1.  Note that the memory requirement increases
  !C   as the third power of NPN4. If the memory of
  !C   a computer is too small to accomodate the code in its current
  !C   setting, the parameters NPN1, NPN4, and NPNG1 should be
  !C   decreased. However, this will decrease the maximum size parameter
  !C   that can be handled by the code.
  
  !    double precision T-matrix code for nonspherical particles
  !    in a fixed orientation: ampld.lp.f, lpd.f, and ampld.par.f
  !
  !C   CALCULATION OF THE AMPLITUDE AND PHASE MATRICES FOR                 
  !C   A PARTICLE WITH AN AXIALLY SYMMETRIC SHAPE                   
  !                                                                       
  !C   This version of the code uses DOUBLE PRECISION variables,          
  !C   is applicable to spheroids, finite circular cylinders,            
  !C   Chebyshev particles, and generalized Chebyshev particles
  !C   (distorted water drops), and must be used along with the 
  !C   accompanying files lpd.f and ampld.par.f.   
    ! 
    ! 
    pi=DACOS(-1.D0)
    !
    Call get_data(status)
    If (status/=0) Then
      write(*,*) 'Exiting !'
      stop
    Endif
    !
    NMAX=-1
    RAT=1.0D0
    NP=-1 !6! -1
    DDELT0=0.001D0  ! recomanded value
    NDGS0=4 !2
    !
    wv=299.7925d0/fr ! mm
    !
    rad_min=r1 *1.d-3 ! mm
    rad_max=r2 *1.d-3 ! mm
    !
    nelev=91
    nelev1=1
    !
    !
    !-------------------------------------------------------
    ! get dial. constant 
    if (phaseID==1) then ! liquid
      !------------------------------
      ! water         um             K
      work=REFWAT(real(wv)*1e3,real(temp))
      workc=dble(work)
      ref_re=dble(real(work))
      ref_im=dble(aimag(work))
      write(*,*) 'c=',work
      write(*,*) ref_re,ref_im
    endif
    !------------------------------
    ! ice
    if (phaseID==2) then ! ice
      work=REFICE(real(wv)*1.e+3,real(temp) )
      workc=dble(work)
      ref_re=dble(real(work))
      ref_im=dble(aimag(work))
      write(*,*) 'c=',work
      write(*,*) ref_re,ref_im
    endif
    !-------------------------------------------------
    if (phaseID==3) then ! ice and air
      work=REFICE(real(wv)*1.e+3,real(temp) )
      !write(*,*) REFICE(real(wv)*1.e+3,real(temp) )
      workc=work
      !
      airc=(1.d0,0.d0)
      rho_p=hdensity ! model value for ice from the input 
      !rho_p=0.1d0 ! for snow
      !rho_p=0.4d0 !graupel
      !rho_p=0.9d0
      rho_ice=0.9167d0
      !
      frac=rho_p/rho_ice
      call mg_refr_indx(airc,workc,(1.d0-frac),frac,cref_mg) ! orrig
      write(*,*) 'cmg=', cref_mg
      ref_re=dble(real(cref_mg))
      ref_im=dble(aimag(cref_mg))
      write(*,*) ref_re,ref_im
    endif
    !
    if (phaseID==4) then ! ice, air and water
      write(*,*) 'FUTURE WORK'
      stop
    endif
    !
    !----------------------------------------------------------
    !------------------------------
    !
    ! filename
    ! 
    if  (fr<10.d0) then
      write(frq_str2,'(f4.1)') fr
      frq_str='0'//Adjustl(Trim(frq_str2))
    else
      write(frq_str2,'(f5.1)') fr
      frq_str=Adjustl(Trim(frq_str2))
    endif
    !
    !-------------------------------------------------------------------------------------------
    !------------------------------------------------------------------------------------------
    ! 
    ielev_start=1   ! 
    ielev_end=nelev !
    ! 
    if (set_elID>0.d0) ielev_end=nelev1 ! create luts for a single value of elev
    !
    do ielev=ielev_start,ielev_end
      ! 
      if (set_elID>0.d0) then ! fixed value of elev
        relev=set_elID
        elev=90.d0-relev
      else 
        elev=90.d0-dble(ielev-1) ! this is angle of the incident beam horizont=90, zenith=0
        ! realev is the real elevation angle from horizonth =0 to zenith=90 degrees
        relev=90.d0-elev
      endif
    
      write(*,*)ielev_start, ielev_end,elev
      write(t_str,'(f5.1)') temp ! K
      !
      if  (relev<10.d0) then
        write(el_str2,'(f4.1)') relev
        el_str='0'//Adjustl(Trim(el_str2))
      else
        write(el_str2,'(f5.1)') relev
        el_str=Adjustl(Trim(el_str2))
      endif
    
      !------------------------------------------------------
      den=hdensity*1.d+3 ! gr/cm^3 --> kg/m^3
      if  (den<1.d0) then
        write(rho_str2,'(f7.4)') den
        rho_str=Adjustl(Trim(rho_str2))
      
      else if ( (den>=1.d0) .and.(den<10.d0))  then
        write(rho_str2,'(f6.3)') den
        rho_str=Adjustl(Trim(rho_str2))
    
      else if ( (den>=10.d0) .and.(den<100.d0))  then
        write(rho_str2,'(f6.2)') den
        rho_str=Adjustl(Trim(rho_str2))
    
      else
        write(rho_str2,'(f7.1)') den
        rho_str=Adjustl(Trim(rho_str2))
      endif
      !--------------------------------------------------------
      ! Trim(adjustl(conf%hydro_luts(isc)))//'_fr'//frq_str//'GHz_'//'t'//t_str//'_rho'//rho_str//'_el'//el_str//'.dat'
    
      ! out file name
      OutFileName=Trim(hydro_type)//'_fr'//frq_str//'GHz_'//'t'//t_str//'_rho'//rho_str//'_el'//el_str//'.dat'
      write(*,*) 'out=', Trim(OutFileName)
    
      open(id,FILE=Trim(OutFileName))
      WRITE(id,*) wv  !in mm
      WRITE(id,*) temp ! K
      WRITE(id,*) ref_re,ref_im
      WRITE(id,*) nr,nelev1
      WRITE(id,*) ''
      THET0=elev ; THET=THET0
      WRITE (id,*) elev,THET ! thata_i , theta_s
      
      !--------------------------------
      do ir =1, nr
        !
        !write(*,*) 'ir=',ir
      
        radius= rad_min+dble(ir-1)/dble(nr-1)*(rad_max-rad_min) ! mm
        !write(*,*)'ir,diam [um]',ir,(2.d0*radius)*1.d+3
        !pause
    
        if (int(axis_ratioID) > 100) then ! different parameterisations
          call get_axis_ratio(radius,axis_ratioID,ax_ratio)
        else ! fixed value
          ax_ratio=Max(1.000001d0,1.d0/axis_ratioID)
        endif
        ! 
        !-----------------------------------------------------------------
        !-----------------------------
        LAM=wv
        AXI=radius
        EPS=ax_ratio
        MRR=ref_re
        MRI=ref_im
        !
        !----------------------------------------------
     
        !do ielev=1,nelev
    
        !elev=90.d0-dble(ielev-1)
        !
        THET0=elev ; PHI0=180D0
        !
        THET=THET0 ; PHI=PHI0
        ALPHA=0D0 ;  BETA=0D0
        DDELT=DDELT0 ; LAM=wv ; NDGS=NDGS0
        ! forward
        call tm_ampld(AXI,RAT,LAM,MRR,MRI,EPS,NP,DDELT,NDGS,NMAX)
        THET=THET0 ; PHI=PHI0
        ALPHA=0D0 ;  BETA=0D0
        call ampl(NMAX,LAM,THET0,THET,PHI0,PHI,ALPHA,BETA,S011,S012,S021,S022)
    
        !
        ! backward
        THET=180D0-THET0  ; PHI=0D0
        IF (THET==180D0) PHI=180D0
        ALPHA=0D0 ;  BETA=0D0
        call ampl(NMAX,LAM,THET0,THET,PHI0,PHI,ALPHA,BETA,S11,S12,S21,S22)
        !----------------------------------------------
        go to 432
          Z11=0.5D0*(S11*DCONJG(S11)+S12*DCONJG(S12) &
              +S21*DCONJG(S21)+S22*DCONJG(S22))
          Z12=0.5D0*(S11*DCONJG(S11)-S12*DCONJG(S12) &
                   +S21*DCONJG(S21)-S22*DCONJG(S22))
          Z13=-S11*DCONJG(S12)-S22*DCONJG(S21)
          Z14=(0D0,1D0)*(S11*DCONJG(S12)-S22*DCONJG(S21))
          Z21=0.5D0*(S11*DCONJG(S11)+S12*DCONJG(S12) &
                    -S21*DCONJG(S21)-S22*DCONJG(S22))
          Z22=0.5D0*(S11*DCONJG(S11)-S12*DCONJG(S12) &
                    -S21*DCONJG(S21)+S22*DCONJG(S22))
          Z23=-S11*DCONJG(S12)+S22*DCONJG(S21)
          Z24=(0D0,1D0)*(S11*DCONJG(S12)+S22*DCONJG(S21))
          Z31=-S11*DCONJG(S21)-S22*DCONJG(S12)
          Z32=-S11*DCONJG(S21)+S22*DCONJG(S12)
          Z33=S11*DCONJG(S22)+S12*DCONJG(S21)
          Z34=(0D0,-1D0)*(S11*DCONJG(S22)+S21*DCONJG(S12))
          Z41=(0D0,1D0)*(S21*DCONJG(S11)+S22*DCONJG(S12))
          Z42=(0D0,1D0)*(S21*DCONJG(S11)-S22*DCONJG(S12))
          Z43=(0D0,-1D0)*(S22*DCONJG(S11)-S12*DCONJG(S21))
          Z44=S22*DCONJG(S11)-S12*DCONJG(S21)
        !
        432 continue
        !
        WRITE (id,*) radius,ax_ratio ! mm
        WRITE (id,*) S011,S022 ! mm
        WRITE (id,*) S11,S12,S21,S22 ! mm
        ! 
      enddo ! ir 
      !
      close(id)
      ! 
    enddo ! ielev 
    
    write(*,*) 'ok'


  Contains
    
  subroutine get_data(status)
    
  integer   :: status
  integer                          :: nargs
  Character(len=80)                :: arg_str
  Character(len=100)               :: error_str1
  Character(len=80)                :: error_str2
  Character(len=80)                :: in_hydro_type
    !
    error_str1='problem in getting data from the input line'
    !
    status=0
    !
    nargs=iargc()
    If (nargs.Ne.10) Then
      status=0
      error_str2='Wrong number of arguments'
       write(*,*) 'nargs',nargs
    Endif
    !
    If (status == 0) Then
      error_str2='Error in output filename specification (1st argument)'
      Call getarg(1,arg_str)
      Read(arg_str,'(a80)',iostat=status,err=100) in_hydro_type
      hydro_type=trim(adjustl(in_hydro_type))
      write(*,*) '1 hydrotype= ',hydro_type
    Endif
    !
    If (status == 0) Then
      error_str2='Error in wavelength (microns) specification (2nd argument)'
      Call getarg(2,arg_str)
      Read(arg_str,'(f8.4)',iostat=status,err=100) fr
      write(*,*) '2 wavelength',fr
    Endif
    !
    If (status == 0) Then
      error_str2='Error in phase specifications (3nd argument)'
      Call getarg(3,arg_str)
      Read(arg_str,'(i2)',iostat=status,err=100) phaseID
      write(*,*) '3 phaseID',phaseID
    Endif
    !
    If (status == 0) Then
      error_str2='Error in temperature(K) -4rd argument'
      Call getarg(4,arg_str)
      Read(arg_str,'(f8.4)',iostat=status,err=100) temp
      write(*,*) '4 temperature',temp
    Endif
   
    If (status == 0) Then
      error_str2='Error in hydr. density (gr/cm^3) -5rd argument'
      Call getarg(5,arg_str)
      Read(arg_str,'(f8.4)',iostat=status,err=100) hdensity
      write(*,*) '5 hdensity',hdensity
    Endif
    !
    If (status == 0) Then
      error_str2='Error in a/b axis ratio -6rd argument'
      Call getarg(6,arg_str)
      Read(arg_str,'(f8.4)',iostat=status,err=100) axis_ratioID
      write(*,*) '6 axis_ratio',axis_ratioID
    Endif
    !
    If (status == 0) Then
      error_str2='Error in starting radius (micron) specification (7th argument)'
      Call getarg(7,arg_str)
      Read(arg_str,'(f8.4)',iostat=status,err=100) r1
      write(*,*) '7 r1=',r1
    Endif
    !
    If (status == 0) Then
      error_str2='Error in stopping radius (micron) specification (8th argument)'
      Call getarg(8,arg_str)
      Read(arg_str,'(f8.4)',iostat=status,err=100) r2
      write(*,*) '8 r2=',r2
    Endif
    !
    If (status == 0) Then
      error_str2='Error number of radii number specification (9th argument)'
      Call getarg(9,arg_str)
      Read(arg_str,'(i6)',iostat=status,err=100) nr
      write(*,*) '9 nr=',nr
    Endif
    !
    If (status == 0) Then
      error_str2='Error in set_elID  (10th argument)'
      Call getarg(10,arg_str)
      Read(arg_str,'(f8.4)',iostat=status,err=100) set_elID
      write(*,*) '10 set_elID=',set_elID
    Endif
    ! 
    100 If (status.Ne.0) Then
      Write(*,*) error_str2
      Write(*,*) error_str1
      Write(*,*)
    Endif
    !
  end subroutine get_data
  ! 
  end program fort_tmatrix
