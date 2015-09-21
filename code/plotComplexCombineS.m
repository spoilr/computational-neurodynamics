function plotComplexCombineS (nameFiles)
% plotComplexCombineS combines ans plots the S of the files contained in the cell of string nameFiles and plot 
    tmpS.ps = [];
    tmpS.complex= [];

    
    for i=1:length(nameFiles)
       % load S and add it to the global S tmpS
       load(nameFiles{i}, 'S');
       tmpS.ps = [tmpS.ps, S.ps];
       tmpS.complex = [tmpS.complex, S.complex];
    end

    S.complex = tmpS.complex;
    S.ps = tmpS.ps;
    
    save('structFinal.mat', 'S');
    plot(S.ps, S.complex,'o', 'MarkerFaceColor', 'b')
    xlim([0.1 0.5]);
    xlabel('Rewiring probability p');
    ylabel('Neural Complexity');
end