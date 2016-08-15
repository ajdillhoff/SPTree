%%
% eval_learner.m
% Alex Dillhoff
%%

function [V, err] = eval_learner(learner, data, labels)
    %%
    % eval_learner(learner, data, labels)
    %
    % Evaluates the classification error of a given learner.
    %%

    % Evaluate on the training set
    V = zeros(size(data, 1), 1);
    for i = 1 : size(data, 1)
        p = learner.SPTPath(data(i, :, :));
        label = p{end}.Label;
        V(i) = label ~= labels(i);
    end

    err = sum(V) ./ size(data, 1);
end
