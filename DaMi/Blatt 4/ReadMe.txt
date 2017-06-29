Task 2 - Association Rules with Apriory on Grocery Shopping Data

toy.mat

Toy example for the apriory algorithm. Contains 4 transactions over 6 items.

groceries.mat

Contains 9835 transactions of items from a supermarket. In the binary matrix 'gr_binary_data' one row depicts one transaction, where a '0' stands for items not bought and a '1' means this article made it into the basket. The corresponding 'gr_labels' include a complete list of possible items. 
The data is saved in a cell array. With the curly brackets ("{ }") you get access. 

If you are interested, you also can check and import the original data as a Cell Array (Matlab 2014a or higher):
goceries.csv
Use the function [gr_labels,gr_bindata]=createBinaryMatrix(groceries) to transform the dataset into the vector of labels and a binary matrix.

Data Source:

http://www.salemmarafi.com/wp-content/uploads/2014/03/groceries.csv

Background:

http://www.example.thedatageek.co/assocRules.html, web source, visited 06.05.2015. 


Task 3 - Decision Tree generation on MPG (reduced set) Data:

autoMPGDataSetSmall.txt
Which you should import into Matlab as a 'Matrix'.

Attribute information:

1. miles per gallon category: multi-valued discrete (could be a good class)
2. cylinders: multi-valued discrete
3. displacement: continuous
4. horsepower: continuous
5. weight: continuous
6. acceleration: continuous
7. model year: multi-valued discrete
8. origin (continent): multi-valued discrete (could be a good class)

Data Source:

https://archive.ics.uci.edu/ml/datasets/Auto+MPG

Reference:

Quinlan,R. (1993). Combining Instance-Based and Model-Based Learning. 
In Proceedings on the Tenth International Conference of Machine Learning, 236-243, 
University of Massachusetts, Amherst. Morgan Kaufmann. 
