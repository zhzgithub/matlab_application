function inp=pretreatment(I)
%�˺����ǽ��ַ�ͼƬ��ת����һά����
if isrgb(I)
    I1=rgb2gray(I);
else
    I1=I;
end
I1=imresize(I1,[20,10]);%��һ��
I1=im2bw(I1,0.9);
[m,n]=size(I1);
inp=zeros(1,m*n);
for j=1:n
    for i=1:m
        inp(1,m*(j-1)+i)=I1(i,j);
    end
end