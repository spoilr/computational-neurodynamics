function [means] = MeanFiringRate(Tmax, startFrom, p, plotResults)
    %%Retrieve the mean firing rate, using firings from the layer.mat file.
    %%PARAMS:
    %%  Tmax          = the max time of the simulation
    %%  startFrom     = the time where to start counting data from
   
    WindowLength = 50;
    timeShift = 20;
   
    means = Means(Tmax, WindowLength, timeShift, startFrom);
    
    if plotResults
        figure(4)
        clf
        
        plot(startFrom:timeShift:Tmax - 1, means)
        xlabel(sprintf('Time (ms) + %d ms', startFrom - 1))
        xlim([startFrom Tmax])
        ylabel('Mean firing rate')
        title(sprintf('Mean Firing rates, p = %0.1f', p))      
        
        drawnow
    end
end
