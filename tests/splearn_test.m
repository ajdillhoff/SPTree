%%
% splearn_test.m
% Alex Dillhoff
%%

create_dummy_set;

o = SPTree();
o.SPLearn(X, Y, W);

% Evaluate on the training set
correct = 0;
for i = 1 : size(X, 1)
    p = o.SPTPath(X(i, :, :));
    label = p{end}.Label;
    if label == Y(i)
        correct = correct + 1;
    end
end

fprintf('Accuracy: %.2f\n', correct / size(X, 1));
