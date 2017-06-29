
# VARIATION OF Code from Chapter 3 of Machine Learning: An Algorithmic Perspective
# by Stephen Marsland (http://seat.massey.ac.nz/personal/s.r.marsland/MLBook.html)

# here, the following changes were done:
# - on-line (not batch) learning; the weight matrices are transposed w.r.t. Marsland's original code
# - data given as arguments to mlptrain (instead of as global variables)
# - made stand-alone ("main" code below; no need for mlprec_eg.py)
# - separate biases/thresholds (i.e. not implemented as extra weights)

# You are free to use, change, or redistribute the code in any way you wish for
# non-commercial purposes, but please maintain the name of the original author.
# This code comes with no warranty of any kind.
# Originally by Stephen Marsland, 2008

import numpy

class mlp:
    """ A Multi-Layer Perceptron"""

    def __init__(self,ninput,noutput,nhidden,beta=1.0,outtype='linear'):
        """ Constructor """
        # 
        self.ninp = ninput
        self.nout = noutput
        self.nhid = nhidden
        self.beta = beta
        self.outtype = outtype

        # 
        self.weights1 = (numpy.random.rand(self.nhid,self.ninp)-0.5)*2/numpy.sqrt(self.ninp)   # inputs -> hidden
        self.weights2 = (numpy.random.rand(self.nout,self.nhid)-0.5)*2/numpy.sqrt(self.nhid)   # hidden -> output

        # 
        self.biases1 = numpy.zeros(self.nhid)
        self.biases2 = numpy.zeros(self.nout)

    # 
    def mlptrain(self,data_inp,data_out,ndata,eta1,eta2,current_epoch):
        """ Train the thing """
        error = 0.0

        for n in range(ndata):

            self.inputs = data_inp[n]
            target = data_out[n]

            self.output = self.mlpfwd(self.inputs)

            if  self.outtype == 'linear':
                # good for squared error
                error += 0.5*numpy.sum((target-self.output)**2)
            elif self.outtype == 'logistic':
                # good for cross entropy error
                error += numpy.sum(-numpy.log(self.output**target * (1.0-self.output)**(1-target)))
            elif self.outtype == 'softmax':
                # good for cross entropy error; 1-of-n class
                error += numpy.sum(-numpy.log(self.output**target * (1.0-self.output)**(1-target)))
            else:
                print "error in mlptrain"

            # 
            deltao = target - self.output

            # 
            deltah = self.beta*self.hidden*(1.0-self.hidden)*(numpy.dot(numpy.transpose(self.weights2),deltao))

            # 
            self.weights1 += eta1*(numpy.outer(deltah,self.inputs))
            self.weights2 += eta2*(numpy.outer(deltao,self.hidden))
            self.biases1  += eta1*deltah
            self.biases2  += eta2*deltao
		
        mean_error = error/ndata
		
        print "Epoch:",current_epoch ,"- Training mean error: %.5f" % mean_error

    # Early stopping only used for task4
    def earlystopping(self,inputs,targets,valid,validtargets,eta,niterations=100):
        
        #valid = numpy.concatenate((valid,-numpy.ones((numpy.shape(valid)[0],1))),axis=1)
        nvdata = numpy.shape(validtargets)[1]
		
        old_val_error1 = 100002
        old_val_error2 = 100001
        new_val_error = 100000
       
        count = 0
        while ((count < niterations) and (((old_val_error1 - new_val_error) > 0.001) or ((old_val_error2 - old_val_error1)>0.001))):
            count+=1

            self.mlptrain(inputs,targets,numpy.shape(inputs)[0],eta,eta,count)
            old_val_error2 = old_val_error1
            old_val_error1 = new_val_error

            new_val_error_sum = 0
            for n in range(nvdata):
                validout = self.mlpfwd(valid[n])
                #new_val_error_sum += 0.5*sum((validtargets[n]-validout)**2)

                if  self.outtype == 'linear':
                    # good for squared error
                    new_val_error_sum += 0.5*numpy.sum((validtargets[n]-validout)**2)
                elif self.outtype == 'logistic':
                    # good for cross entropy error
                    new_val_error_sum += numpy.sum(-numpy.log(validout**validtargets[n] * (1.0-validout)**(1-validtargets[n])))
                elif self.outtype == 'softmax':
                    # good for cross entropy error; 1-of-n class
                    new_val_error_sum += numpy.sum(-numpy.log(validout**validtargets[n] * (1.0-validout)**(1-validtargets[n])))
                else:
                    print "error in mlptrain"

            new_val_error = new_val_error_sum / nvdata
            print "Epoch:",count , "- Validation mean error: %.5f" % new_val_error
            
        print "Stopped", new_val_error,old_val_error1, old_val_error2
        return new_val_error

    # 
    def mlpfwd(self,inputs):
        """ Run the network forward """
        self.hidden = numpy.dot(self.weights1,inputs) + self.biases1

        # 
        self.hidden = 1.0/(1.0+numpy.exp(-self.beta*self.hidden))

        outputs = numpy.dot(self.weights2,self.hidden) + self.biases2

        # Different types of output neurons
        if  self.outtype == 'linear':
            return outputs
        elif self.outtype == 'logistic':
            return 1.0/(1.0+numpy.exp(-outputs))
        elif self.outtype == 'softmax':
            normaliser = numpy.sum(numpy.exp(outputs))
            return numpy.exp(outputs)/normaliser
        else:
            print "error in mlpfwd"


    def confmat(self,test_inp,test_out,ntest):
        """Confusion matrix"""

        outputs = numpy.zeros((ntest,self.nout))
        for n in range(ntest):
            outputs[n] = self.mlpfwd(test_inp[n])

        nclasses = self.nout
        if nclasses==1:
            nclasses = 2
            outputs = numpy.where(outputs>0.5,1,0)
            print 'outputs=', outputs
        else:
            # 1-of-N encoding
            outputs = numpy.argmax(outputs,axis=1)
            test_out = numpy.argmax(test_out,axis=1)

        cm = numpy.zeros((nclasses,nclasses))
        for i in range(nclasses):
            for j in range(nclasses):
                cm[i,j] = numpy.sum(numpy.where(outputs==i,1,0)*numpy.where(test_out==j,1,0))

        print "Confusion matrix is:"
        print cm
        print "Percentage Correct: ",numpy.trace(cm)/numpy.sum(cm)*100
