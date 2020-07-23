function [C_out_p, PMF_00, PMF_01, PMF_10, PMF_11] = Partial_PMF_Computation(I, A_p, B_p, C_in_p, Sig)
A = [0 0 0 0 1 1 1 1]';
B = [0 0 1 1 0 0 1 1]';
C_in = [0 1 0 1 0 1 0 1]';

A_v_p = (A*A_p) + ((~A)*(1-A_p));
B_v_p = (B*B_p) + ((~B)*(1-B_p));
C_in_v_p = (C_in*C_in_p) + ((~C_in)*(1-C_in_p));
IPM = A_v_p .* B_v_p .* C_in_v_p;

switch I
    case 0 % Accurate Full Adder
        C_out = [0 0 0 1 0 1 1 1]';
        Err = [0 0 0 0 0 0 0 0]';
    case 1 % Approximate Full Adder Type 1
        C_out = [0 0 1 1 0 1 1 1]';
        Err = [0 0 1 0 -1 0 0 0]';
    case 2 % Approximate Full Adder Type 2
        C_out = [0 0 0 1 0 1 1 1]';
        Err = [1 0 0 0 0 0 0 -1]';
    case 3 % Approximate Full Adder Type 3
        C_out = [0 0 1 1 0 1 1 1]';
        Err = [1 0 1 0 0 0 0 -1]';
    case 4 % Approximate Full Adder Type 4
        C_out = [0 0 0 0 1 1 1 1]';
        Err = [0 0 -1 -1 1 0 0 0]';
    case 5 % Approximate Full Adder Type 5
        C_out = [0 0 0 0 1 1 1 1]';
        Err = [0 -1 0 -1 1 0 1 0]';
    case 6 % Approximate Full Adder Type 6
        C_out = [0 1 0 1 0 1 0 1]';
        Err = [0 2 0 0 0 0 -2 0]';
    case 7 % Approximate Full Adder Type 7
        C_out = [0 0 0 1 0 1 1 1]';
        Err = [0 0 0 1 0 1 0 0]';
end

C_out_p = sum(C_out .* IPM);

% computing 4 Partial Error PMFs
% C_in = 0 amd C_out = 0
Indexes = find((C_in == 0) & (C_out == 0));
PMF_00 = Probability_to_PMF(Indexes, IPM, Err, Sig);

% C_in = 0 amd C_out = 1
Indexes = find((C_in == 0) & (C_out == 1));
PMF_01 = Probability_to_PMF(Indexes, IPM, Err, Sig);

% C_in = 1 amd C_out = 0
Indexes = find((C_in == 1) & (C_out == 0));
PMF_10 = Probability_to_PMF(Indexes, IPM, Err, Sig);

% C_in = 0 amd C_out = 0
Indexes = find((C_in == 1) & (C_out == 1));
PMF_11 = Probability_to_PMF(Indexes, IPM, Err, Sig);

end