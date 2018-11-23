function value = regNum(numImg, templist)
 f = numImg;
 f_resize = imresize(f, [30,30], 'nearest');
% f_resize = im2bw(f_resize, 0.5);

%  figure
%  imshow(f_resize);
%  title('需要识别图片');
 
 len = length(templist);

 for i = 1:len 
     similarity = 0;
     temp = templist{i};
     for row = 1:30
         for col = 1:30
             if( temp(row,col) == f_resize(row,col) )
                 similarity = similarity + 1;
             else
                 similarity = similarity - 1;
             end
         end
     end
     similarity_array( i ) = similarity;
 end
 
max_similarity =  max(similarity_array);
value = find(similarity_array == max_similarity);
value = value(1);
% figure
% imshow(templist{value});
% title('模板库中匹配图片');


 