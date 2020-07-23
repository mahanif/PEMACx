function [out]=Low_Power_Adder(in1, in2, C_in , apx_adder_type_array) %#codegen

len = length(apx_adder_type_array);
in1_bits = de2bi(in1,len);
in2_bits = de2bi(in2,len);

out_bi = de2bi(0,len+1);
C_out = C_in;
for i=1:len
    A=logical(in1_bits(i));
    B=logical(in2_bits(i));
    C_in=C_out;
    
    switch apx_adder_type_array(i)
        case {0} % Accurate Full Adder
            out_bi(i)=((~xor(A,B)) && C_in) || (xor(A,B) && (~C_in));
            C_out=(A && B) || (B && C_in) || (A && C_in);
        case {1} % Approximate Full Adder Type 1
            out_bi(i)=((~xor(A,B)) && C_in);
            C_out=B || (A && C_in);
        case {2} % Approximate Full Adder Type 2
            C_out=(A && B) || (B && C_in) || (A && C_in);
            out_bi(i)=~C_out;
        case {3} % Approximate Full Adder Type 3
            C_out=B || (A && C_in);
            out_bi(i)=~C_out;
        case {4} % Approximate Full Adder Type 4
            out_bi(i)=C_in && ((~A) || B);
            C_out=A;
        case {5} % Approximate Full Adder Type 5
            out_bi(i)=B;
            C_out=A;
        case {6} % Approximate Full Adder Type 6
            out_bi(i)=((~xor(A,B)) && C_in) || (xor(A,B) && (~C_in));
            C_out=C_in;
        case {7} % Approximate Full Adder Type 7
            out_bi(i)=xor(A,B) || C_in;
            C_out=(A && B) || (B && C_in) || (A && C_in);
    end
end

out_bi(length(apx_adder_type_array)+1)=C_out;
out=bi2de(out_bi);
end