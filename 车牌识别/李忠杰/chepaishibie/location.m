function dw=location(I)
I=imread('che.jpg');%��ȡͼ��

I1=rgb2gray(I);%ת��Ϊ�Ҷ�ͼ��

I2=edge(I1,'roberts',0.09,'both');%����robert���ӽ��б�Ե���

se=[1;1;1]; %���ͽṹԪ�� 
I3=imerode(I2,se);    %��ʴͼ��

se=strel('rectangle',[25,25]);  %���νṹԪ��
I4=imclose(I3,se);%ͼ����ࡢ���ͼ��    imclose:�պ�

I5=bwareaopen(I4,2000);%ȥ�����ŻҶ�ֵС��2000�Ĳ���

[y,x,z]=size(I5);
I6=double(I5);     % size(I6) Ϊ480*640
 Y1=zeros(y,1);
 for i=1:y
    for j=1:x
             if(I6(i,j,1)==1) % I6(i,j,1)��I6(i,j)���Ǹ�1��ʾ����ά�ȣ�I6(i,j,2)�ͻ��������ά��
                Y1(i,1)= Y1(i,1)+1; 
            end  
     end       
 end
 [temp MaxY]=max(Y1);
 
  %%%%%%%��ĳ��Ƶ�����ʼλ�ú���ֹλ��%%%%%%%%%
 PY1=MaxY;
 while ((Y1(PY1,1)>=50)&&(PY1>1))
        PY1=PY1-1;
 end    
 PY2=MaxY;
 while ((Y1(PY2,1)>=50)&&(PY2<y))
        PY2=PY2+1;
 end
 IY=I(PY1:PY2,:,:);
 X1=zeros(1,x);
 for j=1:x
     for i=PY1:PY2
            if(I6(i,j,1)==1)
                X1(1,j)= X1(1,j)+1;               
            end  
     end
 end
 
 %%%%%%%��ĳ��Ƶ�����ʼλ�ú���ֹλ��%%%%%%%%% 
 PX1=1;
 while ((X1(1,PX1)<3)&&(PX1<x))
       PX1=PX1+1;
 end    
 PX2=x;
 while ((X1(1,PX2)<3)&&(PX2>PX1))
        PX2=PX2-1;
 end
 PX1=PX1-1;
 PX2=PX2+1;
 %�ָ������ͼ��%
dw=I(PY1:PY2,PX1:PX2,:); 
