clc;
clear all;
close all;
%��ȡͼ��
root='./data';
img=read_train(root);
%%��ȡ����
img_feature=feature_lattice(img);

train_data = img_feature;

%ÿ���ļ��ж��ٸ�����
class = 10;
numberpclass = 8;
feature_num = 3;
svm_label=zeros(numberpclass * class, 1);
for i = 1:class
     svm_label( numberpclass*(i-1) + 1 : i*numberpclass ,1 ) = i;
end


SVMModel = svmtrain( svm_label, train_data,   '-b 1')
 
%f = imread('F:\identifying code\ɽ��\�м���ͨ����ָ�\4\70_3.jpg');
test = './test';
test_img=read_train(test);
f_feature=feature_lattice(test_img);

%ÿ���ļ��ж��ٸ�����
numberpclass_test = 4;

test_label=zeros(numberpclass_test * class, 1);
for i = 1:class
     test_label( numberpclass_test*(i-1) + 1 : i*numberpclass_test ,1 ) = i;
end


[predicted_label, accuracy, prob_estimates] = svmpredict(test_label, f_feature, SVMModel, ['libsvm_options']);

