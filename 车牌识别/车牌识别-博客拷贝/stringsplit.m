function [PIN0,PIN1,PIN2,PIN3,PIN4,PIN5,PIN6]=stringsplit(dw)
%�ַ��ָ�������ô�ֱͶӰ��
if isrgb(dw)%���Ϊrgbͼ����ת��Ϊ�Ҷ�ͼ��
I1=rgb2gray(dw);
else 
I1=dw;
end
g_max=double(max(max(I1)));
g_min=double(min(min(I1)));
t=round(g_max-(g_max-g_min)/3);%��ֵ
[m,n]=size(I1);
I2=im2bw(I1,t/256);%��ֵ��
figure,imshow(I2);

[y1,x1,z1]=size(I2);
I3=double(I2);
XX1=zeros(1,x1);%ͳ��ÿһ������ֵΪ1�ĸ���
for jj=1:x1
    for ii=1:y1
        if(I3(ii,jj,1)==1)
            XX1(1,jj)=XX1(1,jj)+1;
        end
    end
end
figure,plot(1:x1,XX1);
Px0=1;
Px1=1;

for i=1:7%�ָ��ַ�
    while((XX1(1,Px0)<3)&&(Px0<x1))%���ַ�����߽�
    Px0=Px0+1;
    end
    Px1=Px0;
    while(((XX1(1,Px1)>=3)&&(Px1<x1))||((Px1-Px0)<10))%���ַ��ұ߽�
    Px1=Px1+1;
    end
    Z=I2(:,Px0:Px1,:);
    switch strcat('Z',num2str(i))
    case 'Z1'
    PIN0=Z;
    case 'Z2'
    PIN1=Z;
    case 'Z3'
    PIN2=Z;
    case 'Z4'
    PIN3=Z;
    case 'Z5'
    PIN4=Z;
    case 'Z6'
    PIN5=Z;
    otherwise
    PIN6=Z;
    end
    figure(3);
    subplot(1,7,i);
    imshow(Z);
    Px0=Px1;
end