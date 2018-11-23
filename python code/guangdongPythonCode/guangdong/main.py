import os

import numpy as np
import sys
from scipy.ndimage import morphology
from skimage import morphology
from PIL import Image
from scipy.misc import imsave

import preprocessImg
import readAllTemp
import regWord
import regNumImg

#readTemp
word_temp_list = readAllTemp.readWordTemplate()
word_str_list = readAllTemp.readExcelWord()
num_word_list = readAllTemp.readNumWordTemplate()

cur_test_path = os.getcwd() + "/python_test"
for i in range(1, 52):
    #recognize code
    path_img = cur_test_path + '/verify (' + str(i) + ').png'
    image = Image.open(path_img)
    im = np.array(image)
    global_image_dict_sort = preprocessImg.preprocessImage(im)
    global_num = len(global_image_dict_sort)


    if global_num > 4:
        result = regNumImg.regNumImg(global_image_dict_sort, num_word_list)
        print result
    else:
        word_str = regWord.regWord(global_image_dict_sort, word_temp_list, word_str_list)
        print word_str










