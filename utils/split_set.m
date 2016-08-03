%%
% split_set.m
% Alex Dillhoff
%%

function [X_pos, X_neg] = split_set(X, d)
    %%
    % split_set(X, d)
    %
    % Splits the dataset given the dimension d. The set `X_pos` will contain
    % all samples such that the feature at dimension `d` is 1. The set `X_neg`
    % will contain the rest.
    %%

    [X_pos_ind, c] = find(X(:, :, d) == 1)
    [X_neg_ind, c] = find(X(:, :, d) == 0)
end
