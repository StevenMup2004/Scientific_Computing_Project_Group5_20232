## Introduction

This project provides implementations for solving the heat equation for a 2D plate using various iterative methods. The methods included are:

- Jacobi Iterative Method
- Gauss-Seidel Iterative Method
- Successive Over-Relaxation (SOR) Method with 5-point and 9-point 

These methods are used to compute the temperature distribution on a 2D plate with given boundary conditions.

## Installation

Ensure you have MATLAB installed on your system.

## Usage
1, Code_Group5.m
- This code solves the heat equation for a 2D plate using the Jacobi and Gauss-Seidel methods, as well as the Successive Over-Relaxation (SOR) method with 5-point and 9-point method. It includes plotting the results about temperature variation on plate, and reporting the computation time , the number of iterations and the error changes for each method.

- Steps to run:
      + Open Code_Group5.m in MATLAB.
      + Run the script to compute the temperature distribution on the plate.

Description:
The script initializes the temperature distribution on a 2D plate and iteratively solves the heat equation until the specified error tolerance is met. It then plots the temperature variation on the plate.

2, find_SOR_omega_5point.m
- This script finds the optimal relaxation factor (omega) for the SOR method using a 5-point.

- Steps to run:
     + Open find_SOR_omega_5point.m in MATLAB.
     + Run the script to find the optimal omega and plot the number of iterations required for   different omega values.

- Description:
The script iteratively adjusts the relaxation factor (omega) to find the optimal value that minimizes the number of iterations required to solve the heat equation using the SOR method with a 5-point method.

3, find_SOR_omega_9point.m
- This script finds the optimal relaxation factor (omega) for the SOR method using a 9-point.

- Steps to run:
    + Open find_SOR_omega_9point.m in MATLAB.
    + Run the script to find the optimal omega and plot the number of iterations required for different omega values.
- Description:
The script iteratively adjusts the relaxation factor (omega) to find the optimal value that minimizes the number of iterations required to solve the heat equation using the SOR method with a 9-point method.
