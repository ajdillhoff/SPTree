%%
% eval.m
% Alex Dillhoff
%%

function result = eval_learners(learners, data, labels, alphas)
    %%
    % eval_learners(learners, data, labels, alphas)
    %
    % Evaluates a set of trained learners against a test set.
    %%

    result = zeros(numel(data), numel(learners));

    for i = 1 : numel(data)
        for j = 1 : numel(learners)
            learner = learners{j};
            p = learner.SPTPath(data{i});
            label = p{end}.Label;
            result(i, j) = alphas(j) * (label == labels(i));
        end
    end
end
