clc;
clear all;
close all;
%%����ѵ��������ʶ���ַ�
%����ģ��
root='./data';
temp_img=read_train(root);
%���ֺ��ַ���Ӧ���
res = ['2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','J','K','L','M','N','P','Q','R','S','T','U','V','W','X','Y','Z'];
for n = 241 : 256
    close all;
    %str = 'F:\identifying code\����\CheckCodeCaptcha(2).jpg';
    str = ['F:\identifying code\����\test\CheckCodeCaptcha', num2str(n), '.jpg'];
    
    %���и�и���ֵ�� ����̬ѧ���� ȥ�������� ��ȡģ��
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

    outputStr = '';
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
        %��ģ��ʶ���ַ�
        [length_row,length_img] = size(temp_img);
        cnt_diff = zeros(1,length_img);
        for img_cnt = 1:length_img
             temp_mat = temp_img{img_cnt};
             diff_piexl =  find( (temp_mat - temp_bw )~=0 );
             [diff_piexl_num, col] = size( diff_piexl ); 
             cnt_diff(1, img_cnt) = diff_piexl_num;
        end
        [cntrow,cntcol] = find( cnt_diff == min(cnt_diff) );
        num_char = ceil(cntcol/32);
        %��ʶ���������ת���ַ�
        outputStr = strcat(outputStr,res(num_char));
        
        %imwrite(temp_bw, ['F:\identifying code\����\lib\' ,str , '.bmp']);
    end
    disp( ['ʶ���ַ�Ϊ', outputStr]);
end