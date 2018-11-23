import os
import xlrd

import numpy as np
import sys
from scipy.ndimage import morphology
from skimage import morphology
from pylab import *
from PIL import Image

word_temp_path = "/wordtemp"
EXCEL_NAME = "word.xlsx"
cal_word_temp_path = '/num_temp'

#read word template
def readWordTemplate():
    curpath = os.getcwd()  + word_temp_path
    wordTempArray = []
    for x in os.listdir(curpath):
        path = curpath + "/"  + x
        im = Image.open(path)
        out_im = array(im)
        wordTempArray.append(out_im)
    return wordTempArray


def readExcelWord():
    data = xlrd.open_workbook(EXCEL_NAME)
    table = data.sheets()[0]
    colnames = table.col_values(0)
    return colnames

def readNumWordTemplate():
    curpath = os.getcwd() + cal_word_temp_path
    num_temp_array = []
    for x in os.listdir(curpath):
        path = curpath + "/" + x
        im = Image.open(path)
        out_im = array(im)
        num_temp_array.append(out_im)
    return num_temp_array
