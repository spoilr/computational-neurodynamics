function [means] = Means(Tmax, windowLength, timeShift, startFrom)

    globalVariable();
    load('Network.mat','layer');
    firings = layer{EXC}.firings;
    firings_size = size(firings, 1);
    
    % nr_firings(module, t) is the number of neurons in module which fire at t
    nr_firings = zeros(MODULES, Tmax);

    for i = 1:firings_size
        single = firings(i, :);
        time = single(1);
        
        if time >= startFrom
            module = fix((single(2) - 1) / EXCITATORY_NEURONS) + 1;
            nr_firings(module, time) = nr_firings(module, time) + 1;
        end
    end
    
    %%remove empty columns
    nr_firings(:, 1:startFrom - 1) = [];
    
    dataPoints = fix((Tmax - startFrom + 1) / timeShift);
    
    means = zeros(MODULES, dataPoints);

    for d=1:dataPoints

        begin = (d-1)*timeShift + 1;
        ending = min(begin + windowLength - 1, Tmax - startFrom + 1);

        for module = 1:MODULES
            means(module, d) = mean(nr_firings(module, begin : ending));
        end
    end 
end