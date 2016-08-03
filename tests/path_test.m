%%
% path_test.m
% Alex Dillhoff
%
% Test to traverse a path with a dummy input vector.
%%

f1 = [0 0 1; 
      1 0 0; 
      1 1 0];

f2 = [1 0 1; 
      1 0 0; 
      1 1 0];

f3 = [1 0 0; 
      0 1 0; 
      0 1 0];

create_tree;

P = o.SPTPath(f3);
P{end}
