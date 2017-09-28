%������
function  inpt  = pretreatment(I)
%YUCHULI Summary of this function goes here
%   Detailed explanation goes here
if isrgb(I)
   I1 = rgb2gray(I);
else
   I1=I;
end
I1=imresize(I1,[50 20]);%��ͼƬͳһ��Ϊ50*20��С
I1=im2bw(I1,0.9);
[m,n]=size(I1);
inpt=zeros(1,m*n);
%%%%%%��ͼ����ת����һ��������
for j=1:n
    for i=1:m
        inpt(1,m*(j-1)+i)=I1(i,j);
    end
end