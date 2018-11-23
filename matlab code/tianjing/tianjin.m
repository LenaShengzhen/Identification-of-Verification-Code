% f=imread('F:\���\verifycode (1).jpg');
% imshow(f);
% [rowCnt,colCnt]=size(f);
%�ļ���ȡ
clear;
clc;

I_rgb = imread('F:\���\verifycode (3).jpg');      %��ȡ�ļ�����
figure();
imshow(I_rgb);                  %��ʾԭͼ
title('ԭʼͼ��');

%����ɫͼ���RGBת����lab��ɫ�ռ�
C = makecform('srgb2lab');       %����ת����ʽ
I_lab = applycform(I_rgb, C);

%����K-mean���ཫͼ��ָ��3������
ab = double(I_lab(:,:,2:3));    %ȡ��lab�ռ��a������b����
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);

nColors = 4;        %�ָ���������Ϊ3
[cluster_idx cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean','Replicates',10);  %�ظ�����3��
pixel_labels = reshape(cluster_idx,nrows,ncols);
figure();
imshow(pixel_labels,[]), title('������');

%��ʾ�ָ��ĸ�������
segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels,[1 1 3]);

for k = 1:nColors
    color = I_rgb;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
end

figure(),imshow(segmented_images{1}), title('�ָ�����������1');
figure(),imshow(segmented_images{2}), title('�ָ�����������2');
figure(),imshow(segmented_images{3}), title('�ָ�����������3');
figure(),imshow(segmented_images{4}), title('�ָ�����������4');