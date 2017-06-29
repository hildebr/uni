# Data mining 2014, practical tutorial 5, example for
# *** Self-Organising Map ***
# Copyright agreement: 
# Do whatever you want.

import numpy, scipy

# set parameters
dim_a, dim_b = 5, 5                              # map sizes
sigma = numpy.max([float(dim_a),float(dim_b)])   # initial map interaction range
epsilon = 0.03                                   # learning step size

# load data
datafile = "triangle.dat"
data = numpy.loadtxt(datafile,delimiter=' ')
dim_in = numpy.shape(data)[1]
num_data = numpy.shape(data)[0]

# create architecture
size_map = dim_a * dim_b
W = numpy.zeros((size_map, dim_in))
map_net = numpy.zeros(size_map)
map_act = numpy.zeros(size_map)

# initialize weights
for j in range(dim_in):
    for k in range(size_map):
        W[k,j] += numpy.random.uniform(numpy.min(data[:,j]),numpy.max(data[:,j]))

# for small data sets, repeat all-over again
for batch in range(1):
    # iterate (one data point per iteration)
    for iter in range(num_data):

        # current data point
        x = data[iter]

        # neurons' inner activation
        for k in range(size_map):
            map_net[k] = numpy.dot(W[k]-x,W[k]-x)

        # find winner
        winner = scipy.argmin(map_net)

        # activation with map interaction function
        for k in range(size_map):
            dist = numpy.sqrt((k/dim_b-winner/dim_b)**2 + (k%dim_b-winner%dim_b)**2)
            map_act[k] = numpy.exp(-0.5 * dist**2 / sigma**2)

        # learning step
        for k in range(size_map):
            W[k] += epsilon * map_act[k] * (x-W[k])

        # reduce map interaction range
        sigma *= 0.999

        # occasionally give some feedback
        if iter % 1000 == 0:
            print "sigma=", sigma, "winner=", winner, "x=", x


# SOM finished - now visualise

# write weights as 2D- or 3D-point coordinates for display with gnuplot
f = open("out.dat", 'wb')
for i in range(dim_a):
    for k in range(dim_b):
        for j in range(dim_in):
            val_ch = str(W[i*dim_b+k,j]) + " "
            f.write(val_ch)
        f.write("\n")
    f.write("\n")
f.close()

# write gnuplot commands to draw grid
f = open("out.gnu", 'wb')
for i in range(dim_a):
    for k in range(dim_b-1):
        val_string = "set arrow from "
        for j in range(dim_in):
            val_string += str(W[i*dim_b+k,j])
            if j < dim_in - 1:
                val_string += ", "
        val_string += " to "
        for j in range(dim_in):
            val_string += str(W[i*dim_b+k+1,j])
            if j < dim_in - 1:
                val_string += ", "
        val_string += " nohead\n"
        f.write(val_string)
for k in range(dim_b):
    for i in range(dim_a-1):
        val_string = "set arrow from "
        for j in range(dim_in):
            val_string += str(W[i*dim_b+k,j])
            if j < dim_in - 1:
                val_string += ", "
        val_string += " to "
        for j in range(dim_in):
            val_string += str(W[(i+1)*dim_b+k,j])
            if j < dim_in - 1:
                val_string += ", "
        val_string += " nohead\n"
        f.write(val_string)
val_string = "set arrow from "

#f.write("set xrange [%f:%f]\nset yrange [%f:%f]\nset zrange [%f:%f]\n" % (numpy.min(W), numpy.max(W), numpy.min(W), numpy.max(W), numpy.min(W), numpy.max(W)))
#f.write("set isosamples 2, 2\nsplot %f linestyle 0\n" % (numpy.min(W))) # splot brings the window to the screen (the set arrows command doesn't draw by itself)
f.write("replot\n")
f.close()

