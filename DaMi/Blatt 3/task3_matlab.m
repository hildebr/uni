% This file is for teaching purpose only! You are not allowed to publish,
% distribute, share, or use the code except for the demonstration and
% execution in the Data Mining practical course summer semester 2015.

% MLP in Matlab performing backprop on the XOR problem
% data: data to learn (train), target values

% Go through the code in mlp_matlab.m and infer, which algorihmic steps are reflected here
% Run the method several times with the same parameters
% Also, vary the parameters 'eta' and 'epochs' (number of iterations)

% XOR example data: data to learn (train), target values
data = [0 0; 0 1; 1 0; 1 1];
targets = [0;1;1;0];

%
eta = 0.3;
epochs = 10000;

%
output = mlp_matlab(data, targets, eta, epochs);

