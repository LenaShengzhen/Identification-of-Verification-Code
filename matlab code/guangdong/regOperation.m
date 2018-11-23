function result = regOperation( struct_global, templist )
  
cbar_array = [struct_global.cbar];
[~, index] = sort( cbar_array );
 for i = 1:3 %��������� ֻ�ü���ǰ�������ַ�
        curindex = index(i);
        curimg = struct_global(curindex).img;
        [height, width] = size(curimg);
        if( width > 40 )
            disp('�ָ�ʧ��');
            result = -1;
        end
        need_num(i) = regNum(curimg, templist);
        
%         figure
%         imshow(curimg);
%         title( num2str(i) );
 end
    
%����
tempperNum = 8;
operate_num1 = ceil(need_num(1)/tempperNum) - 1;
operate = ceil(need_num(2)/tempperNum);
operate_num2 = ceil(need_num(3)/tempperNum) - 1;
switch operate
    case 11
        result =  operate_num1 + operate_num2;            
    case 12
        result =  operate_num1 - operate_num2;
    case 13
        result =  operate_num1 * operate_num2;
    otherwise
        result = -2;
        disp('ƥ��ʧ��');
end


