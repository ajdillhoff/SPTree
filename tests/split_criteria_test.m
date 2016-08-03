%%
% split_criteria_test.m
% Alex Dillhoff
%%

W_pos = rand(5, 1);
W_neg = rand(5, 1);
Y_pos = randi(3, 5, 1);
Y_neg = randi(3, 5, 1);

calculate_split_criteria(W_pos, W_neg, Y_pos, Y_neg)
