# generate data and write to file
import numpy

set_id   = "spread"

filename = "data_" + set_id + ".dat"
f = open(filename, 'w')

for iter in range(10000):

    if set_id == "sphere":
        x = numpy.random.uniform(0.0, 255.0, 3)
        x = x / numpy.sqrt(numpy.dot(x,x)) * 255.0
        f.write("%f %f %f\n" % (x[0],x[1],x[2]))

    if set_id == "box":
        x = numpy.zeros(3)
        x[0] = numpy.random.uniform(0.0, 20.0) # 20
        x[1] = numpy.random.uniform(0.0, 20.0) # 20
        x[2] = numpy.random.uniform(0.0, 7.0) # numpy.random.normal(0.0, 2.0, 1) # ~7
        f.write("%f %f %f\n" % (x[0],x[1],x[2]))

    if set_id == "triangle":
        x = numpy.zeros(2)
        x[0] = numpy.random.uniform(0.0, 20.0)
        x[1] = numpy.random.uniform(-x[0]*0.1, x[0]*0.1)
        f.write("%f %f\n" % (x[0],x[1]))

    if set_id == "gradient":
        x = numpy.zeros(2)
        while True:
            x[0] = numpy.random.uniform(0.0, 1.0)
            x[1] = numpy.random.uniform(0.0, 1.0)
            valid = numpy.random.uniform(0.0, 1.0)
            if  (valid > x[0]):
                break
        f.write("%f %f\n" % (x[0],x[1]))

    if set_id == "spread":
        x = numpy.zeros(2)
        if  iter < 100:
            x[0] = iter % 10
            x[1] = iter / 10
            x[1] = x[1] * x[1] / 10
            f.write("%f %f\n" % (x[0],x[1]))

    if set_id == "clusters":
        x = numpy.zeros(3)
        while True:
            x[0] = numpy.random.uniform(0.0, 20.0)
            if x[0] < 5.0 or x[0] > 15.0:
                break
        while True:
            x[1] = numpy.random.uniform(0.0, 20.0)
            if x[1] < 5.0 or x[1] > 15.0:
                break
        f.write("%f %f\n" % (x[0],x[1]))

if set_id == "capitals":
    f.write("19.8172 41.3317\n")  # Albania Tirana
    f.write("1.5218 42.5075\n")   # Andorra Andorra la Vella
    f.write("16.3728 48.2092\n")  # Austria Vienna
    f.write("27.5766 53.9678\n")  # Belarus Minsk
    f.write("4.3676 50.8371\n")   # Belgium Brussels
    f.write("18.4214 43.8608\n")  # Bosnia and Herzegovina Sarajevo
    f.write("23.3238 42.7105\n")  # Bulgaria Sofia
    f.write("15.9785 45.8150\n")  # Croatia Zagreb
    f.write("33.1 35.2\n")        # Cyprus Nicosia
    f.write("14.4205 50.0878\n")  # Czech Republic Prague
    f.write("12.5681 55.6763\n")  # Denmark Copenhagen
    f.write("24.7545 59.4389\n")  # Estonia Tallinn
    f.write("24.9384 60.1699\n")  # Kohonen Country Helsinki
    f.write("2.3510 48.8567\n")   # France Paris
    f.write("13.4115 52.5235\n")  # Germany Berlin
    f.write("23.7166 37.9792\n")  # Greece Athens
    f.write("19.0408 47.4984\n")  # Hungary Budapest
    f.write("-21.8952 64.1353\n") # Iceland Reykjavik
    f.write("-6.2675 53.3441\n")  # Ireland Dublin
    f.write("12.4823 41.8955\n")  # Italy Rome
    f.write("24.1049 56.9465\n")  # Latvia Riga
    f.write("9.5215 47.1411\n")   # Liechtenstein Vaduz
    f.write("25.2799 54.6896\n")  # Lithuania Vilnius
    f.write("6.1296 49.6100\n")   # Luxembourg Luxembourg
    f.write("21.4361 42.0024\n")  # Macedonia Skopje
    f.write("14.5189 35.9042\n")  # Malta Valletta
    f.write("28.8497 47.0167\n")  # Moldova Chisinau
    f.write("7.4189 43.7325\n")   # Monaco Monaco
    f.write("19.2595 42.4602\n")  # Montenegro Podgorica
    f.write("4.8910 52.3738\n")   # Netherlands Amsterdam
    f.write("10.7387 59.9138\n")  # Norway Oslo
    f.write("21.0122 52.2297\n")  # Poland Warsaw
    f.write("-9.1355 38.7072\n")  # Portugal Lisbon
    f.write("26.0979 44.4479\n")  # Romania Bucharest
    f.write("37.6176 55.7558\n")  # Russia Moscow
    f.write("12.4578 43.9424\n")  # San Marino San Marino
    f.write("20.4781 44.8048\n")  # Serbia Belgrade
    f.write("17.1547 48.2116\n")  # Slovakia Bratislava
    f.write("14.5060 46.0514\n")  # Slovenia Ljubljana
    f.write("-3.7033 40.4167\n")  # Spain Madrid
    f.write("18.0645 59.3328\n")  # Sweden Stockholm
    f.write("7.4481 46.9480\n")   # Switzerland Bern
    f.write("30.5367 50.4422\n")  # Ukraine Kiev
    f.write("-0.1262 51.5002\n")  # UK London
    # http://www.nobochamp.com/capitals.htm   European capitals

if set_id == "capitalsnames":
    f.write("19.8172 41.3317 Tirana\n")
    f.write("1.5218 42.5075 AndorraLaVella\n")
    f.write("16.3728 48.2092 Vienna\n")
    f.write("27.5766 53.9678 Minsk\n")
    f.write("4.3676 50.8371 Brussels\n")
    f.write("18.4214 43.8608 Sarajevo\n")
    f.write("23.3238 42.7105 Sofia\n")
    f.write("15.9785 45.8150 Zagreb\n")
    f.write("33.1 35.2 Nicosia\n")
    f.write("14.4205 50.0878 Prague\n")
    f.write("12.5681 55.6763 Copenhagen\n")
    f.write("24.7545 59.4389 Tallinn\n")
    f.write("24.9384 60.1699 Helsinki\n")
    f.write("2.3510 48.8567 Paris\n")
    f.write("13.4115 52.5235 Berlin\n")
    f.write("23.7166 37.9792 Athens\n")
    f.write("19.0408 47.4984 Budapest\n")
    f.write("-21.8952 64.1353 Reykjavik\n")
    f.write("-6.2675 53.3441 Dublin\n")
    f.write("12.4823 41.8955 Rome\n")
    f.write("24.1049 56.9465 Riga\n")
    f.write("9.5215 47.1411 Vaduz\n")
    f.write("25.2799 54.6896 Vilnius\n")
    f.write("6.1296 49.6100 Luxembourg\n")
    f.write("21.4361 42.0024 Skopje\n")
    f.write("14.5189 35.9042 Valletta\n")
    f.write("28.8497 47.0167 Chisinau\n")
    f.write("7.4189 43.7325 Monaco\n")
    f.write("19.2595 42.4602 Podgorica\n")
    f.write("4.8910 52.3738 Amsterdam\n")
    f.write("10.7387 59.9138 Oslo\n")
    f.write("21.0122 52.2297 Warsaw\n")
    f.write("-9.1355 38.7072 Lisbon\n")
    f.write("26.0979 44.4479 Bucharest\n")
    f.write("37.6176 55.7558 Moscow\n")
    f.write("12.4578 43.9424 SanMarino\n")
    f.write("20.4781 44.8048 Belgrade\n")
    f.write("17.1547 48.2116 Bratislava\n")
    f.write("14.5060 46.0514 Ljubljana\n")
    f.write("-3.7033 40.4167 Madrid\n")
    f.write("18.0645 59.3328 Stockholm\n")
    f.write("7.4481 46.9480 Bern\n")
    f.write("30.5367 50.4422 Kiev\n")
    f.write("-0.1262 51.5002 London\n")
    # http://www.nobochamp.com/capitals.htm   European capitals

f.close()
