# Scripts for four-helix bundle design for voltage-gated sodium channel engineering

## Description

This directory contains RosettaScripts scripts that were used to design artificial coiled-coil domains.

##  Authors of the scripts in this directory

```
Vikram K. Mulligan, Ph.D.
Research Scientist
Co-head, Biomolecular Design Group
Center for Computational Biology
Flatiron Institute
vmulligan@flatironinstitute.org
```

```
Mahsa Mofidi
Flatiron Research Fellow
Structural and Molecular Biophysics Group
Center for Computational Biology
Flatiron Institute
mmofidi@flatironinstitute.org
```

## Design script

The file `inputs/design_fourhelix_bundle.xml` contains the RosettaScripts protocol used to design a C4-symmetric four-helix bundle.  Briefly, the series of steps that this performs are:

* Sampling coiled-coil conformations using a single helix with the Crick parameterization, varying bundle radius (r0), bundle twist (omega0), and helical roll (delta-omega1).
* Duplication of the initial helix to build C4 symmetry.
* Constraining the amino acid composition with `aa_composition` constraints to promote a polar surface and hydrophobic core and to limit methionines, alanines, and aromatics.
* Constraining the net charge with `netcharge` constraints to promote mildly negative designs to avoid toxicity.
* `FastDesign` with the above two guidance terms, plus `voids_penalty` to discourage interfacial voids, `buried_unsatisfied_penalty` to discourage buried hydrogen bonding groups lacking hydrogen bonds, and `hbnet` to encourage hydrogen bond networks.
* Geometry optimization with RosettaQM calling out to GAMESS to perform quantum chemistry calculations using the DFTB semi-empirical method, with the fragment molecular orbital (FMO) approximation.
* Computation of seven metrics:
    1. The number of buried unsatisfied hydrogen bond donors and acceptors.
    2. The shape complementarity between helices.
    3. The cavity volume at the helix-helix interface.
    4. The change in Rosetta `ref2015` score from the complex to the separated helices.
    5. The change in RosettaQM DFTB/FMO score from the complex to the separated helices.
    6. The change in RosettaQM DFTB/FMO score + `ref2015` solvation terms (`fa_sol`, `fa_intra_sol_xover4`, and `lk_ball_wtd`) from the complex to the separated helices.
    7. The total `ref2015` score of the complex.
* Identification of the Pareto-optimal designs across the entire design pool based on the above 7 metrics.

## Additional files
The `inputs/` directory contains additional files:

* `C4_denovo.symm` -- The symmetry definition file for C4 symmetry.
* `dummy.fasta` -- "Dummy" inputs for RosettaScripts.  These are discarded immediately since we are generating backbones _de novo_.
* `global.charge` -- Global net charge constraints requiring a weakly negative overall charge.
* `rosettascripts.xsd` -- The XML schema definition for the RosettaScripts language, used for IDEs to faciliate editing RosettaScripts XML code.
* Composition constraints:
    * `design_boundary.comp` -- Amino acid composition constraints for the boundary layer.
    * `design_core.comp` -- Amino acid composition constraints for the core layer.
    * `design_surface.comp` -- Amino acid composition constraints for the surface layer.
* Rosetta flags files:
    * `rosetta.flags` -- Commandline options for running the design script.
    * `rosetta2.flags` -- Commandline options for running the analysis script.
* Design scripts:
    * `design_fourhelix_bundle.xml` -- The full design and analysis pipeline.
    * `analysis.xml` -- The analysis pipeline, permitting separate analysis after design.

The `ouputs/` directory contains `design_outputs.tgz`, which has all designs produced for the Zavala-Custodio _et al._ study.

The `gamess_io/` directory is a scratch directory for quantum chemistry calculations queued by the RosettaQM bridge.

The `clean.sh` script removes output from an aborted design run.

The `submit_mpi.sh` script is a Slurm submission script that queues MPI-parallelized execution of many design script instances in parallel.  It will likely need to be modified to run on clusters other than the Flatiron Institute's Iron cluster.
