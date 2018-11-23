%读入所有模板
function templist = readTemp(str)
img=read_train(str);
 
 [~,len] = size(img);
 similarity_array = zeros(1, len);
for i = 1:len
    temp = img{i};
    temp = imresize(temp, [30 ,30]);
    temp = im2bw(temp, 0.5);
    templist{i} = temp;
end