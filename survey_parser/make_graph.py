## numpy is used for creating fake data

import numpy as np
from pandas import DataFrame as df
from pandas.plotting import table
from scipy.stats import trim_mean, kurtosis
from scipy.stats.mstats import mode, gmean, hmean
import matplotlib as mpl
import csv
import string
import os
from matplotlib.ticker import ScalarFormatter

## agg backend is used to create plot as a .png file
mpl.use('agg')

import matplotlib.pyplot as plt

 # create folders
if not os.path.exists("./csv"):
    os.makedirs("./csv")

# Normal relative
normal_relative = np.loadtxt(open("csv/bound.log","r+"),
                         usecols=(1,2,3,4,5,6),
                         unpack = True,
                         delimiter = ',',
                         dtype = float
                         )
