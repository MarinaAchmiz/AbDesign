#!/usr/bin/env bash
set -e
# Relax of input structure
$ROSETTA_m/source/bin/relax.static.linuxgccrelease \
  -database /mnt/san01/data/m.r.achmiz/Rosetta/rosetta.binary.linux.release-371/main/database \
  -in:file:s /mnt/san01/data/m.r.achmiz/abvscd19/7urv/7urv_aho_nolinker_withcd19.pdb \
  -out:path:pdb /mnt/san01/data/m.r.achmiz/abvscd19/7urv/relax \
  -out:path:score /mnt/san01/data/m.r.achmiz/abvscd19/7urv/relax \
  -relax:fast
$ROSETTA_m/source/bin/antibody_designer.static.linuxgccrelease \
  -s /mnt/san01/data/m.r.achmiz/abvscd19/7urv/relax/7urv_aho_nolinker_withcd19_0001.pdb \
  -graft_design_cdrs L1 L2 L3 H1 H2 H3 \
  -seq_design_cdrs   L1 L2 L3 H1 H2 H3 \
  -light_chain kappa \
  -mc_optimize_dG \
  -do_dock \
  -design_framework \
  -nstruct 2000 \
  -random_start \
  -out:prefix 7urv_ref2015
