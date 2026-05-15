#!/bin/bash

for i in {0..24}
do
	python3 resave.py model_${i}.pdb
done