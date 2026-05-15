## Scripts and commands to build BacNav sequence library

1) **CDhit input**: To run cd-hit and get rid of redundant sequences that were 90% similar use the command:
```
./cd-hit -i input/vgsc-raw.fasta -o output/vgsc-raw.fasta -c 0.90
```
2) **BacNav Sequence Filtering:** The notebook `Bacnav_Sequence_Filtering.ipynb` walks through how to obtain taxonomic information of CD-hit results.
3) **Environmental Data Retrieval**: The notebook `Additional_Environmental_Distribution Analysis.ipynb` walks through how to use Bacdive and the NCBI to obtain environmental information from various datasets. It integrates data sources to provide a comprehensive environmental context.
4) **Additional Environmental Distribution Analysis**: The notebook `Additional_Environmental_Distribution_Analysis.ipynb` uses data found from the BacDive to view the environmental distribution of entries:
5) **Creating a Phylogenetic Tree**: The notebook `Bacnav_Phylotree.ipynb` uses data from the GTDB to create a phylogenetic tree.