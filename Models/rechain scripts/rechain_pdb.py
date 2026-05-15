import sys
import pymol
from pymol import cmd
#cmd.load("ranked_0.pdb")
cmd.load(sys.argv[1]) #this loads in the first arg as your input pdb

# relabel all chains W,X,Y,Z

model_list = cmd.get_object_list()
all_chains = cmd.get_chains(model_list[0])

for i,chain in enumerate(all_chains):
  cmd.alter(f"chain {chain}",f"chain='{chr(87 +i)}'")

# change W back to A
cmd.alter(f"chain W",f"chain = 'A'")
  
  
#Make sure B is neighbor to A
cmd.select("chainA","chain A and (resid 136-155 or resid 183-205)")
cmd.select("neighbors", "byres chainA around 3 and not chain A")

chain_list = cmd.get_chains("neighbors")

cmd.alter(f"chain {chain_list[0]}", "chain='B'")

if len(chain_list) > 0:
   target_chain = chain_list[0]
   cmd.alter(f"chain {target_chain}", "chain='B'")

#Make sure C is neighbor to B
cmd.select("chainB","chain B and (resid 136-155 or resid 183-205)")
cmd.select("neighbors", "byres chainB around 3 and not chain B")

chain_list = cmd.get_chains("neighbors")

cmd.alter(f"chain {chain_list[0]}", "chain='C'")

if len(chain_list) > 0:
   target_chain = chain_list[0]
   cmd.alter(f"chain {target_chain}", "chain='C'")
   
   
#Make sure D is neighbor to C
cmd.select("chainC","chain C and (resid 136-155 or resid 183-205)")
cmd.select("neighbors", "byres chainC around 3 and not chain C")

chain_list = cmd.get_chains("neighbors")

cmd.alter(f"chain {chain_list[0]}", "chain='D'")

if len(chain_list) > 0:
   target_chain = chain_list[0]
   cmd.alter(f"chain {target_chain}", "chain='D'") 

cmd.save(sys.argv[2]) #this outputs your pdb as the name given as the second arg (note defined in bash file as into rechain folder)

cmd.quit()

