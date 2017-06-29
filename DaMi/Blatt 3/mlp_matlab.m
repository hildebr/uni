% This file is for teaching purpose only! You are not allowed to publish,
% distribute, share, or use the code except for the demonstration and
% execution in the Data Mining practical course summer semester 2015.

% MLP in Matlab performing backprop on the XOR problem

function output =mlp_matlab(data, targets, learnRate, iter) 

% some settings before computation

rand('state',sum(100*clock));
weights = -1 +2.*rand(3,3);

%
data_rows=size(data,1); % counts # of rows, here 4 (data is 4x2 matrix)

bias= -1; 
output = zeros(4,1);


for i = 1:iter
   error_sum = 0;  
    
   for j = 1:data_rows
	
      %
      hidden_1 = bias*weights(1,1)+ data(j,1)*weights(1,2) + data(j,2)*weights(2,2);
	
      out_hidden(1)=1/(1+exp(-hidden_1));
      
      hidden_2= bias*weights(2,1)+ data(j,1)*weights(1,3)+ data(j,2)*weights(2,3);
      
      out_hidden(2)=1/(1+exp(-hidden_2));
	  
      output_neuron = bias*weights(3,1)+ out_hidden(1)*weights(3,2)+ out_hidden(2)*weights(3,3);
	     
      output(j) = 1/(1+exp(-output_neuron));
      
      %
      error_output = output(j)*(1-output(j))*(targets(j)-output(j));
      error_sum = error_sum + -log(output(j)^targets(j) * (1-output(j))^(1-targets(j)));
      
      %
      error_hidden_1 = out_hidden(1)*(1-out_hidden(1))*weights(3,2)*error_output;
      error_hidden_2 = out_hidden(2)*(1-out_hidden(2))*weights(3,3)*error_output;
      
      %
      for k = 1:3
          
         if k==1
            weights(1,k) = weights(1,k) + learnRate*bias*error_hidden_1;
            weights(2,k) = weights(2,k) + learnRate*bias*error_hidden_2;
            weights(3,k) = weights(3,k) + learnRate*bias*error_output;
         else
            weights(1,k) = weights(1,k) + learnRate*data(j,1)*error_hidden_1;
            weights(2,k) = weights(2,k) + learnRate*data(j,2)*error_hidden_2;
            weights(3,k) = weights(3,k) + learnRate*out_hidden(k-1)*error_output;
         end
      end
   end
   
   %output of the mean error:
   error_mean = error_sum/data_rows
end


