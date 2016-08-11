%%
% best_split_test.m
% Alex Dillhoff
%%

create_dummy_set;

D = 1 : max_dim;

result = find_best_split(X, Y, W, 1, D)
