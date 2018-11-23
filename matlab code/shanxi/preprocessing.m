%Ԥ���� ȥ��������
function [connect_img_1, connect_img_2, connect_img_3 , isFail, f_new]  = preprocessing( f )
[rows, cols, ~] = size(f);
temp = f;

for i = 1:rows
    for j = 1:cols
        r = temp(i,j,1);
        g = temp(i,j,2);
        b = temp(i,j,3);
       %if( abs(r - g)<5 && abs(g - b)<5 )
       %if( r == g && g == b )
       if( (r > 90 && g > 90 && b > 90) || ( r == g && g == b) )
           temp(i,j,1) = 255;
           temp(i,j,2) = 255;
           temp(i,j,3) = 255;
       end
    end
end
figure
imshow(temp);

m = rows;
n = cols;
C_Segments = 4;  
img_original = temp;
% ��ͼ�����RGB����3ͨ���ֽ�  
A = reshape(img_original(:, :, 1), m*n, 1);    % ��RGB������תΪkmeansʹ�õ����ݸ�ʽn�У�һ��һ����  
B = reshape(img_original(:, :, 2), m*n, 1);  
C = reshape(img_original(:, :, 3), m*n, 1);  
dat = [A B C];  % r g b�������������������ÿ����������������ֵ����width*height������  
cRGB = kmeans(double(dat), C_Segments,...  
    'Distance','sqEuclidean',...  
    'emptyaction','singleton',...  
    'start','sample',...
    'replicates',100);    % ʹ�þ����㷨��Ϊ4��  
rRGB = reshape(cRGB, m, n);     % ����ת��ΪͼƬ��ʽ  
f_new = label2rgb(rRGB);

%��ȡ��ÿ����ǩ
f_connet1 = zeros(rows, cols);
f_connet2 = zeros(rows, cols);
f_connet3 = zeros(rows, cols);
f_connet4 = zeros(rows, cols);

f_connet1( find(rRGB == 1)) = 255;
figure
imshow(f_connet1);
title('��һ����ͨ���򣬰�ɫ');   

f_connet2( find(rRGB == 2)) = 255;
figure
imshow(f_connet2);
title('�ڶ�����ͨ���򣬰�ɫ');

f_connet3( find(rRGB == 3)) = 255;
figure
imshow(f_connet3);
title('��������ͨ���򣬰�ɫ');

f_connet4( find(rRGB == 4)) = 255;
figure
imshow(f_connet4);
title('���ĸ���ͨ���򣬰�ɫ');

%�ĸ����� �ֿ�����
connet = {f_connet1,f_connet2, f_connet3, f_connet4};
[img_struct,isFail] = seg_connect(connet);

if( isFail == true )
     connect_img_1 = {};
    connect_img_2 = {};
    connect_img_3 = {};
else
    isFail = false;
    [~,index] = sort([img_struct.cbar]) ;
    [~, seg_img_num] = size(index);
    result_cnt = 0;
    for i = 1:seg_img_num
        if( i ~= seg_img_num - 1)
        result_cnt = result_cnt + 1;
        seg_result_img = img_struct(index(1,i)).img;
        seg_result{i} = seg_result_img;
        figure
        imshow( seg_result_img );
        title(['�ָ���', num2str(i)]);
        end
    end

    connect_img_1 = seg_result{1};
    connect_img_2 = seg_result{2};
    connect_img_3 = seg_result{4};

end
figure, 
imshow(f_new),
title('RGBͨ���ָ���');   % ��ʾ�ָ���  
