function [compl] = NeuralComplexity(timeSeries)
    
% Time series have to be covariance stationary. To render the time series
% covariance stationary, apply differencing twice before calculating neural complexity
timeSeries = aks_diff(timeSeries);
timeSeries = aks_diff(timeSeries);

%%Pass the transposed matrix (due to covariance function)
compl = complexity(timeSeries');
end

% X is the xth component in the system
function [mutualInfo] = mutualInfo(X, S)
    % remove the xth component in the system
    reducedS = S;
    reducedS(:, X) = [];
    mutualInfo = entropy(S(:, X)) + entropy(reducedS) - entropy(S);
end

% H(S) is entropy of a system S of N variables
function [entropy] = entropy(vars)
    N = size(vars, 2);
    entropy = 0.5 * log( (2 * pi * exp(1)) ^ N * det(cov(vars)));
end

function [integration] = integration(vars)
    N = size(vars, 2);
    systemEntropy = entropy(vars);
    componentsEntropy = 0;
    
    for i = 1:N
        componentsEntropy = componentsEntropy + entropy(vars(:, i));
    end
    
    integration = componentsEntropy - systemEntropy;
end

function [compl] = complexity(vars)
    N = size(vars, 2);
    mInfo = 0;
    
    for i = 1:N
        mInfo = mInfo + mutualInfo(i, vars);
    end
    
    compl = mInfo - integration(vars);
end