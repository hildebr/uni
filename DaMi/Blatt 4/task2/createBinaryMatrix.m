function [ gr_labels,gr_binary_data ] = createBinaryMatrix( dataset )
% This script is for teaching purposes only! You are allowed to use it in 
% class for Data Mining practical tutorial summer term 2015. Publication 
% or distribution is strictly prohibited.
% 
% Requires Matlab 2014a or higher
% Creates a vector of labels (cells) and binary matrix (doubles) 
% from a dataset of a basket analysis  

% transform the cell matrix of strings into a matrix of categories:
cat_dataset = categorical(dataset);

% determine the list of unique items from the dataset
gr_labels = categories(cat_dataset);

% determine the dimensionality of the data
number_of_transactions = size(cat_dataset,1);
number_of_unique_items = size(gr_labels,1);

% initialise a binary matrix of transactions x items
gr_binary_data = zeros(number_of_transactions,number_of_unique_items);
% the following works like zeros(), but gives a logical matrix:
%binaryData = false(number_of_transactions,number_of_unique_items);

% fill the binary matrix: if a item from the labels list is includes -> 1
for t = 1:number_of_transactions
    gr_binary_data(t,:)=ismember(gr_labels,cat_dataset(t,:));
end;    

end

