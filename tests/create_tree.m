%%
% create_tree.m
% Alex Dillhoff
% 
% Test to create a sample tree.
%%

o = SPTree();

% Create nodes
n1 = SPNode(1, 1);
n2 = SPNode(2, 2);
n3 = SPNode(3, 3);
n4 = SPNode(1, 1);
n5 = SPNode(3, 3);

% Leaf nodes
n6 = SPNode(2, 1, true);
n7 = SPNode(1, 1, true);
n8 = SPNode(3, 1, true);
n9 = SPNode(1, 1, true);
n10 = SPNode(2, 1, true);
n11 = SPNode(4, 1, true);

o.AddNode(n1);
o.AddNode(n2);
o.AddNode(n3);
o.AddNode(n4);
o.AddNode(n5);
o.AddNode(n6);
o.AddNode(n7);
o.AddNode(n8);
o.AddNode(n9);
o.AddNode(n10);
o.AddNode(n11);

% Create edges
o.AddEdge(1, 2, 1, 1);
o.AddEdge(1, 3, 1, -1);
o.AddEdge(2, 4, 2, 1);
o.AddEdge(2, 5, 1, -1);
o.AddEdge(3, 10, 1, 1);
o.AddEdge(3, 11, 1, -1);
o.AddEdge(4, 6, 1, 1);
o.AddEdge(4, 7, 1, -1);
o.AddEdge(5, 8, 1, 1);
o.AddEdge(5, 9, 1, -1);
