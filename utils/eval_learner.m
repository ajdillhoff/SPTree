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
    
    K = numel(unique(labels));

    % Evaluate on the training set
    responses = zeros(numel(data), 1);
    weighted_responses = zeros(numel(data), 1);
    for i = 1 : numel(data)
        p = learner.SPTPath(data{i});
        label = p{end}.Label;
        response = label ~= labels(i);
        %responses(i) = (label ~= labels(i));

        %DEBUG
        %if response == 0
            %response = -1 / (K - 1);
        %end

        responses(i) = response;
        weighted_responses(i) = W(i) * response;
    end

    err = sum(weighted_responses) / sum(W);
end
