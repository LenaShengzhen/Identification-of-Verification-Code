function minImg = minImg(img);

bw_res = img;
%去掉列全为0得到新矩阵
temp_col = ~any(bw_res);

[col] = find(temp_col(:,:) ~= 0);
bw_res(:,col) = [];

%去掉行全为0得到新矩阵
temp_row = ~any(bw_res');
[row] = find(temp_row(:,:) ~= 0);
bw_res(row,:) = [];

minImg = bw_res;

%去掉行列为1