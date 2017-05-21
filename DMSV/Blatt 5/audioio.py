#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import scipy.io.wavfile as wav
import numpy as np


def wavread(filename):
    """Reads a wave file from hard disk

    :filename: Filename of wave file to be read
    :returns: (fs, data) where fs is the sampling frequency

    """
    # read data
    fs, data = wav.read(filename)

    # get dtype of data
    dtype = data.dtype

    # convert data to float64
    data = data.astype(np.float64)

    # convert data
    if dtype == "int8":
        data /= 2**7
    elif dtype == "int16":
        data /= 2**15
    elif dtype == "int32":
        data /= 2**31

    return data, fs


def wavwrite(filename, data, fs, nbits=16):
    """Write a wave file to disk

    :filename: Filename of the wave file
    :data: data to write
    :nbits: number of bits per sample

    """
    if nbits not in [16, 32]:
        print("Sorry can only write 16 or 32 bits at the moment! Exiting")
        return

    if nbits == 16:
        data = data*(2.**15)
        data = data.astype(np.int16)
    elif nbits == 32:
        data = data*(2.**31)
        data = data.astype(np.int32)

    wav.write(filename, fs, data)
