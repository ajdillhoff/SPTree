%%
% splearn_test.m
% Alex Dillhoff
%%

% Use random data
%create_dummy_set;

% Use some DGS40 data
[X, Y] = parse_feature_vector('A1.txt');
W = rand(numel(X), 1);
W = W ./ sum(W);

o = SPTree();
o.SPLearn(X, Y, W);

% Evaluate on the training set
correct = 0;
for i = 1 : numel(X)
    p = o.SPTPath(X{i});
    label = p{end}.Label;
    %DEBUG
    fprintf('pred %d\tactual %d\n', label, Y(i));
    if label == Y(i)
        correct = correct + 1;
    end
end

fprintf('Accuracy: %.2f\n', correct / numel(X));
