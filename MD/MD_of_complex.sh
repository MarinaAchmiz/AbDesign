#!/bin/bash
exec > >(tee log.txt) 2>&1
grep -v HETATM input/complex_of_ab_ag.pdb > proteins_tmp.pdb
grep -v CONECT proteins_tmp.pdb > proteins.pdb
gmx pdb2gmx -f proteins.pdb -o proteins_processed.gro -water spce -ff "charmm27" -ignh
gmx editconf -f proteins_processed.gro -o proteins_newbox.gro -c -d 1.0 -bt octahedron
gmx solvate -cp proteins_newbox.gro -cs spc216.gro -o proteins_solv.gro -p topol.top
touch ions.mdp
gmx grompp -f ions.mdp -c proteins_solv.gro -p topol.top -o ions.tpr

printf "SOL\n" | gmx genion -s ions.tpr -o proteins_solv.gro -conc 0.15 -p \
topol.top -pname NA -nname CL -neutral
gmx grompp -f input/emin-charmm.mdp -c proteins_solv.gro -p topol.top -o em.tpr -maxwarn 1
gmx mdrun -v -deffnm em
printf "Potential\n0\n" | gmx energy -f em.edr -o potential.xvg -xvg none
gmx grompp -f input/nvt-charmm.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr
gmx mdrun -ntmpi 1 -v -deffnm nvt
echo "Temperature" | gmx energy -f nvt.edr -o temperature.xvg -xvg none -b 20
gmx grompp -f input/npt-charmm.mdp -c nvt.gro -r nvt.gro -t nvt.cpt -p topol.top -o npt.tpr
gmx mdrun -ntmpi 1 -v -deffnm npt
echo "Pressure" | gmx energy -f npt.edr -o pressure.xvg -xvg none
gmx grompp -f input/md-charmm_100ns.mdp -c npt.gro -t npt.cpt -p topol.top -o md.tpr
