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

        function result = AddNode(obj, node)
            %%
            % AddNode(node)
            %
            % Adds a new SPNode object to the tree.
            %%

            if isempty(obj.Root)
                obj.Root = node;
            end

            obj.Nodes{end + 1} = node;

            result = length(obj.Nodes);
        end

        function result = AddEdge(obj, node1_idx, node2_idx, e, k)
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

            result = size(obj.Edges, 1);
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

        function SPLearn(obj, data, labels, weights)
            %%
            % SPLearn(data, labels, weights)
            %
            % Given a training set, this algorithm outputs a learned SP-Tree.
            %%

            alpha = 1;
            beta = 5;

            dim_idxs = 1:size(data, 3);
            seq_idx = 1;

            % Set root node dim based on Eq. 4 of paper
            [d, ~] = find_best_split(data, labels, weights, seq_idx, dim_idxs);

            % Partition dataset based on root node
            [pos_ind, neg_ind] = split_set(data, seq_idx, d);
            X_pos = data(pos_ind, :, :);
            X_neg = data(neg_ind, :, :);
            W_pos = weights(pos_ind);
            W_neg = weights(neg_ind);
            Y_pos = labels(pos_ind);
            Y_neg = labels(neg_ind);

            % Get root label using Y (section 3.2)
            [~, c] = max(histcounts(labels));

            % Set default nodes and edges
            root_node = SPNode(c, d);
            obj.AddNode(root_node);

            L = SPNode(-1, -1, true);
            M = SPNode(-1, -1, true);
            L_idx = obj.AddNode(L);
            M_idx = obj.AddNode(M);
            
            L_edge_idx = obj.AddEdge(1, 2, -1, -1);
            M_edge_idx = obj.AddEdge(1, 3, -1, 1);

            dim_idxs = setdiff(dim_idxs, d);

            % Set Queue
            Q = {{L_idx, pos_ind, dim_idxs, 2, 1, L_edge_idx}, ...
                {M_idx, neg_ind, dim_idxs, 2, 1, M_edge_idx}};

            while ~isempty(Q)
                current_node_idx = Q{end}{1};
                current_data_idxs = Q{end}{2}';
                current_dim_idxs = Q{end}{3};
                current_depth = Q{end}{4};
                current_seq_idx = Q{end}{5};
                current_edge_idx = Q{end}{6};
                current_node = obj.Nodes{current_node_idx};
                current_edge = obj.Edges(current_edge_idx, :);
                Q = Q(1:end-1);
                 
                if length(current_data_idxs) <= alpha | current_depth >= beta
                    break;
                end

                % Get current data
                X_cur = data(current_data_idxs, :, :);
                W_cur = weights(current_data_idxs);
                Y_cur = labels(current_data_idxs);

                % Get optimal static edge node dimension
                current_edge(3) = 1;
                [d_stat, gam_stat] = find_best_split(X_cur, Y_cur, W_cur, current_seq_idx, current_dim_idxs);
                [stat_pos_idxs, stat_neg_idxs] = split_set(X_cur, current_seq_idx, d_stat);

                % Get optimal sequential edge node dimension
                current_edge(3) = 2;
                [d_seq, gam_seq] = find_best_split(X_cur, Y_cur, W_cur, current_seq_idx + 1, dim_idxs);
                [seq_pos_idxs, seq_neg_idxs] = split_set(X_cur, current_seq_idx + 1, d_seq);

                % set label of current node
                [~, current_c] = max(histcounts(Y_cur));

                if gam_stat <= gam_seq
                    current_node.Label = current_c;
                    current_node.Feature = d_stat;
                    current_edge(3) = 1;
                    current_dim_idxs = setdiff(current_dim_idxs, d_stat);
                    
                    % Set current splits
                    X_cur_pos_idxs = stat_pos_idxs;
                    X_cur_neg_idxs = stat_neg_idxs;
                else
                    current_node.Label = current_c;
                    current_node.Feature = d_seq;
                    current_edge(3) = 2;
                    current_dim_idxs = setdiff(current_dim_idxs, d_seq);
                    
                    % Set current splits
                    X_cur_pos_idxs = seq_pos_idxs;
                    X_cur_neg_idxs = seq_neg_idxs;

                    % TODO: Does this need to be here?
                    current_seq_idx = current_seq_idx + 1;
                end

                % Update edge and node property
                obj.Edges(current_edge_idx, :) = current_edge;
                obj.Nodes{current_node_idx} = current_node;

                if min(gam_seq, gam_stat) > 0
                    L = SPNode(-1, -1, true);
                    K = SPNode(-1, -1, true);
                    L_idx = obj.AddNode(L);
                    K_idx = obj.AddNode(K);

                    L_edge_idx = obj.AddEdge(current_node_idx, L_idx, -1, -1);
                    K_edge_idx = obj.AddEdge(current_node_idx, K_idx, -1, 1);

                    % Set Queue
                    if ~isempty(current_dim_idxs)
                        Q{end + 1} = {K_idx, X_cur_pos_idxs, current_dim_idxs, current_depth, current_seq_idx, K_edge_idx};
                        Q{end + 1} = {L_idx, X_cur_neg_idxs, current_dim_idxs, current_depth, current_seq_idx, L_edge_idx};
                    end
                end
            end
        end
    end
end
