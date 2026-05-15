#!/bin/bash

for i in {0..24}
do
	python3 rechain_pdb.py ranked_${i}.pdb rechain/model_${i}.pdb
done