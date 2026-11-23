mol load pdb PA_generic.pdb
set s1   [atomselect top "resid    1    2    3    4    5    6    7    8    9   10   11"]

$s1   writepdb a-001.pdb