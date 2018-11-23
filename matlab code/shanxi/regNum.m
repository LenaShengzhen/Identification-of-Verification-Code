%识别数字

function num = regNum(bwImg, temp_img)

bw = bwImg;
[r c]=find(bw==255);   
[rectx,recty,area,perimeter] = minboundrect(c,r,'p'); % 'a'是按面积算的最小矩形，如果按边长用'p'。
% figure
% imshow(bw);
% line(rectx(:),recty(:),'color','r');

%求包围矩形的长边所在的两点
A = [rectx(1), recty(1)];
B = [rectx(2), recty(2)];
C = [rectx(3), recty(3)];

AB = pdist2(A, B);
BC = pdist2(C, B);

if ( AB > BC)
    vector0 = B - A;
    hold on

plot( A(1),A(2),'o');
plot( B(1),B(2),'*');
else
    vector0 = C - B;
    hold on

plot( C(1),C(2),'o');
plot( B(1),B(2),'*');
end
    vector1 = [0,1];
    angle = (subspace(vector0',vector1')/3.14)*180;

if( vector0(1) > 0)
    angle = -angle;
end

bw = im2bw(bw,0.5);
bw_res = imrotate(bw, angle, 'bilinear');
figure
subplot(1,2,1)
imshow(bw_res);
subplot(122)
imshow(bw); 

%去掉列全为0得到新矩阵
temp_col = ~any(bw_res);

[col] = find(temp_col(:,:) ~= 0);
bw_res(:,col) = [];

%去掉行全为0得到新矩阵
temp_row = ~any(bw_res');
[row] = find(temp_row(:,:) ~= 0);
bw_res(row,:) = [];

figure
imshow(bw_res);

nor_bw_res = imresize(bw_res,[18,18]);

%和模板库里面比对
temp_size = length(temp_img);
distance = zeros(1, temp_size);

for img_cnt = 1:temp_size
    cur_temp = temp_img{img_cnt};
    cur_temp = im2bw(cur_temp,0.5);
    similarty = 0;
    for i = 1:18
        for j = 1:18
           if( cur_temp(i,j) == nor_bw_res(i,j))
               similarty = similarty + 1;
           else
               similarty = similarty - 1;
           end  
        end   
    end
    similarty_array(img_cnt) = similarty;
    
   
end
figure
imshow(nor_bw_res);

[~, pos] = max(similarty_array);

num = pos;

figure
imshow(temp_img{num})




