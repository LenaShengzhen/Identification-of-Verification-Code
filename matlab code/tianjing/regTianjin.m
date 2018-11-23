% ʶ�������֤�����
clear;
clc;
close all;

mask1 = imread('F:\identifying code\���\template lib\temp1.bmp');
mask2 = imread('F:\identifying code\���\template lib\temp2.bmp');
mask3 = imread('F:\identifying code\���\template lib\temp3.bmp');
mask4 = imread('F:\identifying code\���\template lib\temp4.bmp');
mask5 = imread('F:\identifying code\���\template lib\temp5.bmp');
mask6 = imread('F:\identifying code\���\template lib\temp6.bmp');
mask7 = imread('F:\identifying code\���\template lib\temp7.bmp');
mask8 = imread('F:\identifying code\���\template lib\temp8.bmp');
mask9 = imread('F:\identifying code\���\template lib\temp9.bmp');
mask_add = imread('F:\identifying code\���\template lib\add.bmp');
mask_multi = imread('F:\identifying code\���\template lib\mult.bmp');


temp_symbol = {mask_add, mask_multi};%�� �� �� �������һ�� ��ʱ�޶��˷����>100 �ӷ����<90
temp_num_lib = {mask1, mask2, mask3, mask4, mask5, mask6, mask7, mask8, mask9};

%ȥ������ ��ֵ�� Ȼ��ָ��������ȡ����ʶ������
I_rgb = imread('F:\identifying code\���\��ʶ��\verifycode (30).jpg');
figure
imshow(I_rgb)
%������ɫȥ������
I_rgb_new = I_rgb;
[nrows, ncols, n] = size(I_rgb);
for i = 1:nrows
    for j = 1:ncols
        if( I_rgb(i,j,2) > 100 )
            I_rgb_new(i,j,1) = 255;
            I_rgb_new(i,j,2) = 255;
            I_rgb_new(i,j,3) = 255;
        end
    end
end
%������ֵ ��ֵ��ͼ��
image_gray=rgb2gray(I_rgb_new);
figure
imshow(image_gray);

image_bw = im2bw(image_gray,0.5);
figure
imshow(image_bw);

%ָ�������и����ʶ������
area0 = image_bw(4:23, 9:29);
area1 = image_bw(4:26, 36:66);
area2 = image_bw(4:26, 67:94);

 
area = {area0, area1, area2};
length = length(area);
for cnt = 1:length
    temp = 1 - area{cnt};
    %ȥ����ȫΪ0�õ��¾���
    temp_col = ~any(temp);

    [col] = find(temp_col(:,:) ~= 0);
    temp(:,col) = [];

    %ȥ����ȫΪ0�õ��¾���
    temp_row = ~any(temp');
    [row] = find(temp_row(:,:) ~= 0);
    temp(row,:) = [];
    
   
    figure
    imshow(temp);
    
%     if(cnt == 2)
%       imwrite(1-temp, 'F:\identifying code\���\template lib\add.bmp');  
%     end
    
    %��ʼ��ģ���ȶԴ�С
    [temp_row, temp_col] = size(temp);
   [temp_lib_row, temp_lib_length ]= size(temp_num_lib);
    hasSameSize = 0;
    hasMatch = 0;
    
    if(cnt ~= 2)
        for i = 1:temp_lib_length
            temp_area = temp_num_lib{i};
            [area_row, area_col] = size(temp_area);
            if( temp_row == area_row && temp_col == area_col )
                hasSameSize = 1;
                temp = uint8(temp*255);
                if(isequal(temp,temp_area) == 1)
                    hasMatch = 1; 
                    disp(['ʶ��Ϊ���֣�', int2str(i)]);
                else
                     %�����������в���ͬ��Ԫ�ظ���
                    [dif_row, dif_col] = find((temp-temp_area)~=0);
                    [dif_num, dif_non]= size(dif_row);
                    if( dif_num < 5 )
                       hasMatch = 1; 
                       disp(['ʶ��Ϊ���֣�', int2str(i)]);
                    end
                end
             end
        end 
    else
       %ͳ��Ŀ�����ص�ĸ��� 
       [disrow,discol] = find(temp == 1);
       [pixelCnt,pixelcol] = size(disrow);
       if( pixelCnt < 90)
           disp('��');
            hasMatch = 1; 
            hasSameSize =1;
       end
       if( pixelCnt > 90)
            hasMatch = 1; 
            hasSameSize = 1;
           disp('��');
       end
    end


    
    if( hasSameSize == 0)
        disp('��������ͬ�ߴ�');
    end
    if( hasMatch == 0)
        disp('�޷�ƥ��');
    end
end




% f = imread('F:\identifying code\CCHSB__.jpg');
% imshow(f);
% f_hsv = rgb2hsv(f);
% figure
% imshow(f_hsv);
% [nrows, ncols, dim] = size(f_hsv);
% hsv_result_image = zeros(nrows,ncols);
% for i = 1:nrows
%     for j = 1:ncols
%         if( f_hsv(i,j,1) < 0.056 || f_hsv(i,j,1) > 0.867 )
%             hsv_result_image(i,j) = 255;
%         end
%     end
% end
% figure
% imshow(hsv_result_image);