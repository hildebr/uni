
%
%
%

function pruned_itemsets = pruning(itemsets, data, min_support)

% ???
database_length = size(data,1); % ???
itemsets_count = length(itemsets); % ???
frequencies = ones(1,itemsets_count); %MATLAB specific: only for pre-allocation
for i = 1:itemsets_count
    itemset = itemsets{i};
    frequencies(i) = sum(all(data(:,itemset)==1,2))/database_length; % ???
end

% ???
pruned_itemsets = itemsets(frequencies >= min_support); 