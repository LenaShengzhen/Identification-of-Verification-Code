close all
clear
clc

% for i = 1:10
%     str1 = 'D:\Program Files\my matlab code\shanxi\temp\temp\rotate';
%     str2 = '.jpg';
%     temp_img{i} = imread([str1, num2str(i), str2]);
% end
% 
%读取模板
% temp_data = read_train('./temp');
% % %读取测试集
% test_data = read_train('./test');
% length = length(test_data);
% for i = 1:length
%     num(i) = regNum(test_data{i}, temp_data)
% end
% bwImg = imread('D:\Program Files\my matlab code\shanxi\test\07\111_1.jpg');
% num = regNum(bwImg, temp_img)

% f = imread('F:\identifying code\山西\0\5_3.jpg');
% imshow(f);
% pixel_sum = sum(sum(f == 255));
% phi = abs(log(invmoments(f)));

%读取模板
temp_data = read_train('./temp');
seg_error_img_num = 0;
for i = 105:105
    close all
    str =[ 'F:\identifying code\山西\validateCode (', int2str(i),').jpg' ]; 
    f = imread(str);
    [seg_img1, seg_img2, seg_img3, isFail, f_kmeans_img] = preprocessing( f );
    if(isFail ~= true )
        save_path1 = ['F:\identifying code\山西\测试集\', num2str(i),'_1.jpg' ];
        num1 = regNum(seg_img1, temp_img);
        save_path2 = ['F:\identifying code\山西\测试集\', num2str(i),'_2.jpg' ];
        num2 = regNum(seg_img2, temp_img);
        save_path3 = ['F:\identifying code\山西\测试集\', num2str(i),'_3.jpg' ];
        num3 = regNum(seg_img3, temp_img);
    else
        seg_error_img_num = seg_error_img_num + 1;
        save_path4 = ['F:\identifying code\山西\测试集\', num2str(i),'_error.jpg' ];
        imwrite( f_kmeans_img, save_path4 );
        
    end
end

disp( ['分割失败图片数量：' , num2str(seg_error_img_num)]);

% f = imread('F:\identifying code\山西\validateCode  (2).jpg');
% f1 = imread('F:\identifying code\山西\validateCode (3).jpg');
% f2 = imread('F:\identifying code\山西\validateCode (4).jpg');
% f3 = imread('F:\identifying code\山西\validateCode (5).jpg');
% f4 = imread('F:\identifying code\山西\validateCode (6).jpg');
% f5 = imread('F:\identifying code\山西\validateCode (7).jpg');
% f6 = imread('F:\identifying code\山西\validateCode (8).jpg');
% f7 = imread('F:\identifying code\山西\validateCode (9).jpg');
% f8 = imread('F:\identifying code\山西\validateCode (10).jpg');

% subplot(10,1,1)
% imshow(f);
% subplot(10,1,2)
% imshow(f1);
% subplot(10,1,3)
% imshow(f2)
% 
% subplot(10,1,4)
% imshow(f3);
% subplot(10,1,5)
% imshow(f4);
% subplot(10,1,6)
% imshow(f5)
% 
% subplot(10,1,7)
% imshow(f6);
% subplot(10,1,8)
% imshow(f7);
% subplot(10,1,9)
% imshow(f8)





