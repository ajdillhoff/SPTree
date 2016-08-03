%%
% create_dummy_set.m
% Alex Dillhoff
%
% Creates a dummy training set in order to test the training algorithm.
%%

num_samples = 10;
max_dim = 3;
seq_length = 3;

X = randi(2, num_samples, seq_length, max_dim) - 1;
