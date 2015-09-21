function NeuralComplexityTrials(trialsNum, Tmax, plotResult)

    ps = zeros(1, trialsNum);
    complexities = zeros(1, trialsNum);
    
    for i = 1:trialsNum
        p = rand() / 2;
        
        ps(i) = p;
        
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

function plotComplex
    load('struct.mat','S');
    plot(S.complex, S.ps, 'o', 'MarkerFaceColor', 'b')
    xlabel('Rewiring probability p');
    ylabel('Neural Complexity');
end