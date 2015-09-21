function NeuralComplexityTrials(trialsNum, Tmax, plotResult)

    ps = zeros(1, trialsNum);
    complexities = zeros(1, trialsNum);
    
    for i = 1:trialsNum
        % probability between 0.1 and 0.5
        p = (0.4) * rand() + 0.1;
        
        ps(i) = p;
        Connect();

        means = PerformSimulation(p, Tmax, 1001, false);
        
        complexity = NeuralComplexity(means);
        
        complexities(i) = complexity;
        
        sprintf('Trial %d', i)
        
    end

    S.complex = complexities;
    S.ps = ps; 
    save('struct.mat','S');

    if plotResult
       plotComplex(); 
    end
    
end
