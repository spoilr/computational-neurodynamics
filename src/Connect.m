function Connect

% Layer{X}.S{Y} corresponds to the matrix of connexions from layer Y to layer X
% S(X,Y) is the connexion from neuron X to neuron Y

    %load of the Constants
    globalVariable(); 
    
    %r is too make the network heterogeneous, i.e. more dynamic
    r = rand(EXC_ROWS, COLS);  
    layer{EXC}.rows = EXC_ROWS;
    layer{EXC}.columns = COLS;
    layer{EXC}.a = 0.02*ones(EXC_ROWS, COLS);
    layer{EXC}.b = 0.2*ones(EXC_ROWS, COLS);
    layer{EXC}.c = -65+15*r.^2;
    layer{EXC}.d = 8-6*r.^2;
    layer{EXC}.S{EXC} = zeros(EXC_ROWS, EXC_ROWS); %% Will be updated by Wire() and Rewire()
    layer{EXC}.S{INH} = ones(EXC_ROWS, INHIBITORY_NEURONS); % INH connected to all EXC
    
    layer{EXC}.factor{EXC} = EXC_EXC_FACT;
    layer{EXC}.factor{INH} = INH_EXC_FACT;
    layer{EXC}.delay{EXC} = zeros(EXC_ROWS, EXC_ROWS);  %% Will be updated by Delay_EXC_EXC
    layer{EXC}.delay{INH} = ones(EXC_ROWS, INHIBITORY_NEURONS);
    
    r = rand(INH_ROWS, COLS);
    layer{INH}.rows = INH_ROWS;
    layer{INH}.columns = COLS;
    layer{INH}.a = 0.02*ones(INH_ROWS, COLS);
    layer{INH}.b = 0.25*ones(INH_ROWS, COLS);
    layer{INH}.c = -65+15*r.^2;
    layer{INH}.d = 2-1*r.^2;
    layer{INH}.S{EXC} = zeros(INHIBITORY_NEURONS, EXC_ROWS); % Will be updated by  Wire_EXC_INH()
    layer{INH}.S{INH} = ones(INHIBITORY_NEURONS, INHIBITORY_NEURONS) - eye(INHIBITORY_NEURONS, INHIBITORY_NEURONS); %eye = Identity matrix
    
    layer{INH}.factor{INH} = INH_INH_FACT;
    layer{INH}.factor{EXC} = EXC_INH_FACT;
    layer{INH}.delay{INH} = ones(INHIBITORY_NEURONS, INHIBITORY_NEURONS);
    layer{INH}.delay{EXC} = ones(INHIBITORY_NEURONS, EXC_ROWS);
    
    save('Network.mat','layer');
end