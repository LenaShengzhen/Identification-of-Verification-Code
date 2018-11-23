clc
close all
clear

str = './temp';
templist = readTemp(str);
len = length(templist)
for i = 1 : len
    temp = templist{i};
    temp = imresize(temp, [30 ,30]);
    temp = temp * 255;
    imshow(temp);
    imwrite(temp, ['D:\Program Files\my matlab code\guangdong\temp\numTemp\', num2str(i + 1000), '.png'])
end



% f = imread('F:\identifying code\pythonGuangdongTemp\temp1\1.png');
% imshow(f)
% for i = 1:36
%     str1 = ['F:\identifying code\广东\python matlab imresize比较\matlab\', num2str(i),'.png'];
%     str2 = ['F:\identifying code\广东\python matlab imresize比较\python\result\', num2str(i),'.png'];
%     f1 = imread(str1);
%     f2 = imread(str2);
%     figure 
%     imshow(f1)
%     figure
%     imshow(f2)
%     if( isequal(f1,f2) == 1)
%         disp('same')
%     else
%         length(find((f1-f2)~=0))
%         disp('diff')
%     end
% end


% str = 'F:\identifying code\广东\python matlab imresize比较\test (';
% for i = 1:36
%     str1 = num2str(i);
%     str2 = ').png';
%     f = imread([str, str1, str2]);
%     f = imresize(f, [30, 30]);
%     imwrite(f, ['F:\identifying code\广东\python matlab imresize比较\matlab\', str1,'.png']);
% end

% str='F:\identifying code\广东\img_png\img\成语\增加模板\';
% templist = read_train(str);
% 
% for i = 1: length(templist)
%     temp = templist{i};
%     str1 = 'F:\identifying code\广东\img_png\img\成语\增加模板\';
%     str2 = num2str(i + 1479);
%     str3 = '_1.png';
%     str = [str1, str2, str3];
%     imwrite(temp, str);
% end


% [num,txt]=xlsread('word.xlsx');
% str='./temp';
% templist = readTemp(str);
% for i = 1:60
%     str1 = 'F:\identifying code\广东\运算测试集\verify (';
%     str2 = num2str(i);
%     str3 = ').png';
%     f = imread([str1, str2, str3]);
%     
%     value = regOperation(f,templist);
%     
%     imwrite(f,['F:\identifying code\广东\test运算result\', num2str(i), '_', num2str(value),'.jpg']);
% end
% num = regNum(f, templist);

% for imgcnt = 1:479
%     close all;
% %f = imread(['F:\identifying code\广东\test成语\verifyWord (',num2str(imgcnt),').png']);
% f = imread( ['F:\identifying code\广东\img_png\img\成语\word (', num2str(imgcnt), ').png' ]);
% % imshow(f);
% 
% [rows, cols,~] = size(f);
% 
% color_num = 0;%记录除了背景颜色 的颜色种类
% 
%  for i = 1:rows
%     for j = 1:cols
%         cur_r = f(i, j, 1);
%         cur_g = f(i, j, 2);
%         cur_b = f(i, j, 3);
%         isFind = false;
%         for k = 1:color_num
%             cur_save_r = save_color_struct(k).r;
%             cur_save_g = save_color_struct(k).g;
%             cur_save_b = save_color_struct(k).b;
%             if( cur_r == cur_save_r && cur_g == cur_save_g && cur_b == cur_save_b )
%                save_color_struct(k).num = save_color_struct(k).num + 1;
%                isFind = true;
%                break;
%             end 
%         end
%         if( isFind == false )
%             color_num = color_num + 1;
%             save_color_struct(color_num).num = 1;
%             save_color_struct(color_num).r = cur_r;
%             save_color_struct(color_num).g = cur_g;
%             save_color_struct(color_num).b = cur_b;
%         end
%     end
% end
% % figure
% % imshow(f);
% 
%  [num ,pos] = sort([save_color_struct.num], 'descend');
% 
%   %根据像素点个数 取出目标区域
%   global_area = 0;%目标区域的个数 等于4为成语 等于5为运算符
%   for i = 2:6
%     isShow = false;
%     pixel_num = num(i);%此颜色像素点的个数
%     pixel_pos = pos(i);%此颜色的像素点在结构体中的索引值
%     pixel_r = save_color_struct(pixel_pos).r;
%     pixel_g = save_color_struct(pixel_pos).g;
%     pixel_b = save_color_struct(pixel_pos).b;
%     
%     if( pixel_num > 100 )
%         isShow = true;
%         global_area = global_area + 1;
%         char_img = zeros(rows, cols);
%         for f_row = 1:rows
%             for f_col = 1:cols
%                 f_cur_r = f(f_row, f_col, 1);
%                 f_cur_g = f(f_row, f_col, 2);
%                 f_cur_b = f(f_row, f_col, 3);
%                 if( f_cur_r == pixel_r && f_cur_g == pixel_g && pixel_b == pixel_b)
%                     char_img( f_row, f_col) = 1;
%                 end
%             end
%         end
%     end
%     if( isShow == true )
%         char_img = logical( char_img );
% %         figure
% %       imshow(char_img);
%         
%         BW = bwareaopen(char_img, 10, 8);
%         [r, c] = find( BW == 1);
%         cbar = mean(c);
%         
% %         figure
% %         imshow(BW);
% 
%         temp = minImg( BW );
%         
%         struct_global(global_area).cbar = cbar;
%         struct_global(global_area).img = temp; 
%     end
%     
%   end
%     %判断是成语还是运算字符
%     if( global_area > 4 )%运算
%         str1 = 'F:\identifying code\广东\img_png\img\运算\';
%         str2 = num2str(imgcnt);
%         str3 = '.png';
%         imwrite( f, [str1, str2, str3]);
%         
%     else %成语
% %         str1 = 'F:\identifying code\广东\img_png\img\成语\';
% %         str2 = num2str(imgcnt);
% %         str3 = '.png';
% %         imwrite( f, [str1, str2, str3]);
%         need_num = zeros(1,4);
%         cbar_array = [struct_global.cbar];
%         [~, index] = sort( cbar_array );
%         for i = 1:1 %运算符计算 只用计算前面三个字符
%             curindex = index(i);
%             curimg = struct_global(curindex).img;
% 
%     %         figure
%     %         imshow(curimg);
%     %         title( num2str(i) );
%         
%             str1 = 'F:\identifying code\广东\img_png\img\成语\';
%             str2 = [num2str(imgcnt+1000), '_1'];
%             str3 = '.png';
%             imwrite( curimg, [str1, str2, str3]);
%         end   
%     end
%     
%     clear save_color_struct;
%     clear struct_global;
% end

