function plotComplexCombineS
    
    load('../struct2.mat','S');
    S2 = S; 
    load('../struct3.mat','S');
    S3 = S;
    load('../struct4.mat','S');
    S4 = S;
    load('../struct5.mat','S');
    S5 =S;
    
    S.complex = [S2.complex, S3.complex, S4.complex, S5.complex];
    
    S.ps = [S2.ps, S3.ps, S4.ps, S5.ps];
    
    plot(S.ps, S.complex,'o', 'MarkerFaceColor', 'b')
    xlabel('Rewiring probability p');
    ylabel('Neural Complexity');
end