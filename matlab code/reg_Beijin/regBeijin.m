clc;
clear all;
close all;
%读取图像
root='./data';
img=read_train(root);
%%提取特征
img_feature=feature_lattice(img);
% 构造标签
class=32;
numberpclass=20;
ann_label=zeros(class,numberpclass*class);
ann_data=img_feature;
for i=1:class
 for j=numberpclass*(i-1)+1:numberpclass*i
     ann_label(i,j)=1;
 end
end

train_data=ann_data;
train_label = ann_label;

% BP神经网络创建，训练
net=network_train(train_data,train_label);

%%根据训练的网络识别字符
%数字和字符对应情况
res = ['2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','J','K','L','M','N','P','Q','R','S','T','U','V','W','X','Y','Z'];
for n = 241 : 256
    close all;
    %str = 'F:\identifying code\北京\CheckCodeCaptcha(2).jpg';
    str = ['F:\identifying code\北京\test\CheckCodeCaptcha', num2str(n), '.jpg'];
    
    %先切割，切割后二值化 用形态学操作 去掉干扰线 提取模板
    f = imread(str);
    figure
    imshow(f);

    %rgb转二值图像
    f_gray = rgb2gray(f);
    figure
    imshow(f_gray);

    image_bw = im2bw(f_gray,0.5);
    figure
    imshow(image_bw);

    %形态学去干扰线
    se = strel('disk',2);
    image_bw = 1 - image_bw;
    figure
    imshow(image_bw);
    A2 = imerode(image_bw, se);
    figure
    imshow(A2);

    %先提取连通区域 然后再切割
    %提取连通区域
    conn = 8;
    [L, num] = bwlabel(A2, conn);

    %去掉无效连通区域 根据连通区域的宽度 宽度小于10
    area_cnt = 0;%存储有效连通区域的个数
    a = zeros(1,10);%存储有效连通区域的标记
    for cnt = 1:num
        [r,c] = find(L == cnt);
        max_c = max(c);
        min_c = min(c);
        width = max_c - min_c;
        if( width > 10)
            area_cnt = area_cnt + 1;
            a(1,area_cnt) = cnt;
        end  
    end


    %显示每个连通区域
    [nrows, ncols] = size(A2);
    segmented_images = cell(1,area_cnt);%每个连通区域的图像都存在此
    init_image = zeros(nrows, ncols);
    for cnt = 1:area_cnt
        [r,c] = find(L == a(1,cnt));
        segmented_images{cnt} = init_image;
        length = size(r);
        for area_size = 1 :length
            segmented_images{cnt}(r(area_size),c(area_size)) = 255;
        end
        figure
        imshow(segmented_images{cnt});
    end

    %根据连通区域的宽度确定有多少个字符 然后分割
    seg_pos_two = 0.5;%存储分割位置 分割位置最多有三个
    seg_pos_three = [0.33, 0.67];
    seg_pos_four = [0.25, 0.5, 0.75];
    seg_pos = { seg_pos_two, seg_pos_three, seg_pos_three};

    seg_char_img = cell(1,4);
    char_cnt = 0;%记录分割的字符数
     for cnt = 1:area_cnt
        [r,c] = find(L == a(1,cnt));
        max_c = max(c);
        min_c = min(c);
        width = max_c - min_c;
        charactor_num = round(width/30.00);
        if( charactor_num == 1)
            char_cnt = char_cnt + 1;
            seg_char_img{char_cnt} = segmented_images{cnt};
        elseif( charactor_num == 2)
            char_cnt = char_cnt + 1;
            seg_pos1 = min_c + round( width * seg_pos_two(1,1));
            seg_char_img{char_cnt} = segmented_images{cnt}(:,min_c:seg_pos1);

            char_cnt = char_cnt + 1;
            seg_char_img{char_cnt} = segmented_images{cnt}(:,seg_pos1+1:max_c);

        elseif( charactor_num == 3)
            seg_pos1 = min_c + round(width*seg_pos_three(1,1));
            seg_pos2 = min_c + round(width*seg_pos_three(1,2));

            char_cnt = char_cnt + 1;
            seg_char_img{char_cnt} = segmented_images{cnt}(:,min_c:seg_pos1);

            char_cnt = char_cnt + 1;
            seg_char_img{char_cnt} = segmented_images{cnt}(:,seg_pos1+1:seg_pos2);

            char_cnt = char_cnt + 1;
            seg_char_img{char_cnt} = segmented_images{cnt}(:,seg_pos2+1:max_c);

        elseif( charactor_num == 4)
            seg_pos1 = min_c + round(width*seg_pos_four(1,1));
            seg_pos2 = min_c + round(width*seg_pos_four(1,2));
            seg_pos3 = min_c + round(width*seg_pos_four(1,3));

            char_cnt = char_cnt + 1;
            seg_char_img{char_cnt} = segmented_images{cnt}(:,min_c:seg_pos1);

            char_cnt = char_cnt + 1;
            seg_char_img{char_cnt} = segmented_images{cnt}(:,seg_pos1+1:seg_pos2);

            char_cnt = char_cnt + 1;
            seg_char_img{char_cnt} = segmented_images{cnt}(:,seg_pos2+1:seg_pos3);

            char_cnt = char_cnt + 1;
            seg_char_img{char_cnt} = segmented_images{cnt}(:,seg_pos3+1:max_c);
        end
     end

    outputStr = '';
    for cnt = 1:char_cnt
        %去掉全部为0的行 存储数据
        temp = seg_char_img{cnt};
        %去掉列全为0得到新矩阵
        temp_col = ~any(temp);

        [col] = find(temp_col(:,:) ~= 0);
        temp(:,col) = [];

        %去掉行全为0得到新矩阵
        temp_row = ~any(temp');
        [row] = find(temp_row(:,:) ~= 0);
        temp(row,:) = [];

        str = [num2str(n),'_',int2str(cnt)];
        temp_nor = imresize(temp,'OutputSize', [31,26]);
        temp_bw = im2bw(temp_nor,0.9);
        %用训练的网络识别字符
        figure 
        imshow(temp_bw);
%         imwrite(temp_bw, ['D:\Program Files\my matlab code\reg_Beijin\data\' ,str , '.bmp']);
        
        g = feature_lattice({temp_bw});
        an=sim(net,g);
        num_char = ( find(an(:,:) == max(an(:,:))));
        
        %将识别出的数字转成字符
        outputStr = strcat(outputStr,res(num_char));
        
        %imwrite(temp_bw, ['F:\identifying code\北京\lib\' ,str , '.bmp']);
    end
    disp( ['识别字符为', outputStr]);
end






% 尝试用中值滤波来去掉干扰线
% f_gray = rgb2gray(f);
% figure
% imshow(f_gray);
% 
% 实验步骤四:用Matlab系统函数进行中值滤波    
% Y3=medfilt2(f_gray);   %调用系统函数进行中值滤波，n2为模板大小   
% figure,imshow(Y3),title('用Matlab系统函数进行中值滤波之后的结果'); %显示滤波后的图象  
% 用hsv阈值分割 效果不理想
% f = imread('F:\identifying code\北京\CheckCodeCaptcha(14).jpg');
% figure
% imshow(f);
% [row, col, dim] = size(f);
% f_hsv = rgb2hsv(f);
% figure
% imshow(f_hsv);
% f_h = f_hsv(:,:,1);
% [hsv_row, hsv_col] = find( f_h < 0.83 & f_h > 0.82);
% new_image = zeros( row, col );
% [length_row, length_col] = size(hsv_row);
% for i = 1:length_row
%     temp_row = hsv_row(i,1);
%     temp_col = hsv_col(i,1);
%     new_image(temp_row, temp_col) = 255;
% end
% 
% 
% figure
% imshow(new_image);


