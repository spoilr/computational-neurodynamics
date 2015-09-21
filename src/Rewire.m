function [] = Rewire(p)
%Rewire(p) update the variable layer to rewrire with the probability p the wires of each single module EXC to create connexion between modules  
     load('Network.mat','layer');
     
     %find the indeces of all wires
     [i, j] = find(layer{1}.S{1} == 1);
     
     for idx = 1:length([i,j])
        prob = rand();
        if (prob < p)
            % the current connexion is removed
            layer{1}.S{1}(i(idx),j(idx)) = 0; 
            
            % find the current module
            currModule = fix((i(idx) - 1)/100) + 1;
            
            % the module of the new connexion is choosen randomly
            newModule = randi([1, 8]);        
            
            % disallow rewiring to the same module
            while(newModule == currModule)
                newModule = randi([1, 8]);
            end
            
            % the neuron inside the new module is also choosen randomly 
            newNeur = (newModule - 1) * 100 + randi([1, 100]);
            layer{1}.S{1}(i(idx), newNeur) = 1;  
            
        end
        
     end
     
     save('Network.mat','layer');
    
end