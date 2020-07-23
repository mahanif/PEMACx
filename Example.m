% Example
clear all
close all
clc

Adder_Config = [1 7 2 3 0 0 0 0]; % Adder Configuration (LSB to MSB): 1 value for each full adder at the corresponding location and each value should be between 0 and 7 
Probability_A_bits = ones(1,8)*0.5; % Vector of probabilities of the bits of operand A being 1'b1
Probability_B_bits = ones(1,8)*0.5; % Vector of probabilities of the bits of operand B being 1'b1
Probability_C_in = [0.5]; % Probability of C_in being 1'b1

%% Computing MSE and MED using PEMACx
[MSE, MED] = PEMACx(Adder_Config, Probability_A_bits, Probability_B_bits, Probability_C_in)

%% Computing MSE and MED using Exhaustive Simulations
[MSE_Ex, MED_Ex] = Exhaustive_Simulations(Adder_Config, Probability_A_bits, Probability_B_bits, Probability_C_in)