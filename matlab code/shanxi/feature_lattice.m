function feature = feature_lattice(img)
%���룺��ֵͼ��
%���������ص�ǰ�����������Լ���ɫ���ص�ĸ���
num = length(img);
feature_num = 3;
feature = zeros(num, feature_num);
for i = 1:num
    temp_img = img{i};
    pixel_sum = sum(sum(temp_img == 255));
    phi = abs(log(invmoments(temp_img)));
    feature(i, 1) = (phi( 1 , 1) - 6)*100;
    feature(i, 2) = phi( 1 , 2);
    %feature(i, 3) = phi( 1 , 3);
    feature(i, 3) = pixel_sum;
end
% %�����ݹ�һ��
A = feature';
% B=mapminmax(A,0,1);
% feature = B';