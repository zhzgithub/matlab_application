function dw=location(i)
% �˳��ƶ�λ�����õ��ǣ���Ե���+��̬ѧ����ķ����� 
% ȱ�㣺�˷������ڳ���������Χ�Ҷȱ仯���ҵ�������׶�λ����
%���ƶ�λ����
i1=rgb2gray(i);%�ҶȻ�
i2=edge(i1,'roberts');%��Ե���
imshow(i2);
se=[1;1;1];%�и�ʴ���ӣ���ʴ���ӵ���״����Ҫ
i3=imerode(i2,se);%�˸�ʴ�ɽ��ǳ��������������Ϣ��ʴ��
figure,imshow(i3);
se1=strel('rectangle',[25,25]);%���αջ�����
i4=imclose(i3,se1);%�ջ����� ��Ҫѡ��������
figure,imshow(i4);
i5=bwareaopen(i4,1500);%����ͨ�����С��1500���ص�����ɾ�����˷�����Ϊ�˰ѳ��������������ɾ��
figure,imshow(i5);
[y,x,z]=size(i5);
i6=double(i5);
Y1=zeros(y,1);
for ii=1:y%ͳ��ÿһ�е�����ֵΪ1�ĸ���
    for jj=1:x
        if(i6(ii,jj,1)==1)
            Y1(ii,1)=Y1(ii,1)+1;
        end
    end
end
[temp,MaxY]=max(Y1);%tempΪY1�����ֵ��MaxYΪ�����ڵ�����
figure,plot(1:y,Y1);
PY1=MaxY;
while((Y1(PY1,1)>=50)&&(PY1>1))%�����ϱ߽�
    PY1=PY1-1;
end
PY2=MaxY;
while((Y1(PY2,1)>=50)&&(PY2<y))%�����±߽�
    PY2=PY2+1;
end

X1=zeros(1,x);
for jj=1:x%ͳ��ÿһ�е�����ֵΪ1�ĸ�����ֻͳ�Ƴ������±߽�֮���������
    for ii=PY1:PY2
        if(i6(ii,jj,1)==1)
            X1(1,jj)=X1(1,jj)+1;
        end
    end
end
figure,plot(1:x,X1);

PX1=1;
while((X1(1,PX1)<15)&&(PX1<x))%������߽�
    PX1=PX1+1;
end
PX2=x;
while((X1(1,PX2)<15)&&(PX2>PX1))%�����ұ߽�
    PX2=PX2-1;
end
PX1=PX1-1;
PX2=PX2+1;
dw=i(PY1:PY2,PX1:PX2,:);%��ó�������
figure,imshow(dw);