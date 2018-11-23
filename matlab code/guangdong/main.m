clc
close all
clear

%�����ַ�ģ��
str='./wordtemp';
chartemplist = read_train(str);

%�����ַ���Ӧ�ʻ��
[num,txt]=xlsread('word.xlsx');

%���������ַ�ģ��
str = './temp';
templist = readTemp(str);

%for imgcnt = 695:726
%     close all;
    %f = imread(['F:\identifying code\�㶫\�������\',num2str(imgcnt),'.png']);
%f = imread( ['F:\identifying code\�㶫\img_png\img\����\word (', num2str(imgcnt), ').png' ]);
% imshow(f);
f = imread('F:\identifying code\pythonGuangdongTemp\img_1207\4.png');
imshow(f);

[rows, cols,~] = size(f);

color_num = 0;%��¼���˱�����ɫ ����ɫ����

 for i = 1:rows
    for j = 1:cols
        cur_r = f(i, j, 1);
        cur_g = f(i, j, 2);
        cur_b = f(i, j, 3);
        isFind = false;
        for k = 1:color_num
            cur_save_r = save_color_struct(k).r;
            cur_save_g = save_color_struct(k).g;
            cur_save_b = save_color_struct(k).b;
            if( cur_r == cur_save_r && cur_g == cur_save_g && cur_b == cur_save_b )
               save_color_struct(k).num = save_color_struct(k).num + 1;
               isFind = true;
               break;
            end 
        end
        if( isFind == false )
            color_num = color_num + 1;
            save_color_struct(color_num).num = 1;
            save_color_struct(color_num).r = cur_r;
            save_color_struct(color_num).g = cur_g;
            save_color_struct(color_num).b = cur_b;
        end
    end
end
% figure
% imshow(f);

 [num ,pos] = sort([save_color_struct.num], 'descend');

  %�������ص���� ȡ��Ŀ������
  global_area = 0;%Ŀ������ĸ��� ����4Ϊ���� ����5Ϊ�����
  for i = 2:6
    isShow = false;
    pixel_num = num(i);%����ɫ���ص�ĸ���
    pixel_pos = pos(i);%����ɫ�����ص��ڽṹ���е�����ֵ
    pixel_r = save_color_struct(pixel_pos).r;
    pixel_g = save_color_struct(pixel_pos).g;
    pixel_b = save_color_struct(pixel_pos).b;
    
    if( pixel_num > 100 )
        isShow = true;
        global_area = global_area + 1;
        char_img = zeros(rows, cols);
        for f_row = 1:rows
            for f_col = 1:cols
                f_cur_r = f(f_row, f_col, 1);
                f_cur_g = f(f_row, f_col, 2);
                f_cur_b = f(f_row, f_col, 3);
                if( f_cur_r == pixel_r && f_cur_g == pixel_g && pixel_b == pixel_b)
                    char_img( f_row, f_col) = 1;
                end
            end
        end
    end
    if( isShow == true )
        char_img = logical( char_img );
%         figure
%       imshow(char_img);
        
        BW = bwareaopen(char_img, 10, 8);
        [r, c] = find( BW == 1);
        cbar = mean(c);
        
        figure
        imshow(BW);
       

        temp = minImg( BW );
        imwrite(temp, ['F:\identifying code\�㶫\img_1207\img_1207\', num2str(i), '.png']);
        
        struct_global(global_area).cbar = cbar;
        struct_global(global_area).img = temp; 
    end
    
  end
    %�ж��ǳ��ﻹ�������ַ�
    if( global_area > 4 )%����
        result = regOperation(struct_global, templist);
        %imwrite( f, ['F:\identifying code\�㶫\�������\���Խ��\',num2str(imgcnt),'_', num2str(result),'.png']);
            
    else %����
        need_num = zeros(1,4);
        cbar_array = [struct_global.cbar];
        [~, index] = sort( cbar_array );
        for i = 1:1 %��������� ֻ�ü���ǰ�������ַ�
            curindex = index(i);
            curimg = struct_global(curindex).img;
            
            char_index = regChar(curimg, chartemplist, imgcnt);
            word_str = txt{char_index};
            
    %       imwrite( f, ['F:\identifying code\�㶫\�������\���Խ��\',word_str,'_', num2str(imgcnt),'.png']);
    %         figure
    %         imshow(curimg);
    %         title( num2str(i) );
        end   
    end
    
    clear save_color_struct;
    clear struct_global;
%end

