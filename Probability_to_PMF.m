function [PMF] = Probability_to_PMF(Indexes, IPM, Err, Sig)
    Err = Err(Indexes);
    IPM = IPM(Indexes);
    PMF = zeros(1,6*Sig + 1);
    for i=1:length(Err)
        PMF(((Err(i)+4)*Sig)-Sig+1) = PMF(((Err(i)+4)*Sig)-Sig+1) + IPM(i); 
    end
end