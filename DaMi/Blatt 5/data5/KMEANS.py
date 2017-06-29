# -*- coding:utf-8 -*-
# This file is for teaching purpose only! You are not allowed to publish,
# distribute, share, or use the code except for the demonstration and
# execution in the Data Mining practical course summer semester 2015.
# based on: 
# http://datasciencelab.wordpress.com/2013/12/12/clustering-with-k-means-in-python/

# *** K-Means ***

import numpy 
import random
import Gnuplot
import time

# set parameters
K = 4 											# number of clusters

# load data
#datafile = "triangle.dat"
#datafile = "box.dat"
#datafile = "sphere.dat"
datafile = "clusters.dat"
data = numpy.loadtxt(datafile,delimiter=' ')
dim_in = numpy.shape(data)[1]
num_data = numpy.shape(data)[0]

# initialite to K random centroids
oldCentroids = random.sample(data, K)
centroids = random.sample(data, K)
# print out the initial centroids
print "initialisation"
for i in range(K):
	print "centroid", i,"=", centroids[i]
print "----"

# feedback for terminal/gui (defines the speed of this simulation)
feedback_time = 0.5								# pause in sec iteration

# trigger the visual feedback in Gnuplot
g1 = Gnuplot.Gnuplot()
print "KMEANS start", datafile

iteration = 0
# loop until cluster centroids do not change
while not (set([tuple(a) for a in centroids]) == set([tuple(a) for a in oldCentroids])):
    # for the termination condition we basically compare all values of the current 
    # centroids with the respective values of the previous centroids
    
    # memorise previous centroids for the termination condition
    oldCentroids = centroids
    iteration += 1    
    
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

    # give some feedback
    print "iteration=", iteration
    for i in range(K):
		print "centroid", i,"=", centroids[i]
    print "-----"
    time.sleep(feedback_time)

    # ------------
    # draws KMEANS cluster for display with Gnuplot
    f = open("centroids.dat", 'wb')
    for c in centroids:
        f.write(str(c[0])+" "+str(c[1])+"\n")
    f.close()
    g1.reset()
    g1('unset key')
    g1('plot "'+datafile+'" with dots')
    g1('replot "centroids.dat" with points')

print "KMEANS finished", datafile

# raw_input("Press Enter to close") # use this of you want to run the script from command line
