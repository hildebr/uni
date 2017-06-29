# This file is for teaching purpose only! You are not allowed to publish,
# distribute, share, or use the code except for the demonstration and
# execution in the Data Mining practical course summer semester 2015.

# MLP in Python performing backprop on the XOR problem
# eta1 & eta2: learning rate between [0;1]
# epochs: number of iterations
# output: (hopefully) the expected output as trained by targets
# conf mat: confusion matrix
# data_inp = [0 0; 0 1; 1 0; 1 1];
# data_out = [0;1;1;0];

# Go through the code in mlp_python.py and infer, which algorihmic steps are reflected here
# Run the method several times with the same parameters
# Also, vary the parameters 'eta' and 'epochs' 

import numpy
import sys
if sys.version_info[0] != 2:
	raise Exception("This script was written for Python version 2.x.  You're running Python %s." % sys.version)
	
from mlp_python import mlp

# XOR example data: data to learn (data_inp), and respective target values (data_out), 
data_inp = numpy.array([[0,0],[0,1],[1,0],[1,1]])
data_out = numpy.array([[0],[1],[1],[0]])

# 
size_in  = numpy.shape(data_inp)[1]
size_out = numpy.shape(data_out)[1]
ndata    = numpy.shape(data_inp)[0]
if  numpy.shape(data_out)[0] != ndata:
    print "data error!"

# 
net = mlp(size_in, size_out, 2, 1.0, "linear")

# 
eta = 0.3
epochs = 600

#
for n in range(epochs):

    net.mlptrain(data_inp,data_out,ndata,eta,eta,n)
    net.confmat(data_inp,data_out,ndata)
