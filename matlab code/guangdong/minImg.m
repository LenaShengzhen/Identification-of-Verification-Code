function minImg = minImg(img);

bw_res = img;
%ȥ����ȫΪ0�õ��¾���
temp_col = ~any(bw_res);

[col] = find(temp_col(:,:) ~= 0);
bw_res(:,col) = [];

%ȥ����ȫΪ0�õ��¾���
temp_row = ~any(bw_res');
[row] = find(temp_row(:,:) ~= 0);
bw_res(row,:) = [];

minImg = bw_res;

%ȥ������Ϊ1