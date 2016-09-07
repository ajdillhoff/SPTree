%%
% split_set.m
% Alex Dillhoff
%%

function [X_pos_ind, X_neg_ind] = split_set(X, d)
    %%
    % split_set(X, d)
    %
    % Splits the dataset given the dimension d. The set `X_pos` will contain all 
    % samples such that the feature at dimension `d` is 1. The set `X_neg` will 
    % contain the rest.
    %%
    
    X_pos_ind = [];
    X_neg_ind = [];

    if d == -1
        return
    end

    %[X_pos_row, X_pos_col] = ind2sub(size(X), find(X(:, l, d) == 1));

    index = false(1, numel(X));
    for k = 1 : numel(X)
        index(k) = ~isempty(find(X{k}(:, d)));
    end

    X_pos_ind = find(index);
    X_neg_ind = find(~index);
end
