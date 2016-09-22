%%
% whist.m
% Alex Dillhoff
%%

function result = whist(data, weights)
    %%
    % whist(data, weights)
    % 
    % Calculates a normalized histogram of the data weighted by the given
    % weights. The number of bins in the histogram is equal to the number of
    % unique elements in the data.
    %%

    [u, ~, c] = unique(data);
    [n, ib] = histc(data, u);
    result = n' .* accumarray(c, weights);
    result = result / sum(result);
end
