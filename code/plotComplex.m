function plotComplex
    load('struct.mat','S');
    plot(S.ps, S.complex, 'o', 'MarkerFaceColor', 'b')
    xlabel('Rewiring probability p');
    ylabel('Neural Complexity');
end