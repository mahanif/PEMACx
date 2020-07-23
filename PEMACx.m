function [MSE, MED] = PEMACx(Adder_Config, Probability_A_bits, Probability_B_bits, Probability_C_in)

    % Adder_Config: Configuration of the low-power approximate adder
    % Probability_A_bits: Vector of probabilities of the bits of operand A being 1'b1
    % Probability_B_bits: Vector of probabilities of the bits of operand B being 1'b1
    % Probability_C_in: Probability of C_in being 1'b1

    Validate_Inputs(Adder_Config, Probability_A_bits, Probability_B_bits, Probability_C_in)

    %% Computing the Error PMF
    for i=1:length(Adder_Config)
        A_p = Probability_A_bits(i);
        B_p = Probability_B_bits(i);
        I = Adder_Config(i);
        Sig = 2^(i-1);
        if i==1
            C_in_p = Probability_C_in;
        else
            C_in_p = C_out_p;
        end
        [C_out_p, PMF_00, PMF_01, PMF_10, PMF_11] = Partial_PMF_Computation(I, A_p, B_p, C_in_p, Sig);
        if i==1
            PMF_0 = PMF_00 + PMF_10;
            PMF_1 = PMF_01 + PMF_11;
            Min_val = -3;
        else
            PMF_0_new = conv(PMF_00,PMF_0)+conv(PMF_10,PMF_1);
            PMF_1 = conv(PMF_01,PMF_0)+conv(PMF_11,PMF_1);
            PMF_0 = PMF_0_new;
            Min_val = Min_val + ((-3)*Sig);
        end
        if i~=length(Adder_Config)
            PMF_0 = PMF_0/sum(PMF_0);
            PMF_1 = PMF_1/sum(PMF_1);
        end
    end

    PMF = PMF_0 + PMF_1;
    
    %% Computing MSE and MED using Error PMF
    MSE = sum((([Min_val:(length(PMF)+Min_val-1)]).^2) .* PMF);
    MED = sum(abs([Min_val:(length(PMF)+Min_val-1)]) .* PMF);

end