function Wire
%Wire updates the variable layer to initiate the 1000 EXC to EXC wires inside each single EXC module (8)  
    load('Network.mat','layer');

    % For each EXC module, 1000 wires inside the module are created
    for i = 1:100:800
        layer{1}.S{1} = wireModule(i, layer{1}.S{1});
    end
    
    save('Network.mat','layer');

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