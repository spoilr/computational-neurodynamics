function Wire_EXC_INH()
    
    globalVariable();
    load('Network.mat','layer');
    
    ArrayIndex = [];
    for i = 1:MODULES     
        tmpArray = randperm(EXCITATORY_NEURONS) + EXCITATORY_NEURONS*(i-1);
        ArrayIndex = [ArrayIndex, tmpArray];    
    end
    ArrayIndex = reshape(ArrayIndex, EXC_INH_CON, INHIBITORY_NEURONS);

    neurons = randperm(200);
    for i = 1:numel(neurons)
        target = neurons(i);
        sourceGroup = ArrayIndex(:, i); 
        layer{INH}.S{EXC}(target, sourceGroup) = 1;
    end
    
    save('Network.mat','layer');
end
