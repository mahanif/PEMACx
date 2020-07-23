function [MSE, MED] = Exhaustive_Simulations(Adder_Config, Probability_A_bits, Probability_B_bits, Probability_C_in)
    
    % Adder_Config: Configuration of the low-power approximate adder
    % Probability_A_bits: Vector of probabilities of the bits of operand A being 1'b1
    % Probability_B_bits: Vector of probabilities of the bits of operand B being 1'b1
    % Probability_C_in: Probability of C_in being 1'b1
    
    Validate_Inputs(Adder_Config, Probability_A_bits, Probability_B_bits, Probability_C_in)
    
    %% Exhaustive Simulations
    Error_PMF = zeros(1,2^(length(Adder_Config)+1));
    Min_val = -2^(length(Adder_Config));

    for i=0:2^(length(Adder_Config))-1
        for j=0:2^(length(Adder_Config))-1
            for k=0:1
                [out]=Low_Power_Adder(i, j, k , Adder_Config);
                if out~=(i+j+k)
                    P_comb=prod([Probability_A_bits(de2bi(i,length(Adder_Config))==1), (1-Probability_A_bits(de2bi(i,length(Adder_Config))==0)), Probability_B_bits(de2bi(j,length(Adder_Config))==1), (1-Probability_B_bits(de2bi(j,length(Adder_Config))==0)), ([~k k]*[1-Probability_C_in Probability_C_in]')]);
                    Error_PMF((out-(i+j+k))-Min_val+1) = Error_PMF((out-(i+j+k))-Min_val+1) + P_comb;
                end
            end
        end
    end
    
    %% Computing MSE and MED using PMF of Error
    MSE = sum((([Min_val:(length(Error_PMF)+Min_val-1)]).^2) .* Error_PMF);
    MED = sum(abs([Min_val:(length(Error_PMF)+Min_val-1)]) .* Error_PMF);
end