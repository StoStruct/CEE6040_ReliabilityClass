# Reliability class codes
This repository contains coding excercises of class examples for CEE6040:"_Probabilistic modeling and reliability analysis_" by Dr. Mohsen Zaker Esteghamati. 

## Example 1: Hasofer-Lindt implementation
The HL_class_example.m is a MATLAB file to solve HL implementation for the limit state g(x<sub>1</sub>,x<sub>2</sub>) = x<sub>1</sub><sup>2</sup>-3x<sub>2</sub> when X<sub>1</sub> and X<sub>2</sub> have the following moments: </br>
μ<sub>X1</sub> = 10, σ<sub>X1</sub> = 20 </br>
μ<sub>X2</sub> =20, σ<sub>X1</sub> = 5  </br>
ρ<sub>X1,X2</sub> =0.5

## Example 2: FORM implementation
The FORM_class_example.m is a MATLAB file to solve first-order reliability implementation for the limit state g(x<sub>1</sub>,x<sub>2</sub>) = 2x<sub>1</sub><sup>1/3</sup>-x<sub>2</sub> when X<sub>1</sub> and X<sub>2</sub> have the following moments: </br>
- X<sub>1</sub> is a lognormal with mean of 600 and standard deviation of 300.
- X<sub>2</sub> is Raleigh with b = 3.
