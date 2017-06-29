# Data mining 2014, practical tutorial 5, example for
# *** K-Means ***
# Copyright agreement: 
# Do whatever you want, as long as you check the regulations with the original source:
# based on: 
# http://datasciencelab.wordpress.com/2013/12/12/clustering-with-k-means-in-python/

import numpy 
import random

# load data
datafile = "clusters.dat"
#datafile = "sphere.dat"
data = numpy.loadtxt(datafile,delimiter=' ')
dim_in = numpy.shape(data)[1]
num_data = numpy.shape(data)[0]

# parameters
K = 4 # number of clusters

# initialize to K random centroids
oldCentroids = random.sample(data, K)
centroids = random.sample(data, K)

iteration = 0
# loop until cluster centroids do not change
while not (set([tuple(a) for a in centroids]) == set([tuple(a) for a in oldCentroids])):
    # for the termination condition we basically compare all values of the current 
    # centroids with the respective values of the previous centroids

    iteration += 1    
    
	# memorise previous centroids for the termination condition
    oldCentroids = centroids
    
	# ASSIGN all points in data to clusters
    clusters = {} # we start with an empty dictionary
    for x in data:
        # find the centroid with the minimal Euclidean distance for the data point
		# remark: the most efficient way to implement this in python  
		#         is by using the lambda function
		#         Idea: have a anonymous function at runtime
		#         http://www.python-kurs.eu/lambda.php
        bestCentroidsKey = min([(i[0], numpy.linalg.norm(x-centroids[i[0]])) \
                    for i in enumerate(centroids)], key=lambda t:t[1])[0]
        try:
            # append this data point to this cluster with minimal distance
            clusters[bestCentroidsKey].append(x)
        except KeyError:
            clusters[bestCentroidsKey] = [x]
		
    # REEVALUATE centroids
    centroids = []
    keys = sorted(clusters.keys())
    for k in keys:
        centroids.append(numpy.mean(clusters[k], axis = 0))

    # some output:
    print "iteration=",iteration
    for i in range(K):
		print "centroid",i,"=", centroids[i]
    print "------"

