%根据需要 返回需要的连通区域部分
%某些汉字，比如加 在提取连通区域时候 可能会分成两个部分 
%考虑每列的像素点个数 如果连续几行等于0 则认为一个字符区域分割完毕
%输入为kmeans均值聚类后的结果
function [img_struct, isFail ]= seg_connect(connect_img)
[~, img_num] = size(connect_img);
result_img_cnt = 0;%最后分割的图像的个数
for i = 1:img_num
    temp_connet = connect_img{i};
    if( sum(sum(temp_connet == 255)) > 5000)%找到目标和背景区域分割图像
        bg_global_img = temp_connet;
        continue;
    else
        
        [L,num] = bwlabel(temp_connet, 8);
        for j = 1:num %检查每一个连通区域，如果太小则变为黑色
            [r,c] = find( L == j);
            [connet_rows,~] = size(r);
             if(connet_rows < 7)
                 for k = 1:connet_rows
                        temp_connet(r(k), c(k)) = 0; 
                 end
             end
        end
        
        %根据列分割元素
        [img_rows, img_cols] = size(temp_connet);
        seg_pos = zeros(1,14);
        pos_cnt = 0;
        for k = 1: img_cols
           if( k+1 <= img_cols)
                sum_cur_col = sum(find( temp_connet(:,k) ~= 0 ));
                sum_next_col = sum(find( temp_connet(:,k + 1 ) ~= 0 ));
                if( (sum_cur_col == 0 && sum_next_col ~= 0) || (sum_cur_col ~= 0 && sum_next_col == 0) || ( k == 1 && sum_cur_col ~= 0) )
                    pos_cnt = pos_cnt + 1;
                    seg_pos(1,pos_cnt) =  k;
                end
           end
        end
        
        %存储新图像
        if( mod (pos_cnt,2) ~= 0)
            disp('分割存储位置有误');
        end
        
        seg_num = pos_cnt/2;
        
        for k = 1:seg_num
            result_img = zeros(img_rows, img_cols);
            temp_pos_front = seg_pos(1,k*2 -1);
            temp_pos_back  = seg_pos(1,k*2);
            cbar = ( temp_pos_front + temp_pos_back )/2;
            width = temp_pos_back - temp_pos_front;
            if( cbar < 103 )
                result_img(:,temp_pos_front:temp_pos_back) = temp_connet(:,temp_pos_front:temp_pos_back);
                
                if( width > 30)%判断此区域宽度是否大于30，以免出现字符列重叠情况,提取连通区域分割。
                   [L_result,num_result] =  bwlabel(result_img, 8);
                   if( num_result >= 2 )
                       [r_result, c_result] = find( L_result == 1);
                       result_img = zeros(img_rows, img_cols);
                       [r_result_num,~] = size(r_result);
                       for q = 1:r_result_num
                           result_img(r_result(q,1), c_result(q,1)) = 255;
                       end  
                   else
                       disp('字符过宽区域,分割有误');
                       isFail = true;
                   end
                end
                    result_img_cnt = result_img_cnt + 1;
                
                    img_struct(result_img_cnt).img  = result_img;
                    img_struct(result_img_cnt).cbar = cbar;
                figure
                imshow(result_img);
            end
            
        end
          
    end
    
end

if(  result_img_cnt ~=  4 )
    disp('分割区域个数有误');
    isFail = true;
else
    isFail = false;
end
