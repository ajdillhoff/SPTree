
function result = spboost(learners, data, labels)
    %%
    % spboost(learners, data, labels)
    %
    % Boosting algorithm to train a strong classifier from many weak 
    % classifiers. Returns a strong classifier.
    %%

    num_trees = length(learners);

    % Initialize weights
    num_samples = numel(data);
    W = ones(num_samples, 1) / num_samples;
    
    % Initialize defaults
    C = numel(unique(labels));
    alpha = ones(num_trees, 1);

    for t = 1 : num_trees
        % DEBUG
        fprintf('\nLearner %d\n', t);

        h = learners{t};

        % Select best weak learner using SPLearn
        h.SPLearn(data, labels, W);

        % DEBUG
        fprintf('Calculating error\n');

        % Obtain classification error
        [V, err] = eval_learner(h, data, labels, W);

        % DEBUG
        fprintf('err %f\n', err);

        learners{t} = h;

        % Obtain the weight
        alpha(t) = log((1 - err) / err) + log(C - 1);
        %alpha(t) = log((1 - err) / err);

        % DEBUG
        fprintf('alpha %f\n', alpha(t));

        % Update weights
        W = W .* exp(-alpha(t) * V);

        % Normalize weights
        W = W / sum(W);
    end

    result = learners;
end
