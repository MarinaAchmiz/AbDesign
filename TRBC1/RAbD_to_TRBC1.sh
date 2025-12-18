#!/usr/bin/env bash
set -e
# Relax of input structure
$ROSETTA_m/source/bin/relax.static.linuxgccrelease \
  -database /mnt/san01/data/m.r.achmiz/Rosetta/rosetta.binary.linux.release-371/main/database \
  -in:file:s /mnt/san01/data/m.r.achmiz/bcma/7AMP_AHo_agab.pdb \
  -out:path:pdb /mnt/san01/data/m.r.achmiz/bcma/relax \
  -out:path:score /mnt/san01/data/m.r.achmiz/bcma/relax \
  -relax:fast
$ROSETTA_m/source/bin/antibody_designer.static.linuxgccrelease \
  -s 7AMP_AHo_agab_0001.pdb  \
  -graft_design_cdrs L1 L2 L3 H1 H2 \
  -seq_design_cdrs L1 L2 L3 H1 H2 H3 \
  -light_chain kappa \
  -mc_optimize_dG \
  -do_dock \
  -use_epitope_constraints \
  -epitope 119B 120B \
  -design_framework  \
  -nstruct 2000 \
  -random_start \
  -out:prefix ab
