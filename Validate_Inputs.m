function Validate_Inputs(Adder_Config, Probability_A_bits, Probability_B_bits, Probability_C_in)
    if any(Adder_Config > 7) || any(Adder_Config < 0) || any(mod(Adder_Config,1)) 
        error('Adder Configuration is not correct');
    end
    if any(Probability_A_bits > 1) || any(Probability_A_bits < 0)
        error('Probabilities of the bits of operand A are not correctly defined');
    end
    if any(Probability_B_bits > 1) || any(Probability_B_bits < 0)
        error('Probabilities of the bits of operand B are not correctly defined');
    end
    if any(Probability_C_in > 1) || any(Probability_C_in < 0)
        error('Probabilities of the bits of operand A are not correctly defined');
    end
    if numel(Probability_C_in) ~= 1
        error('Probability of Cin should be a single element')
    end
    if numel(Probability_A_bits) ~= numel(Adder_Config)
        error('Length of the probability vector of operand A should be equal to the length of the adder configuration');
    end
    if numel(Probability_B_bits) ~= numel(Adder_Config)
        error('Length of the probability vector of operand B should be equal to the length of the adder configuration');
    end
end