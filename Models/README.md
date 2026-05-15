## Models and scripts for relabeling chains

- Top models and all 25 models can be found in their respective folders.
- Because AF2 did not consistently label chains A / C as  opposing chains and B / D as opposing chains, which was a critical assumption in some of our analysis scripts, all models (with the exception of most `825-BacNavs`) had their chains re-assigned so that this is a valid assumption. These re-labeling scripts, which use `pymol` are in the `rechain scripts` directory.
