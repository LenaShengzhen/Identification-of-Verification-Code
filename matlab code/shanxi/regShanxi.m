clc;
clear all;
close all;
%读取图像
root='./data';
img=read_train(root);
%%提取特征
img_feature=feature_lattice(img);

train_data = img_feature;

%每个文件夹多少个样本
class = 10;
numberpclass = 8;
feature_num = 3;
svm_label=zeros(numberpclass * class, 1);
for i = 1:class
     svm_label( numberpclass*(i-1) + 1 : i*numberpclass ,1 ) = i;
end


SVMModel = svmtrain( svm_label, train_data,   '-b 1')
 
%f = imread('F:\identifying code\山西\列加连通区域分割\4\70_3.jpg');
test = './test';
test_img=read_train(test);
f_feature=feature_lattice(test_img);

%每个文件夹多少个样本
numberpclass_test = 4;

test_label=zeros(numberpclass_test * class, 1);
for i = 1:class
     test_label( numberpclass_test*(i-1) + 1 : i*numberpclass_test ,1 ) = i;
end


[predicted_label, accuracy, prob_estimates] = svmpredict(test_label, f_feature, SVMModel, ['libsvm_options']);

