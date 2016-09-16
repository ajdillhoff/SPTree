%%
% eval.m
% Alex Dillhoff
%%

function [responses, accuracy] = eval_learners(learners, data, labels, alphas)
    %%
    % eval_learners(learners, data, labels, alphas)
    %
    % Evaluates a set of trained learners against a test set.
    %%

    responses = zeros(1, numel(data));
    accuracy = zeros(1, numel(data));

    % Create a class index
    unique_labels = unique(labels);
    label_map = containers.Map(unique_labels, 1:length(unique_labels));

    for i = 1 : numel(data)
        pred_vec = zeros(numel(learners), length(unique_labels));
        for j = 1 : numel(learners)
            learner = learners{j};
            p = learner.SPTPath(data{i});
            label = p{end}.Label;
            if label == -1
                label = p{end - 1}.Label;
            end
            pred = label_map(label);
            pred_vec(j, pred) = alphas(j);
        end

        response = sum(pred_vec, 1);
        [~, final_prediction] = max(response);
        responses(i) = final_prediction;
        accuracy(i) = final_prediction == label_map(labels(i));
    end

    %fprintf('\nAccuracy: %f\n', sum(accuracy) / numel(data));
end
