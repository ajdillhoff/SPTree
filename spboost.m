
function [alpha, result] = spboost(learners, data, labels)
    %%
    % spboost(learners, data, labels)
    %
    % Boosting algorithm to train a strong classifier from many weak 
    % classifiers. Returns a strong classifier.
    %%

    num_trees = length(learners);
    acc_array = zeros(1, num_trees);

    % Initialize weights
    num_samples = numel(data);
    W = ones(num_samples, 1) / num_samples;
    
    % Initialize defaults
    C = numel(unique(labels));
    alpha = ones(num_trees, 1);

    fprintf('Number of classes: %d\n', C);

    for t = 1 : num_trees
        %idxs = randperm(num_samples);
        tic;
        % DEBUG
        fprintf('\nLearner %d\n', t);

        h = learners{t};

        % Select best weak learner using SPLearn
        %h.SPLearn(data(idxs), labels(idxs), W(idxs));
        h.SPLearn(data, labels, W);

        % DEBUG
        fprintf('Calculating error\n');

        % Obtain classification error
        [V, err] = eval_learner(h, data, labels, W);

        % DEBUG
        fprintf('err %f\n', err);

        learners{t} = h;

        % Obtain the weight -- add eps to stabilize
        alpha(t) = log((1 - err + eps) / (err + eps)) + log(C - 1);

        % DEBUG
        fprintf('alpha %f\n', alpha(t));

        % Update weights
        W_old = W;
        W = W .* exp(alpha(t) * V);

        % Normalize weights
        W = W / sum(W);
        fprintf('Time Taken: %f\n', toc);
        
        % DEBUG: Evaluate
        %[~, acc] = eval_learners(learners(1:t), data, labels, alpha(1:t));
        %acc_array(t) = sum(acc) / num_samples;
        
        %figure(1);
        %plot(1:t, acc_array(1:t));
        %drawnow
    end

    result = learners;
end
