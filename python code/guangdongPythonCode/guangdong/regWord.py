import regChar

def regWord(global_image_dict_sort, templist, wordlist):
    curDic = global_image_dict_sort[0]
    curimg = curDic['im']
    char_index = regChar.regChar(curimg, templist)
    str = wordlist[char_index]
    return str