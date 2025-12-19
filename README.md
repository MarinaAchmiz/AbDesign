# AbDesign
## Overview

This repository contains the code and scripts for a master's thesis on computational antibody design using RosettaAntibodyDesign (RAbD).  
The main goal is to develop a pipeline for de novo computational design of single-chain variable fragments (scFv).

### Objectives
1. Construct a reusable pipeline and identify an appropriate set of tools for de novo scFv design.  
2. Apply the pipeline to design scFv targeting CD19.  
3. Test the developed approach by designing scFv against additional targets, including BCMA and the T cell receptor beta chain.

## Methods overview
This repository implements a RosettaAntibodyDesign (RAbD)–based pipeline for de novo design of single-chain variable fragments (scFv) against several targets (CD19, BCMA, TRBC1, TRBC2).  
For each target, an antibody–antigen complex was selected from the PDB (when possible a therapeutic or closely related antibody) and used as a structural template for design.

The Fv region of each template antibody was renumbered to the AHo-scheme using AbNum (Chothia numbering) followed by Rosetta's `antibody_numbering_converter`, structurally aligned back onto the original complex in PyMOL, and saved together with the antigen as a single input PDB file.  
All complexes were preprocessed using Rosetta FastRelax (relax:fast) to resolve steric clashes and obtain energetically optimized starting models.

RAbD was then run de novo with sequence and graft design of all six CDRs, framework design, docking, and binding energy optimization.  
For each template (7URV for CD19; 8QYA for BCMA; 7AMP for TRBC1; 7AMS for TRBC2), (nstruct = 2000), and designs with the lowest interaction Rosetta energy were selected for downstream analysis.

To maintain epitope specificity for BCMA (8QYA) and TRBC1/TRBC2 (7AMP/7AMS), epitope constraints (`use_epitope_constraints`) were applied so that the antibody remained near the relevant surface residues during design and docking.  
For long and flexible CDRH3 loops (e.g., in 7AMP/7AMS), GraftDesign for H3 was optionally disabled to improve run stability and increase the number of successful designs.

Note: Although designs were also generated for TRBC2, molecular dynamics simulations indicated that these variants were not stable. Hence, TRBC2 designs are not included in the final analysis.

## Key outcomes

The pipeline was tested on three oncology targets: CD19, BCMA, and the T cell receptor beta chain.

- For CD19, the designed scFv reproduced the reference binding mode and stability in MD simulations while forming new interactions at the interface.  
- For the TCR beta chain, the selected design showed stable and specific contacts with the TRBC1 epitope in MD simulations.  
- For BCMA, the best scFv design achieved lower binding energy and more intermolecular contacts compared to the reference antibody, with comparable or improved structural stability.

Overall, the pipeline produced scFv candidates that are suitable for further experimental validation.
