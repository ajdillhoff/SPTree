%%
% SPNode.m
% Alex Dillhoff
%%

classdef SPNode < handle
    %%
    % SPNode
    %
    % Class which defines a node used in an SPTree.
    %%

    properties
        Label   % Class label
        Feature % Feature dimension
        IsLeaf
    end

    methods
        function obj = SPNode(c, d, leaf)
            %%
            % SPNode()
            %
            % Constructor for SPNode class.
            %%
            
            if nargin == 2
                leaf = false;
            end

            obj.Label = c;
            obj.Feature = d;
            obj.IsLeaf = leaf;
        end
    end
end
