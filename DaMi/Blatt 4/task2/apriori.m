
% This file is for teaching purpose only! You are not allowed to publish,
% distribute, share, or use the code except for the demonstration and
% execution in the Data Mining practical course summer semester 2014

% Input: data is a boolean matrix with rows=number of transactions and
% columns=number of items
% Input: support is the threshold
% Output: the associated itemset according to the given minimum support

function frequent_itemsets = apriori(data, min_support)

candidates = {}; %MATLAB specific: creates an empty cell array to store items in

%
for i = 1:size(data,2)
    candidates{i} = i;
end

% ???

candidates = pruning(candidates, data, min_support);

frequent_itemsets = candidates;

% ???

while 1
    candidates = gen_candidates(candidates); %???

    candidates = pruning(candidates, data, min_support); %???

    if isempty(candidates), break; end;

    frequent_itemsets = [frequent_itemsets candidates]; %MATLAB specific: return
end

