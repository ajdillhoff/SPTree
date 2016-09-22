%%
% create_dummy_set.m
% Alex Dillhoff
%
% Creates a dummy training set in order to test the training algorithm.
%%

X = {
    [0 0 1 0;
     1 0 0 0;
     0 1 0 0],
    [0 0 1 0;
     0 0 0 1;
     0 1 0 0],
    [0 0 0 1;
     0 1 0 0;
     1 0 0 0],
    [0 0 0 1;
     0 0 1 0;
     1 0 0 0],
    [1 0 0 0;
     0 0 1 0;
     0 0 0 1],
    [1 0 0 0;
     0 1 0 0;
     0 0 0 1]
};

Y = [1, 1, 2, 2, 3, 3];

X_test = X;
Y_test = Y;

% Overlapping features
%X = {
    %[1 1;
     %1 0],
    %[1 0;
     %1 0],
    %[1 1;
     %0 1],
    %[0 1;
     %0 1]
%};

%Y = [1, 1, 2, 2];
