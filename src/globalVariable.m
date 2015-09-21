% No of the layers
EXC = 1;
INH = 2;

%Nb of modules
MODULES = 8;

%Nb of Excitatory Neurons inside a module
EXCITATORY_NEURONS = 100;
INHIBITORY_NEURONS = 200;

%Nb of EXC to EXC connection inside a single module
EXC_EXC_CON = 1000;
%Nb of EXC to INH connection for each INH neuron
EXC_INH_CON = 4;

%Nb global of EXC and INH neurons
EXC_ROWS = MODULES * EXCITATORY_NEURONS;
INH_ROWS = INHIBITORY_NEURONS;
COLS = 1;

%Value of the scaling factors
EXC_EXC_FACT = 17;
EXC_INH_FACT = 50;

INH_EXC_FACT = 2;
INH_INH_FACT = 1;

MAX_DELAY = 20;

LAMBDA = 0.01;
BASE_CURRENT_FACTOR = 15;

NEURONS_NR = [EXC_ROWS, INH_ROWS];

