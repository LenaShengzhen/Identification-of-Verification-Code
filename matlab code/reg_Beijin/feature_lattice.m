function feature = feature_lattice(img)
% ����:�ڵװ��ֵĶ�ֵͼ�������35ά����������
% ======��ȡ������ת��5*7������ʸ��,��ͼ����ÿ10*10�ĵ���л�����ӣ�������ӳ�һ����=====%
% ======��ͳ��ÿ��С������ͼ��������ռ�ٷֱ���Ϊ��������====%
% 35������
for i=1:length(img);
    temp_img = img{i};
    
%     lett = zeros(35,1);
    for rowcnt = 1:31
        lett(rowcnt,1) = sum(temp_img(rowcnt,:));
    end
    
    lett(32,1) = sum(sum(temp_img(:,1:6)));
    lett(33,1) = sum(sum(temp_img(:,7:12)));
    lett(34,1) = sum(sum(temp_img(:,13:18)));
    lett(35,1) = sum(sum(temp_img(:,19:26)));
   
lett=lett/31.00;
feature(:,i)=lett;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for i=1:length(img);
%     temp_img = img{i};
%     lett = zeros(42,1);
%     for rowcnt = 1:6
%          temp = temp_img( ((rowcnt - 1) * 5 + 1 ):rowcnt*5 , : );
%          [L, num] = bwlabel(temp, 8);
%          lett(rowcnt,1) = num;
%     end    
%     for colcnt = 1:5
%          temp = temp_img( : , ((colcnt - 1) * 5 + 1 ):colcnt*5 );
%          clear L;
%          clear num;
%          [L, num] = bwlabel(temp, 8);
%          lett(rowcnt,1) = num;
%     end
%     for rowcnt = 1:31
%         lett(rowcnt,1) = sum(temp_img(rowcnt,:));
%     end
%     
% lett=lett/26.00;
% feature(:,i)=lett;
% end