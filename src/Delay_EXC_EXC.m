function Delay_EXC_EXC()
    globalVariable();
    load('Network.mat','layer');
    %rand(X,Y) create a matrix with X*Y random values from 0 to 1 
    layer{EXC}.delay{EXC} = randi(MAX_DELAY, EXC_ROWS, EXC_ROWS);
    save('Network.mat','layer');

end
