This tools allow to build PA itp and cg files for MARTINI simulations.

We first generate the atomistic pdb file in the folder atomistic/. VMD is necessary to use this tool.

Then, we use this to to the CG in the folder coarsegrained/

Please mind that you will need to modify some of the files, so copy them to each new PA folder before modifications.

Note that this is only for C16 tails, here called PAM, as it is a palmitoyl.

ATOMISTIC

1) In the file PA_generic.pdb, modify each residue name to the target residues:

For example, if your sequences is: C16-VVAAEE

sed -i "s/AAA/VAL/g" PA_generic.pdb

sed -i "s/BBB/VAL/g" PA_generic.pdb

sed -i "s/CCC/ALA/g" PA_generic.pdb

sed -i "s/DDD/ALA/g" PA_generic.pdb

sed -i "s/EEE/GLU/g" PA_generic.pdb

sed -i "s/FFF/GLU/g" PA_generic.pdb

2) modify sliptPAs-1_decapeptide.tcl to include the correct number of residues.

Currently, prepared for a decapeptide it states resid 1 to 11. For the example above, hexapeptide, it needs to be 1 to 7 (one more because of the C16)

3) modify gen_PA_1.pgn if you need COOH C-terminus. otherwise do not change it.

For COOH terminus, change:   last CT2 --> to --> last CTER

4) in VMD, TKConsole:

source splitPAs-1_decapeptide.tcl
source gen_PA_1.pgn

The pdb file should be created with the name: C16-ABCDEFGHIJ_gen.pdb

5) Please modify the name to the appropriate one.

Your pdb is ready to martinize

COARSE-GRAINED MARTINIZE

1) use the command:

./martinize_PAs-C16.py -f PA.pdb -o PA.top -x PA_cg.pdb -ff martini22 -nt -ss CCCCCCCCCCCCCCC

*make sure that you have at least as many Cs as amino acids plust one (as the C16 is also considered an amino acid)

2) Modify Protein_A.itp:

	a) First Backbone-side chain angle (it is 100, but must be 180 as the alyphatic tail is not on the side but goes in the same line that the backbone):

	2	1	5	2	180	25	; PAM(C)-GLU(C) SBB

	b) If you have a COOH C-terminus only (we often have amidated ones and this is not required): Modify Last P5 type to terminal bead, usually:

	NN-sc    Qa     5   VAL    BB    11  -1.0000 ; C


ADDITIONAL INSTRUCTION FOR CHARGE TUNING:

Most of PA systems like C16VVAAEE require neutralization of some E side chains. E side chains are negatively charged, and we know that if all Es are charged the system does not self-assemble. Thus, supported by experimental evidences, we need to create variants with neutralized charges (and often we assess the effect of the different possibilities in self-assembly).

For example we will have our C16-VVAAEE_-2 folder that we will copy to create the C16-VVAAEE_-1 (if you want we can also do 0)

We reduce the charge of PAs by modifying charge residues in order (lower number = more internal, first).

For E, at the corresponding line of the side chain bead SC1:

Qa      --> P1
-1.0000 --> 0.0000

For K, at the corresponding line of the side chain bead SC2:

Qd      --> P1
 1.0000 --> 0.0000

** These protocol was created by Ivan Sasselli, CSIC researcher at Materials Physics Center (CFM) in Donostia-San Sebastian (Spain).
The protocol was refined by Irene Carbajo (CFM) and Fernanda Campos (Federal University of Goias (UFG), Brazil)
