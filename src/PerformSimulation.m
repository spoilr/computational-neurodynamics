% startFrom = 1 for Q1c
% startFrom = 1001 for Q2
function [means] = PerformSimulation(p, Tmax, startFrom, plotResults)
    
    globalVariable();
    
    %%Generate the network
    Connect();
    
    %%Perform wiring
    Wire();
    Rewire(p);
   
    Wire_EXC_INH();
   
    if plotResults
        plotConnectionMatrices(p);
    end
    
    % Add network delays
    Delay_EXC_EXC();
    
    % Set Weight of all Connection matrices except EXC_EXT (Weight=1)
    Weigth();
    
    %%Run the simulation for Tmax milliseconds
    Run(Tmax, plotResults, p)
    
    means = MeanFiringRate(Tmax, startFrom, p, plotResults);
end

function plotConnectionMatrices(p)
    load('Network.mat','layer');
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
