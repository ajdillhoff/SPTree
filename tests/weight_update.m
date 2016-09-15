%%
% weight_update.m
% Alex Dillhoff
%
% Plot the curve of the weight update function.
%%

X = -1:0.01:1;
Y = exp(X);

figure(1);
plot(X, Y);

X = 0:0.05:1;
Y = log((1 - X) ./ X) + log(9);

figure(2);
plot(X, Y);
