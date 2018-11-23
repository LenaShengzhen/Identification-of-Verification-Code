%�������֤������ģ����� �и��ַ�
%�ļ���ȡ
clear;
clc;

% I_0 = imread('F:\���\verifycode (1).jpg');
% I_1 = imread('F:\���\verifycode (2).jpg');
% I_2 = imread('F:\���\verifycode (3).jpg');
% I_3 = imread('F:\���\verifycode (4).jpg');
% I_4 = imread('F:\���\verifycode (5).jpg');
% I_5 = imread('F:\���\verifycode (6).jpg');
% figure
% subplot(611)
% imshow(I_0);
% subplot(612)
% imshow(I_1);
% subplot(613)
% imshow(I_2);
% subplot(614)
% imshow(I_3);
% subplot(615)
% imshow(I_4);
% subplot(616)
% imshow(I_5);


I_rgb = imread('F:\identifying code\���\verifycode (2).jpg');      %��ȡ�ļ�����
figure
imshow(I_rgb);                  %��ʾԭͼ
title('ԭʼͼ��');

I_rgb_new = I_rgb;

%������ɫȥ������
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
figure
imshow(I_rgb_new); 

%������ֵ ��ֵ��ͼ��
image_gray=rgb2gray(I_rgb_new);
figure
imshow(image_gray);

image_bw = im2bw(image_gray,0.5);
figure
imshow(image_bw);

%��ȡ��ͨ����
image_bw = 1 - image_bw;
conn = 8;
[L, num] = bwlabel(image_bw, conn);

%��ʾÿ����ͨ����
cnt = num;
segmented_images = cell(1,cnt);
init_image = zeros(nrows, ncols);
for cnt = 1:num
    [r,c] = find(L == cnt);
    segmented_images{cnt} = init_image;
    length = size(r);
    for area_size = 1 :length
        segmented_images{cnt}(r(area_size),c(area_size)) = 255;
    end
%     figure
%     imshow(segmented_images{cnt});
end

%�и�
for cnt = 1:num
    %ȥ����ȫΪ0�õ��¾���
    temp = segmented_images{cnt};
    temp_col = ~any(temp);
    
    [col] = find(temp_col(:,:) ~= 0);
    temp(:,col) = [];
    
    %ȥ����ȫΪ0�õ��¾���
    temp_row = ~any(temp');
    [row] = find(temp_row(:,:) ~= 0);
    temp(row,:) = [];
    
    segmented_images{cnt} = temp;
    figure
    imshow(temp);
    str = int2str(cnt);
    imwrite(temp, ['F:\identifying code\���\template lib\' ,str , '.bmp']);
end

%ģ��ƥ��


% I_hsv=rgb2hsv(I_rgb);
% figure
% imshow(I_hsv)
% H=I_hsv(:,:,1);
% nrows = size(H,1);
% ncols = size(H,2);
% H = reshape(H,nrows*ncols,1);
% 
% nColors = 5;        %�ָ���������Ϊ3
% [cluster_idx cluster_center] = kmeans( H,nColors,'distance','sqEuclidean','Replicates',30);  %�ظ�����3��
% pixel_labels = reshape(cluster_idx,nrows,ncols);
% figure
% imshow(pixel_labels,[]), title('������');
% 
% imageOne = zeros(nrows, ncols, 3);
% imageTwo = zeros(nrows, ncols, 3);
% imageThree = zeros(nrows, ncols, 3);
% imageFour = zeros(nrows, ncols, 3);
% 
% for i = 1:nrows
%     for j = 1:ncols
% %         if( pixel_labels(i,j) == 1)
% %             imageOne(i,j,1) = 255;
% %             imageOne(i,j,2) = 255;
% %             imageOne(i,j,3) = 255;
% %         end
%         if( pixel_labels(i,j) == 4)
%             imageTwo(i,j,1) = I_rgb(i,j,1);
%             imageTwo(i,j,2) = I_rgb(i,j,2);
%             imageTwo(i,j,3) = I_rgb(i,j,3);
%         end
% %         if( pixel_labels(i,j) == 3)
% %             imageThree(i,j,1) = 255;
% %             imageThree(i,j,2) = 255;
% %             imageThree(i,j,3) = 255;
% %         end
% %         if( pixel_labels(i,j) == 4)
% %             imageFour(i,j,1) = 255;
% %             imageFour(i,j,2) = 255;
% %             imageFour(i,j,3) = 255;
% %         end
%     end
% end
% 
% figure
% imshow(imageTwo);
% title('imageTwo');
% 
% figure
% imshow(I_rgb);                  %��ʾԭͼ
% title('ԭʼͼ��');
% 
% %��ʾ�ָ��ĸ�������
% % segmented_images = cell(1,3);
% % rgb_label = repmat(pixel_labels,[1 1 3]);
% % 
% % for k = 1:nColors
% %     color = I_rgb;
% %     color(rgb_label ~= k) = 0;
% %     segmented_images{k} = color;
% % end
% % 
% % figure(),imshow(segmented_images{1}), title('�ָ�����������1');
% % figure(),imshow(segmented_images{2}), title('�ָ�����������2');
% % figure(),imshow(segmented_images{3}), title('�ָ�����������3');
% % figure(),imshow(segmented_images{4}), title('�ָ�����������4');


