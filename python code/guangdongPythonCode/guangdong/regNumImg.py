import regChar
import math

tempperNum = 30
def getNumbyIndex( index ):
    operate_num = math.ceil( float(index) / tempperNum ) - 1
    return operate_num

def getOperate( global_image_dict_sort, num_temp_list, index):
    curDic = global_image_dict_sort[index]
    curimg = curDic['im']
    char_index = regChar.regChar(curimg, num_temp_list)
    operate = getNumbyIndex(char_index)
    return operate

def regNumImg(global_image_dict_sort, num_temp_list):
    operate1 = getOperate( global_image_dict_sort, num_temp_list, 0)
    operate3 = getOperate(global_image_dict_sort, num_temp_list, 2)

    curDic = global_image_dict_sort[1]
    curimg = curDic['im']
    char_index = regChar.regChar(curimg, num_temp_list)

    operate = math.ceil( float(char_index) / tempperNum)

    if( operate == 11):
        result = operate1 * operate3
    elif( operate == 12 ):
        result = operate1 + operate3
    elif( operate == 13 ):
        result = operate1 - operate3
    else:
        result = -1
    return result
