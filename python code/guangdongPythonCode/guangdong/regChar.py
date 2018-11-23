def regChar(charImg, templist):
    length = len(templist)
    similarity_array = []
    for i in range(0,length):
        similarity = 0
        temp = templist[i]
        for rowcnt in range(0,30):
            for colcnt in range(0,30):
                if temp[rowcnt, colcnt] == charImg[rowcnt, colcnt]:
                    similarity = similarity + 1
                else:
                    similarity = similarity - 1
        similarity_array.append(similarity)

    value = similarity_array.index(max(similarity_array))
    return value
