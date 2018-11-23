%预处理 去除干扰线
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
% 将图像进行RGB——3通道分解  
A = reshape(img_original(:, :, 1), m*n, 1);    % 将RGB分量各转为kmeans使用的数据格式n行，一样一样本  
B = reshape(img_original(:, :, 2), m*n, 1);  
C = reshape(img_original(:, :, 3), m*n, 1);  
dat = [A B C];  % r g b分量组成样本的特征，每个样本有三个属性值，共width*height个样本  
cRGB = kmeans(double(dat), C_Segments,...  
    'Distance','sqEuclidean',...  
    'emptyaction','singleton',...  
    'start','sample',...
    'replicates',100);    % 使用聚类算法分为4类  
rRGB = reshape(cRGB, m, n);     % 反向转化为图片形式  
f_new = label2rgb(rRGB);

%提取出每个标签
f_connet1 = zeros(rows, cols);
f_connet2 = zeros(rows, cols);
f_connet3 = zeros(rows, cols);
f_connet4 = zeros(rows, cols);

f_connet1( find(rRGB == 1)) = 255;
figure
imshow(f_connet1);
title('第一个连通区域，白色');   

f_connet2( find(rRGB == 2)) = 255;
figure
imshow(f_connet2);
title('第二个连通区域，白色');

f_connet3( find(rRGB == 3)) = 255;
figure
imshow(f_connet3);
title('第三个连通区域，白色');

f_connet4( find(rRGB == 4)) = 255;
figure
imshow(f_connet4);
title('第四个连通区域，白色');

%四个区域 分开处理
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
        title(['分割结果', num2str(i)]);
        end
    end

    connect_img_1 = seg_result{1};
    connect_img_2 = seg_result{2};
    connect_img_3 = seg_result{4};

end
figure, 
imshow(f_new),
title('RGB通道分割结果');   % 显示分割结果  
