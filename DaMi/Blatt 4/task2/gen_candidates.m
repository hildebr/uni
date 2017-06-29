
% function that creates all pairs, triplets, etc and generates the candidate list
% output are 'k' cell arrays representing possible item associations
% (= diagonal of data matrix)
% only after the pruning the number of this cell arrays will drop due to the minimum 
% support the associated items have to survive
% these are then a set called frequent_items

function new_candidates = gen_candidates(old_itemsets)
candidates_count = length(old_itemsets);
new_candidates = {};
k = 1;
for i = 1:candidates_count
    a = old_itemsets{i};
    for j = (i+1):candidates_count
        b = old_itemsets{j};
        % MATLAB specific: defines a set over candidates for all possible
        % associations of different items
        if all(a(1:(end-1)) == b(1:(end-1)))
            new_candidates{k} = [a b(end)];
            k = k+1;
        else
            break;
        end
    end
end

