# Replication package - 'Clean innovation, heterogeneous financing constraints, and the optimal climate policy mix'

This repository contains the code and material for Campiglio, E., Spiganti, A., Wiskich, A. (2024) 'Clean innovation, heterogeneous financing constraints, and the optimal climate policy mix', published in the Journal of Environmental Economics and Management 128 (103071). The article is available open-access at [this link](https://doi.org/10.1016/j.jeem.2024.103071).

The code should be run on Matlab:
- main.m is the main program file, containing the model structure.
- runsims.m runs various simulations using the main program file main.m. This is the file you should run to obtain results. All combination of scenarios, policies and sensitivity analyses are active. Comment out the ones you do not want to run. 
- Mysimopt.m contains code that solves each individual period.
- Results.mat stores output.
- figure_main creates all the figures contained in the paper.

Please feel free to get in contact for any comment or suggestion: 
- Emanuele Campiglio: emanuele.campiglio@unibo.it
- Alessandro Spiganti: alessandro.spiganti@unive.it
- Anthony Wiskich: tony.wiskich@anu.edu.au
