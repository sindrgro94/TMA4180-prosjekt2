# TMA4180-prosjekt2
The main functions are:
- Augmentet_Lagrangian, solving the first problem without inequality constraints.
- BC_Augmented_Lagrangian, solving the second problem with inequality constraints.
- configSpaceGeneral, wich draws the configuration space for an arm with:
    - L = vector with arm lengths
    - c = angular constraint
    - p = 2xs matrix with x and y values for points.
    - plotOrNot as true if you want to make a plot
    - countdown as true if you want to get a countdown each 5 percent.
This function is not recommended to run with more than 4 arms because of the exponential grow.


demonstration.m is a script where each function can be ran seperately. More comments are in that script.