%%
% boost_test.m
% Alex Dillhoff
%
% Tests the boosting algorithm for SPTree learning.
%%

%create_dummy_set;
% Use some DGS40 data
[X, Y] = parse_feature_vector('A1.txt');

M = 200;
learners = {};

% Initialize learners
for i = 1:M
    learners{end + 1} = SPTree();
end

% Apply boosting
learners = spboost(learners, X, Y);

