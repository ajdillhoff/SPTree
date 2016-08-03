classdef SPTree < handle
    %%
    % SPTree
    %
    % Implementation of an SPTree as defined in "Sign language recongition using
    % sequential pattern trees" by Ong et al.
    %%

    properties
        Root
        Nodes
        Edges
    end

    methods
        function obj = SPTree()
            %%
            % SPTree()
            %
            % Constructor. Creates a bare SPTree with no nodes nor edges.
            %%
            
            obj.Nodes = {};
            obj.Edges = [];
            obj.Root = [];
        end

        function AddNode(obj, node)
            %%
            % AddNode(node)
            %
            % Adds a new SPNode object to the tree.
            %%

            if isempty(obj.Root)
                obj.Root = node;
            end

            obj.Nodes{end + 1} = node;
        end

        function AddEdge(obj, node1_idx, node2_idx, e, k)
            %%
            % AddEdge(node1_idx, node2_idx, e, k)
            %
            % Adds a new edge to the tree between `node1` and `node2` where `e`
            % denotes whether E is a static edge (e = 1) or a sequential edge
            % (e = 2) and k = 1 denotes a positive decision edge, and k = -1
            % denotes a negative decision edge.
            %%

            % TODO: Add input checking. 
            if node1_idx > length(obj.Nodes) | node2_idx > length(obj.Nodes)
                return;
            end

            obj.Edges(end + 1, :) = [node1_idx, node2_idx, e, k];
        end

        function result = SPTPath(obj, x)
            %%
            % SPTPath(x)
            %
            % Given an input feature vector x, SPTPath will attempt to assign a
            % class label after traversing the SPTree.
            %%

            if isempty(obj.Root)
                return;
            end

            % Initialize index set R
            R = 1:size(x, 1);

            % Initialize current node to root node
            current_node = obj.Root;
            node_idx = 1;

            current_edge = 1;
            result = {obj.Root};

            while ~current_node.IsLeaf
                d = current_node.Feature;

                % Build G, which is a set of the indices that are 1 in the feature
                % vector of the current node.
                G = find(x(:, d) == 1);

                if isempty(G)
                    % Traverse the negative decision edge
                    e_idx = find(obj.Edges(:, 1) == node_idx & obj.Edges(:, 4) == -1);
                    node_idx = obj.Edges(e_idx, 2);
                    current_node = obj.Nodes{node_idx};
                else
                    % Traverse the positive decision edge
                    e_idx = find(obj.Edges(:, 1) == node_idx & obj.Edges(:, 4) == 1);
                    node_idx = obj.Edges(e_idx, 2);
                    current_node = obj.Nodes{node_idx};

                    if current_edge == 2
                        R_new = min(R) + 1 : size(x, 1);
                    else
                        R_new = G;
                    end
                    R = R_new;
                end

                result{end+1} = current_node;
            end
        end

        function SPLearn(data, labels, weights)
            %%
            % SPLearn(data, labels, weights)
            %
            % Given a training set, this algorithm outputs a learned SP-Tree.
            %%

            % Set root node dim based on Eq. 4 of paper
            % Partition dataset based on root node
            % Get root label using Y (section 3.2)
            % Set Queue
            % while Queue is not empty
            % end
        end
    end
end
