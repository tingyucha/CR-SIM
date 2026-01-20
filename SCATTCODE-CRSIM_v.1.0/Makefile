#
SHELL = /bin/bash
#================
# tejas
#
NC_INCLUDE=
NC_LIB=
#
DEBUG := yes
OPENMP := no
#
# Compiler Flags
FC=gfortran
#FFLAGS=-g -C
FFLAGS=-g -C -O3 -fbacktrace 
 #-Wextra -fbounds-check -fbacktrace
#-----------------------------------
#
MODS=
OBJ=fort_tmatrix.o ampld.lp.o lpd.o s_ref_ind_water.o\
    s_refice.o smax_garn.o axis_ratio.o

fort_tmatrix : ${MODS} ${OBJ}
	${FC} ${FFLAGS} ${MODS} ${OBJ} \
	-o fort_tmatrix
#
fort_tmatrix.o: ampld.lp.o lpd.o s_ref_ind_water.o s_refice.o smax_garn.o axis_ratio.o fort_tmatrix.f90
	${FC} ${FFLAGS} -c fort_tmatrix.f90
#
ampld.lp.o: lpd.o ampld.lp.f
	${FC} ${FFLAGS} -c ampld.lp.f

lpd.o: lpd.f
	${FC} ${FFLAGS} -c lpd.f
#
s_ref_ind_water.o: s_ref_ind_water.f
	${FC} ${FFLAGS} -c s_ref_ind_water.f
#
s_refice.o: s_refice.f
	${FC} ${FFLAGS} -c s_refice.f
#
smax_garn.o: smax_garn.f90
	${FC} ${FFLAGS} -c smax_garn.f90
#
axis_ratio.o: axis_ratio.f90
	 ${FC} ${FFLAGS} -c axis_ratio.f90
#
clean:
	rm -f *.o
	rm -f *.mod
	rm -f fort_tmatrix
#
