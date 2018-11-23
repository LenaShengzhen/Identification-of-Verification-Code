close all
clear
clc

%去噪点
%求包围盒
%算距离
f1 =  imread('F:\huadong python\zsj_crack_geetest-master\crack_geetest-master\python_test\screenshot (1).png');
f2 = imread('F:\huadong python\zsj_crack_geetest-master\crack_geetest-master\python_test\screenshot (2).png');

figure
imshow(f1);
title('f1');
figure
imshow(f2);

f1 = double(f1);
f2 = double(f2);

% f_gray = rgb2gray(f1);
% figure
% imshow(f_gray);
% BW1=edge(f_gray,'sobel'); %用SOBEL算子进行边缘检测
% figure
% imshow(BW1);


% hsv_f1 = rgb2hsv(f1);
% hsv_f2 = rgb2hsv(f2);
% figure
% imshow(hsv_f1);

% v = hsv_f1(:,:,3);
% figure
% imshow(v);
% title('v');

% h1 = hsv_f1(:,:,3);
% figure
% imshow(h1);
% title('f1_v');
% 
% h2 = hsv_f2(:,:,3);
% figure
% imshow(h2);
% title('f2_v');

[rows, cols, ~] = size(f1);
% new_imgs = zeros(rows, cols);
% h = h2 - h1;
% figure
% imshow(h);
% for i = 1:rows
%     for j = 1:cols
%         cur_gray = h(i,j);
%         if( cur_gray > 0.1)
%             new_imgs(i,j) = 255;
%         end
%     end
% end
% figure
% imshow(new_imgs);

% s = hsv_f1(:,:,2);
% figure
% imshow(s);
% title('s');

new_imgs = zeros(rows, cols);
for i = 1:rows
    for j = 1:cols
        f1_r = f1(i,j,1);
        f1_g = f1(i,j,2);
        f1_b = f1(i,j,3);
        
        f2_r = f2(i,j,1);
        f2_g = f2(i,j,2);
        f2_b = f2(i,j,3);
        
        if( j == 247 && i == 94)
            new_imgs(i,j) = 255;
        end
        
        if( abs(f1_r - f2_r) > 60 || abs(f1_b - f2_b) > 60 || abs(f1_g - f2_g) > 60)
            new_imgs(i,j) = 255;
        end
    end
end

figure
imshow(new_imgs);
title('对比后的原图像');

BW = bwareaopen(new_imgs, 200, 8);
%去毛刺
se = strel('line', 5, 90);
BW = imerode(BW, se);
figure
imshow(BW);
title('去毛刺图像');

BW = bwareaopen(new_imgs, 200, 8);
% figure
% imshow(BW);

[L, num] = bwlabel(BW, 8);
[r c]=find(L==1);
% 'a'是按面积算的最小矩形，如果按边长用'p'
[rectx,recty,area,perimeter] = minboundrect(c,r,'p'); 
hold on
line(rectx(:),recty(:),'color','r');
x1 = rectx(1);
xright = rectx(2);
y1 = recty(1);
plot(x1,y1, '*');

[r c]=find(L==2);
length_rectx = length(r);
if( length_rectx == 0)
    %如果没有找到第二个区域
    distance = xright - x1;
else
    % 'a'是按面积算的最小矩形，如果按边长用'p'
    [rectx,recty,area,perimeter] = minboundrect(c,r,'p'); 
    %imshow(BW);
    hold on
    line(rectx(:),recty(:),'color','r');
    x2 = rectx(1);
    y2 = recty(1);
    plot(x2,y2, '*');

    distance = x2 - x1; 
end










