function value = regChar(charImg, templist, imgcnt)
 f = charImg;
 f_resize = imresize(f, [30,30]);
 
 figure
 imshow(f)
 figure
 imshow(f_resize)
 
 len = length(templist);
 [rows, cols] = size(charImg);

 max_similarity = 0;
 for i = 1:len 
     similarity = 0;
     temp = templist{i};
     temp = imresize(temp,[30,30]);
     for row = 1:rows
         for col = 1:cols
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

% if( max_similarity < 300 )
% % figure
% % imshow(templist{value});
% % title('模板库中匹配图片');
% imwrite( templist{value}, ['F:\identifying code\广东\img_png\img\成语\增加模板\对比度小\', num2str(imgcnt), '_temp.png']);
% 
% % figure
% % imshow(charImg);
% % title('待匹配图片');
% imwrite( charImg, ['F:\identifying code\广东\img_png\img\成语\增加模板\对比度小\', num2str(imgcnt), '_src.png']);
end