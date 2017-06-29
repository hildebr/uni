# -*- coding:utf-8 -*-
# This file is for teaching purpose only! You are not allowed to publish,
# distribute, share, or use the code except for the demonstration and
# execution in the Data Mining practical course summer semester 2015.
# based on: 
# http://www.hdm-stuttgart.de/~maucher/Python/FunktionenAlgorithmen/html/genAlgTSP.html

# *** Genetic Algorithm ***

import numpy as np
import time
import matplotlib.pyplot as plt
from matplotlib.nxutils import pnpoly
from scipy.spatial.distance import pdist,squareform

# load data
datafile = "capitals.dat"
data = np.loadtxt(datafile,delimiter=' ')
dim_in = np.shape(data)[1]
if dim_in != 2:
   print "Error: data dimension not suited for the TSP!"

# print out some information of the data
#   generate cities an a plot of the cities within the graphical interface
plt.figure(1)
plt.subplot(121)
plt.grid(True)
plt.hold(True)
#   number of cities (= 44)
num_data = np.shape(data)[0]
cities = num_data
locations = data
print "locations: ", locations
#   calculate the euklidian distance for all tuples of cities
distances = squareform(pdist(locations,'euclidean'))
print "distances: ", distances

np.random.seed()
print "GA start"

# feedback for terminal/gui (defines the speed of this simulation)
feedback_gen = 500			# number of maxGen between feedback
feedback_time = 0.5			# pause in sec every feedback_gen epochs

###########################################################################
#         Genetic Algorithm for solving the TSP           #
###########################################################################

# set parameters (constants) for the GA
# -> here you might want experiment with other values!
maxGen=10000;				# max number of epochs (generations!) to run the GA
popSize=16;					# size of the population
crossProp=0.99;				# crossover propability
mutProp=0.05;				# mutation propability

# memorise the best distance for every generation
bestDist=np.zeros(maxGen) 

# initialise a random population
population=np.zeros((popSize,cities+1))
for j in range(popSize):
    population[j,0:cities]=np.random.permutation(cities)
    population[j,cities]=population[j,0]
print "population: ", population

# memorise the costs for every individuals of the current population
cost=np.zeros(popSize) 

# calculate the costs for the chromosomes
#################################################
for generation in range(maxGen):

    #################################################
    # 1. determine the FITNESS of every individual
    for j,pop in enumerate(population):
        cost[j]=0
        for z in range(cities):
            cost[j]=cost[j]+distances[pop[z],pop[z+1]]

    # indices of individuals ascending sorted by costs 
    sortedIndex=cost.argsort(axis=0) 
		# ascending sorted by costs
    sortedCost=cost[sortedIndex] 
    bestDist[generation]=sortedCost[0]
		# sorted population ascending by costs
    sortedPopulation=population[sortedIndex] 
		# calculates the fitness from the costs
    sortedFitness=1/sortedCost 
    # sortedFitness contains the calculated fitness values

    #################################################
    # 2. SELECTION: random selection of individuals from the population
    # the following process makes sure that the probability for 
		# the selection of an individual is proportional to the fitness 
    sortedFitnessSum = sortedFitness.sum()
    rn1=sortedFitnessSum*np.random.rand()
    found1 = False
    index=1
    while not found1:
        if rn1<sortedFitness[:index].sum(axis=0):
            found1=index
        else:
            index+=1
    found1=found1-1
    equal=True
    while equal:
        rn2=sortedFitnessSum*np.random.rand()
        found2 = False
        index=1
        while not found2:
            if rn2<sortedFitness[:index].sum(axis=0):
                found2=index
            else:
                index+=1
        found2=found2-1
        if found2 != found1:
            equal=False
    parent1=sortedPopulation[found1]
    parent2=sortedPopulation[found2]
    #########
		# parent1 & parent2 are the selected individuals
					
    #################################################
		# 3. CROSS-OVER
    crossrn=np.random.rand()
    if crossrn<crossProp:
        cp=np.ceil(np.random.rand()*cities)
        head1=parent1[:cp]
        tailind=0
        tail1=np.zeros(cities-cp+1)
        for a in range(cities):
            if parent2[a] not in head1:
                tail1[tailind]=parent2[a]
                tailind+=1
        tail1[-1]=head1[0]
        head2=parent2[:cp]
        tailind=0
        tail2=np.zeros(cities-cp+1)
        for a in range(cities):
            if parent1[a] not in head2:
                tail2[tailind]=parent1[a]
                tailind+=1
        tail2[-1]=head2[0]
        child1=np.append(head1,tail1)
        child2=np.append(head2,tail2)
    else:
        child1=parent1[:]
        child2=parent2[:]
    # child1 & child2 are the results of the cross-over

    #################################################
    # 4. MUTATION
    mutrn=np.random.rand()
    if mutrn<mutProp:
        mutInd=np.ceil(np.random.rand(2)*(cities-1))
        first=child1[mutInd[0]]
        second=child1[mutInd[1]]
        child1[mutInd[0]]=second
        child1[mutInd[1]]=first
        child1[-1]=child1[0]

    mutrn=np.random.rand()
    if mutrn<mutProp:
        mutInd=np.ceil(np.random.rand(2)*(cities-1))
        first=child2[mutInd[0]]
        second=child2[mutInd[1]]
        child2[mutInd[0]]=second
        child2[mutInd[1]]=first
        child2[-1]=child2[0]
    #child1 & child2 are the results of the mutation

    #################################################
    # 5. REPLACE the worse individuals by newly created individuals 
		#    in case they are better
    costChild1=0
    costChild2=0
    for z in range(cities):
        costChild1=costChild1+distances[child1[z],child1[z+1]]
        costChild2=costChild2+distances[child2[z],child2[z+1]]
    replace1=False
    replace2=False
    index=popSize-1
    while index > 0:
        if sortedCost[index]>costChild1 and not replace1:
            if not np.ndarray.any(np.ndarray.all(child1==sortedPopulation,axis=1)):
                sortedPopulation[index]=child1
            replace1=True
        elif sortedCost[index]>costChild2 and not replace2:
            if not np.ndarray.any(np.ndarray.all(child2==sortedPopulation,axis=1)):
                sortedPopulation[index]=child2
            replace2=True
        if replace1 and replace2:
            break
        index=index-1
    population=sortedPopulation

    #################################################
    # occasionally give some feedback
    if generation % feedback_gen == 0:
        print "generation=", generation, "best fitness=", sortedFitness[0]
        print sortedPopulation[0]
        print '-'*5
        time.sleep(feedback_time)
    #################################################
		# END of generation
    #################################################

print "GA finished"

# ------------
# graphical visualisation of the costs for the iterations
# and graphical visualisation of the determined path
xcoords=[]
ycoords=[]
for i in range(cities+1):
    xcoords.append(locations[sortedPopulation[0,i],0])
    ycoords.append(locations[sortedPopulation[0,i],1])

plt.plot(xcoords,ycoords,'r-')
print "Best distance ",bestDist[-1]
print "Population ",population[0]
plt.subplot(122)
plt.grid(True)
plt.plot(range(maxGen),bestDist)
plt.show()

