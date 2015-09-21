function Weigth
    
    globalVariable();
    load('Network.mat','layer');
    %rand(X,Y) create a matrix with X*Y random values from 0 to 1 
    layer{EXC}.S{INH} = -1 * layer{EXC}.S{INH} .* rand(EXC_ROWS, INH_ROWS);
    layer{INH}.S{INH} = -1 * layer{INH}.S{INH} .* rand(INH_ROWS, INH_ROWS);
    
    layer{INH}.S{EXC} = layer{INH}.S{EXC} .* rand(INH_ROWS, EXC_ROWS);    
    save('Network.mat','layer');


end