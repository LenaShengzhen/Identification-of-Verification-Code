import numpy as np
import sys
from scipy.ndimage import morphology
from skimage import morphology
from PIL import Image

def deleteZeroElement( bw_list ):
    #delete the row which is all zero
    row_zero = bw_list.sum(axis=1)
    row_array = np.where(row_zero != 0)[0]
    min_row = row_array.min()
    max_row = row_array.max()
    min_row_bw_list = bw_list[min_row:max_row+1,:]

    # delete the col which is all zero
    col_zero = bw_list.sum(axis=0)
    col_array = np.where(col_zero != 0)[0]
    min_col = col_array.min()
    max_col = col_array.max()
    res_list = min_row_bw_list[:, min_col:max_col + 1]

    return res_list

def preprocessImage( im ):
    h, w = im.shape[:2]
    color_num = 0
    colorInfoArray = []

    for i in range(0, h):
        for j in range(0, w):
            cur_r = im[i, j, 0]
            cur_g = im[i, j, 1]
            cur_b = im[i, j, 2]
            isFind = False
            for k in range(0, color_num):
                cur_dict_element = colorInfoArray[k]
                cur_save_r = cur_dict_element['r']
                cur_save_g = cur_dict_element['g']
                cur_save_b = cur_dict_element['b']
                if cur_r == cur_save_r and cur_g == cur_save_g and cur_b == cur_save_b:
                    cur_dict_element['num'] = cur_dict_element['num'] + 1
                    isFind = True
                    break
            if isFind == False:
                cur_color_dict = {'r': cur_r, 'g': cur_g, 'b': cur_b, 'num': 1}
                color_num = color_num + 1
                colorInfoArray.append(cur_color_dict)

    colorDicBySort = sorted(colorInfoArray, key=lambda s: s['num'], reverse=True)

    global_area = 0
    start_global_num = 1
    end_global_num = 6
    global_image_dict = []

    for i in range(start_global_num, end_global_num):
        isShow = False
        cur_pixel_dict = colorDicBySort[i]
        pixel_num = cur_pixel_dict['num']
        pixel_r = cur_pixel_dict['r']
        pixel_g = cur_pixel_dict['g']
        pixel_b = cur_pixel_dict['b']
        # print cur_pixel_dict
        if pixel_num > 100:
            isShow = True
            global_area = global_area + 1
            char_img = np.zeros(shape=(h, w), dtype=bool)
            for img_row in range(0, h):
                for img_col in range(0, w):
                    img_cur_r = im[img_row, img_col, 0]
                    img_cur_g = im[img_row, img_col, 1]
                    img_cur_b = im[img_row, img_col, 2]
                    if img_cur_r == pixel_r and img_cur_g == pixel_g and img_cur_b == pixel_b:
                        char_img[img_row, img_col] = 1

            dst = morphology.remove_small_objects(char_img, min_size=10, connectivity=1)  # return the image array

            col_array = np.where(dst == 1)
            cbar = np.mean(col_array)
            dst_no_zero = deleteZeroElement(dst)

            dst_no_zero = dst_no_zero * 255
            dst_img = Image.fromarray(dst_no_zero)
            dist_resize_img = dst_img.resize((30,30))
            dst_img_array = np.array(dist_resize_img)
            cur_global_image = {'im': dst_img_array, 'cbar': cbar}
            global_image_dict.append(cur_global_image)


    global_image_dict_sort = sorted(global_image_dict, key=lambda s: s['cbar'], reverse=False)
    return global_image_dict_sort




