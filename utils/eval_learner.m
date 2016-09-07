%%
% eval_learner.m
% Alex Dillhoff
%%

function [responses, err] = eval_learner(learner, data, labels, W)
    %%
    % eval_learner(learner, data, labels, W)
    %
    % Evaluates the classification error of a given learner.
    %%

    % Evaluate on the training set
    responses = zeros(numel(data), 1);
    for i = 1 : numel(data)
        p = learner.SPTPath(data{i});
        label = p{end}.Label;
        responses(i) = label ~= labels(i);
    end

    err = sum(W .* responses) / sum(W);
end
