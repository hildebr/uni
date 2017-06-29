# # VARIATION OF Code from Chapter 3 of Machine Learning: An Algorithmic Perspective
# by Stephen Marsland (http://seat.massey.ac.nz/personal/s.r.marsland/MLBook.html)

# You are free to use, change, or redistribute the code in any way you wish for
# non-commercial purposes, but please maintain the name of the original author.
# This code comes with no warranty of any kind.

# Originally by Stephen Marsland, 2008

# The wine classification example

from numpy import *
import sys
if sys.version_info[0] != 2:
	raise Exception("This script was written for Python version 2.x.  You're running Python %s." % sys.version)

def preprocessIris(infile,outfile):

    stext1 = 'Wine type A'
    stext2 = 'Wine type B'
    stext3 = 'Wine type C'
    rtext1 = '0'
    rtext2 = '1'
    rtext3 = '2'

    fid = open(infile,"r")
    oid = open(outfile,"w")

    for s in fid:
        if s.find(stext1)>-1:
            oid.write(s.replace(stext1, rtext1))
        elif s.find(stext2)>-1:
            oid.write(s.replace(stext2, rtext2))
        elif s.find(stext3)>-1:
            oid.write(s.replace(stext3, rtext3))
    fid.close()
    oid.close()

# Load data and normalise
wine = loadtxt('WineDataSet/wine_proc.data',delimiter=',')
wine[:,:13] = wine[:,:13]-wine[:,:13].mean(axis=0)
imax = concatenate((wine.max(axis=0)*ones((1,14)),wine.min(axis=0)*ones((1,14))),axis=0).max(axis=0)
wine[:,:13] = wine[:,:13]/imax[:13]
print wine[0:14,:]

# Copy classes from last col of the data set to a separate vector
target = zeros((shape(wine)[0],3));
indices = where(wine[:,13]==0) 
target[indices,0] = 1
indices = where(wine[:,13]==1)
target[indices,1] = 1
indices = where(wine[:,13]==2)
target[indices,2] = 1

# Randomly order the data
order = range(shape(wine)[0])
random.shuffle(order)
wine = wine[order,:]
target = target[order,:]

# Split into training, validation, and test sets
train = wine[::2,0:13]
traint = target[::2]
valid = wine[1::4,0:13]
validt = target[1::4]
test = wine[3::4,0:13]
testt = target[3::4]

print "Size data set:",shape(wine)[0]
print "Size training set:",shape(train)[0]
print "Size validation set:",shape(valid)[0]
print "Size test set:",shape(test)[0]

#print train.max(axis=0), train.min(axis=0)

# Train the network
from mlp_python import mlp
net = mlp(shape(train)[1],shape(traint)[1],13,1.0, "linear")

# 
eta = 0.3
epochs = 200
useValidationSet = False

# 
if useValidationSet:
	net.earlystopping(train,traint,valid,validt,eta,epochs)
#	
else:
	for n in range(epochs):
		net.mlptrain(train,traint,shape(train)[0],eta,eta,n)

# Plot a confusion matrix to evaluate the classification quality.
net.confmat(test,testt,shape(test)[0])
