import sys
import pymol
from pymol import cmd

#Weirdly the PDB file itself is not re-ordered unless you read it in and resave it...
cmd.load(sys.argv[1])
cmd.save(sys.argv[1])
cmd.quit()