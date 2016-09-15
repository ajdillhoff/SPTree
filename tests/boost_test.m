%%
% boost_test.m
% Alex Dillhoff
%
% Tests the boosting algorithm for SPTree learning.
%%

%create_dummy_set;
% Use some DGS40 data
[X, Y] = parse_feature_vector('A1.txt');

M = 25;     % number of learners
learners = {};

% Initialize learners
for i = 1:M
    learners{end + 1} = SPTree();
end

% Apply boosting
[alphas, learners] = spboost(learners, X, Y);

%[X_test, Y_test] = parse_feature_vector('A1.txt');

% Evaluate
[responses, acc] = eval_learners(learners, X, Y, alphas);

fprintf('Accuracy: %f\n', sum(acc) / numel(X));
