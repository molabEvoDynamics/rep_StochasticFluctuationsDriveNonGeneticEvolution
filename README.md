# Discrete approach -- Stochastic fluctuations drive non-genetic evolution of proliferation in clonal cancer cell populations
![image](https://user-images.githubusercontent.com/55539283/120374826-55253580-c31a-11eb-999c-72adb2b4264a.png)

In this repository you can find the code files for the discrete simulations of the preprint "Stochastic fluctuations drive non-genetic evolution of proliferation in clonal cancer cell populations" in which we explore de role of phenotypic plasticity affecting proliferation in tumor evolution.
There we show the result for two different scenarios: (i) the case in which phenotypic modifications are permanent and passed by mitosis and (ii) another case in which these modifications are reversible after a certain number of cell divisions. 
You will find the following files: 
- `parameters.m`. All parameters for the model must be modified in this file when neccesary. Data structures to store the results are also defined here. 
- `main_inheritableScenario.m` and `main_partialInheritableScenario.m`. Core files for the permanent and transitory phenotypic modifications scenarios respectively. 
- `dataProc.m`. Calculate mean values for all replicates and all variables of interest. 
- `plots.m`. Plot the results of the simulation. 
- `binormal.m`. Binormal approximation to normal distribution when cell number is high enough to save computational cost. 

During normal use all these files must be located at the same directory but you just need to run the core files (`main_inheritableScenario.m` and `main_partialInheritableScenario.m`). 

