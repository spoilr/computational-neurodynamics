% startFrom = 1 for Q1c
% startFrom = 1001 for Q2
function [means] = PerformSimulation(p, Tmax, startFrom, plotResults)
    
    globalVariable();
    
    %%Generate the network
    %%Perform wiring
    

    layer = Connect();
    % For each EXC module, 1000 wires inside the module are created
    for i = 1:100:800
        layer{1}.S{1} = wireModule(i, layer{1}.S{1});
    end




    % update the variable layer to rewire with the probability p the wires of each single module EXC to create connexion between modules  

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
   


    % wire excitatory - inhibitory
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
   

    if plotResults
        colormap([1,1,1;0,0,0]);
    
        matrix = zeros(1000, 1000);
        
        matrix(1:800, 1:800) = layer{1}.S{1};
        matrix(801:1000, 1:800) = layer{1}.S{2}';
        matrix(1:800, 801:1000) = layer{2}.S{1}';
        matrix(801:1000, 801:1000) = layer{2}.S{2};
        
        figure(1)
        clf
        image(matrix.*255);
        xlabel('1-800: Excitatory Neurons; 801-1000 Inhibitory Neurons');
        ylabel(' 801-1000 Inhibitory Neurons; 1-800: Excitatory Neurons');
        
        title(sprintf('Connectivity Matrix, p = %0.1f', p));
        drawnow
    end
    

    % Add network delays - the other delays are in Connect
    layer{EXC}.delay{EXC} = randi(MAX_DELAY, EXC_ROWS, EXC_ROWS);
    
    % Set Weight of all Connection matrices except EXC_EXC (Weight=1)
    layer{EXC}.S{INH} = -1 * layer{EXC}.S{INH} .* rand(EXC_ROWS, INH_ROWS);
    layer{INH}.S{INH} = -1 * layer{INH}.S{INH} .* rand(INH_ROWS, INH_ROWS);
    layer{INH}.S{EXC} = layer{INH}.S{EXC} .* rand(INH_ROWS, EXC_ROWS);    
    
    save('Network.mat', 'layer');
    %%Run the simulation for Tmax milliseconds
    Run(Tmax, plotResults, p, layer)
    

    means = Means(Tmax, WINDOW_LENGTH, TIME_SHIFT, startFrom);

    if plotResults
        %% Mean firing rates
        figure(4)
        clf
        
        plot(startFrom:TIME_SHIFT:Tmax - 1, means)
        xlabel(sprintf('Time (ms) + %d ms', startFrom - 1))
        xlim([startFrom Tmax])
        ylabel('Mean firing rate')
        title(sprintf('Mean Firing rates, p = %0.1f', p))      
        
        drawnow
    end

end


function[matrix] = wireModule(beg, original)
%wireModule creates 1000 distinct wires in module which start at the index beg in the matrix original     
    for i = 1:1000
        x = randi(100) - 1;
        y = randi(100) - 1;
        
        % To make sure we create 1000 distinct wires
        while(original(beg + x, beg + y) == 1 || x == y)
            x = randi(100) - 1;
            y = randi(100) - 1;
        end
        original(beg + x, beg + y) = 1;
    end
    matrix = original;
end

