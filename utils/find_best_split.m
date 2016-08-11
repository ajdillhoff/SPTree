%%
% find_best_split.m
% Alex Dillhoff
%%

function [dim, best_gamma] = find_best_split(data, labels, weights, seq_idx, dim_idxs)
    %%
    % find_best_split(data, labels, weights, seq_idx, dim_idxs)
    %
    % Find the best split based on an adapted Gini impurity criteria.
    %%

    best_gamma = intmax;
    dim = -1;

    for i = 1 : length(dim_idxs)
        dim_idx = dim_idxs(i);

        [pos_ind, neg_ind] = split_set(data, seq_idx, dim_idx);
        Y_pos = labels(pos_ind, :, :);
        Y_neg = labels(neg_ind, :, :);
        W_pos = weights(pos_ind, :, :);
        W_neg = weights(neg_ind, :, :);

        gam = calculate_split_criteria(W_pos, W_neg, Y_pos, Y_neg);

        if gam < best_gamma
            best_gamma = gam;
            dim = dim_idx;
        end
    end
end
