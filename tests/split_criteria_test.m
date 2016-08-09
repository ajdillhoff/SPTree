%%
% split_criteria_test.m
% Alex Dillhoff
%%

D = 3;

W_pos = rand(5, 1);
W_neg = rand(5, 1);
Y_pos = randi(D, 5, 1);
Y_neg = randi(D, 5, 1);

calculate_split_criteria(W_pos, W_neg, Y_pos, Y_neg)
