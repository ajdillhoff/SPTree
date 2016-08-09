%%
% split_set.m
% Alex Dillhoff
%%

function [X_pos, X_neg] = split_set(X, l, d)
    %%
    % split_set(X, l, d)
    %
    % Splits the dataset given the dimension d and the sequence index l. The set
    % `X_pos` will contain all samples such that the feature at dimension `d` is
    % 1. The set `X_neg` will contain the rest.
    %%

    [X_pos_row, X_pos_col] = ind2sub(size(X), find(X(:, l, d) == 1));

    X_pos_row = unique(X_pos_row);
    X_neg_row = find(~ismember(1:size(X, 1), X_pos_row));

    X_pos = X(X_pos_row, :, :);
    X_neg = X(X_neg_row, :, :);
end
