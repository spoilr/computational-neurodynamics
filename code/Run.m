function Run(Tmax, plotResults, p, layer)

% Simulates two layers (imported from saved file) of Izhikevich neurons

    globalVariable(); 
    
    N1 = layer{1}.rows;
    M1 = layer{1}.columns;

    N2 = layer{2}.rows;
    M2 = layer{2}.columns;

    Dmax = MAX_DELAY + 1; % maximum propagation delay

    % Initialise layers
    for lr=1:length(layer)
       layer{lr}.v = -65*ones(layer{lr}.rows,layer{lr}.columns);
       layer{lr}.u = layer{lr}.b.*layer{lr}.v;
       layer{lr}.firings = [];
    end

    % SIMULATE
    for t = 1:Tmax

       % Display time every second
       if mod(t,100) == 0
          t
       end

       poi = poissrnd(LAMBDA, NEURONS_NR(1), 1);
       layer{1}.I = poi * BASE_CURRENT_FACTOR;
       layer{2}.I = zeros(N2,M2);

       % Update all the neurons
       for lr=1:length(layer)
          layer = IzNeuronUpdate(layer,lr,t,Dmax);
       end
    end


    firings1 = layer{1}.firings;
    firings2 = layer{2}.firings;

    save('Network.mat','layer');

    if plotResults

        % Raster plots of firings

        figure(5)
        clf

        subplot(2,1,1)
        if ~isempty(firings1)
           plot(firings1(:,1),firings1(:,2),'.')
        end
        % xlabel('Time (ms)')
        xlim([0 Tmax])
        ylabel('Neuron number')
        ylim([0 N1*M1+1])
        set(gca,'YDir','reverse')
        title(sprintf('Excitatory Population firings, p = %0.1f', p));

        subplot(2,1,2)
        if ~isempty(firings2)
           plot(firings2(:,1),firings2(:,2),'.')
        end
        xlabel('Time (ms)')
        xlim([0 Tmax])
        ylabel('Neuron number')
        ylim([0 N2*M2+1])
        set(gca,'YDir','reverse')
        title(sprintf('Inhibitory Population firings, p = %0.1f', p));

        drawnow
    end
end
