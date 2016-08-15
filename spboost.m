
function result = spboost(learners, data, labels)
    %%
    % spboost(learners, data, labels)
    %
    % Boosting algorithm to train a strong classifier from many weak 
    % classifiers. Returns a strong classifier.
    %%

    num_trees = length(learners);

    % Initialize weights
    num_samples = size(data, 1);
    W = ones(num_samples, 1) ./ num_samples;
    
    % Initialize defaults
    err_best = intmax;
    C = max(labels);
    alpha = ones(num_trees, 1);

    for t = 1 : num_trees
        h = learners{t};

        % Select best weak learner using SPLearn
        h.SPLearn(data, labels, W);
        
        % Obtain classification error
        [V, err] = eval_learner(h, data, labels);

        learners{t} = h;

        if err < err_best
            err_best = err
        end

        % Obtain the weight
        alpha(t) = log((1 - err_best) / err_best);

        % Update weights
        W = W .* exp(-alpha(t) * err);

        % Normalize weights
        W = W ./ num_samples;
    end

    result = learners;
end
