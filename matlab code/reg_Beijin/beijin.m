for n = 1: 1
    close all;
    str = 'F:\identifying code\����\test\8QP9C.jpg';
    %str = [ 'F:\identifying code\����\train\CheckCodeCaptcha', num2str(n), '.jpg'];
%     str = ['F:\identifying code\����\CheckCodeCaptcha(',num2str(n),').jpg'];
%     figure
%     subplot(10,1,1);
%     f1= imread('F:\identifying code\����\CheckCodeCaptcha(1).jpg');
%     imshow(f1);
%     subplot(10,1,2);
%     f2= imread('F:\identifying code\����\CheckCodeCaptcha(2).jpg');
%     imshow(f2);
%     subplot(10,1,3);
%     f3= imread('F:\identifying code\����\CheckCodeCaptcha(3).jpg');
%     imshow(f3);
%     subplot(10,1,4);
%     f4= imread('F:\identifying code\����\CheckCodeCaptcha(4).jpg');
%     imshow(f4);
%     subplot(10,1,5);
%     f5= imread('F:\identifying code\����\CheckCodeCaptcha(5).jpg');
%     imshow(f5);
%     subplot(10,1,6);
%     f6= imread('F:\identifying code\����\CheckCodeCaptcha(6).jpg');
%     imshow(f6);
%     subplot(10,1,7);
%     f7= imread('F:\identifying code\����\CheckCodeCaptcha(7).jpg');
%     imshow(f7);
%     subplot(10,1,8);
%     f8= imread('F:\identifying code\����\CheckCodeCaptcha(8).jpg');
%     imshow(f8);
%     subplot(10,1,9);
%     f9= imread('F:\identifying code\����\CheckCodeCaptcha(9).jpg');
%     imshow(f9);
%     subplot(10,1,10);
%     f10= imread('F:\identifying code\����\CheckCodeCaptcha(11).jpg');
%     imshow(f10);

%     %���и�и���ֵ�� ����̬ѧ���� ȥ�������� ��ȡģ��
%     f= imread('F:\identifying code\����\CheckCodeCaptcha(4).jpg');
    f = imread(str);
    figure
    imshow(f);

    %rgbת��ֵͼ��
    f_gray = rgb2gray(f);
    figure
    imshow(f_gray);

    image_bw = im2bw(f_gray,0.5);
    figure
    imshow(image_bw);

    %��̬ѧȥ������
    se = strel('disk',2);
    image_bw = 1 - image_bw;
    figure
    imshow(image_bw);
    A2 = imerode(image_bw, se);
    figure
    imshow(A2);

    %����ȡ��ͨ���� Ȼ�����и�
    %��ȡ��ͨ����
    conn = 8;
    [L, num] = bwlabel(A2, conn);

    %ȥ����Ч��ͨ���� ������ͨ����Ŀ�� ���С��10
    area_cnt = 0;%�洢��Ч��ͨ����ĸ���
    a = zeros(1,10);%�洢��Ч��ͨ����ı��
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


    %��ʾÿ����ͨ����
    [nrows, ncols] = size(A2);
    segmented_images = cell(1,area_cnt);%ÿ����ͨ�����ͼ�񶼴��ڴ�
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

    %������ͨ����Ŀ��ȷ���ж��ٸ��ַ� Ȼ��ָ�
    seg_pos_two = 0.5;%�洢�ָ�λ�� �ָ�λ�����������
    seg_pos_three = [0.33, 0.67];
    seg_pos_four = [0.25, 0.5, 0.75];
    seg_pos = { seg_pos_two, seg_pos_three, seg_pos_three};

    seg_char_img = cell(1,4);
    char_cnt = 0;%��¼�ָ���ַ���
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

    for cnt = 1:char_cnt
        %ȥ��ȫ��Ϊ0���� �洢����
        temp = seg_char_img{cnt};
        %ȥ����ȫΪ0�õ��¾���
        temp_col = ~any(temp);

        [col] = find(temp_col(:,:) ~= 0);
        temp(:,col) = [];

        %ȥ����ȫΪ0�õ��¾���
        temp_row = ~any(temp');
        [row] = find(temp_row(:,:) ~= 0);
        temp(row,:) = [];

        str = [num2str(n),'_',int2str(cnt)];
        temp_nor = imresize(temp,'OutputSize', [31,26]);
        temp_bw = im2bw(temp_nor,0.9);
        figure
        imshow(temp_bw);
        %imwrite(temp_bw, ['D:\Program Files\my matlab code\reg_Beijin\data\' ,str , '.bmp']);
    end
end






% ��������ֵ�˲���ȥ��������
% f_gray = rgb2gray(f);
% figure
% imshow(f_gray);
% 
% ʵ�鲽����:��Matlabϵͳ����������ֵ�˲�    
% Y3=medfilt2(f_gray);   %����ϵͳ����������ֵ�˲���n2Ϊģ���С   
% figure,imshow(Y3),title('��Matlabϵͳ����������ֵ�˲�֮��Ľ��'); %��ʾ�˲����ͼ��  
% ��hsv��ֵ�ָ� Ч��������
% f = imread('F:\identifying code\����\CheckCodeCaptcha(14).jpg');
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