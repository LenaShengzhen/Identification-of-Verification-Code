clear;
clc;
close all;
for i = 1:14
str1 = 'D:\Program Files\my matlab code\shanxi\temp\';
str2 = '.jpg';

bw = imread([str1, num2str(i), str2]);
[r c]=find(bw==255);   
[rectx,recty,area,perimeter] = minboundrect(c,r,'p'); % 'a'�ǰ���������С���Σ�������߳���'p'��
figure
imshow(bw);
line(rectx(:),recty(:),'color','r');

%���Χ���εĳ������ڵ�����
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

%ȥ����ȫΪ0�õ��¾���
temp_col = ~any(bw_res);

[col] = find(temp_col(:,:) ~= 0);
bw_res(:,col) = [];

%ȥ����ȫΪ0�õ��¾���
temp_row = ~any(bw_res');
[row] = find(temp_row(:,:) ~= 0);
bw_res(row,:) = [];

figure
imshow(bw_res);

str1 = 'D:\Program Files\my matlab code\shanxi\temp\rotate';
str2 = '.jpg';

nor_bw_res = imresize(bw_res,[18,18]);
imwrite( nor_bw_res, [str1, num2str(i), str2]);

end
