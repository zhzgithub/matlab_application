
clear
clc
I=imread('che.jpg');%��ȡͼ��
figure(1);  subplot(3,2,1),imshow(I), title('ԭʼͼ��');
I1=rgb2gray(I);%ת��Ϊ�Ҷ�ͼ��

graypicture=I1;

subplot(3,2,2),imshow(I1),title('�Ҷ�ͼ��');
I2=edge(I1,'roberts',0.09,'both'); %����robert���ӽ��б�Ե���
subplot(3,2,3),imshow(I2),title('��Ե����ͼ��');


se=[1;1;1]; %���ͽṹԪ�� 
I3=imerode(I2,se);    %��ʴͼ��
subplot(3,2,4),imshow(I3),title('��ʴ���Եͼ��');
se=strel('rectangle',[25,25]);  %���νṹԪ��
I4=imclose(I3,se);%ͼ����ࡢ���ͼ��
subplot(3,2,5),imshow(I4),title('����ͼ��');
I5=bwareaopen(I4,2000);%ȥ�����ŻҶ�ֵС��2000�Ĳ���
subplot(3,2,6),imshow(I5),title('��̬�˲���ͼ��');
[y,x,z]=size(I5);
I6=double(I5);
 Y1=zeros(y,1);
 for i=1:y
    for j=1:x
             if(I6(i,j,1)==1) 
                Y1(i,1)= Y1(i,1)+1; 
            end  
     end       
 end
 [temp MaxY]=max(Y1);
 figure();
 subplot(3,2,1),plot(0:y-1,Y1),title('�з������ص�Ҷ�ֵ�ۼƺ�'),xlabel('��ֵ'),ylabel('����'); 
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
 subplot(3,2,2),plot(0:x-1,X1),title('�з������ص�Ҷ�ֵ�ۼƺ�'),xlabel('��ֵ'),ylabel('����');
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
subplot(3,2,3),imshow(dw),title('��λ���к�Ĳ�ɫ����ͼ��');

%ǰ�������ȫû������

% if isrgb(I)
   I1 = rgb2gray(dw);    %��RGBͼ��ת��Ϊ�Ҷ�ͼ��
% else
%     I1=I;
% end

 g_max=double(max(max(I1)));
 g_min=double(min(min(I1)));
 T=round(g_max-(g_max-g_min)/3); % T Ϊ��ֵ������ֵ
 [m,n]=size(I1);% d:��ֵͼ��
% %h=graythresh(I1);
 I1=im2bw(I1,T/256);
 subplot(3,2,4);
 imshow(I1),title('��ֵ������ͼ��');
 
 
 
 
 
 
 
I2=bwareaopen(I1,20);
subplot(3,2,5);
imshow(I2),title('��̬ѧ�˲���Ķ�ֵ��ͼ��');

[y1,x1,z1]=size(I2);
I3=double(I2);
TT=1;
%%%%%%%ȥ��ͼ�񶥶˺͵׶˵Ĳ�����Ȥ����%%%%%
Y1=zeros(y1,1);
 for i=1:y1
    for j=1:x1
             if(I3(i,j,1)==1) 
                Y1(i,1)= Y1(i,1)+1 ;
            end  
     end       
 end
Py1=1;
Py0=1;
while ((Y1(Py0,1)<20)&&(Py0<y1))
      Py0=Py0+1;
end
Py1=Py0;
 while((Y1(Py1,1)>=20)&&(Py1<y1))
         Py1=Py1+1;
 end
I2=I2(Py0:Py1,:,:);
subplot(3,2,6);
imshow(I2),title('Ŀ�공������');

%%%%%% �ָ��ַ����л�����%%%%%%%
X1=zeros(1,x1);
for j=1:x1
    for i=1:y1
             if(I3(i,j,1)==1) 
                X1(1,j)= X1(1,j)+1;
            end  
     end       
end
figure(5);
plot(0:x1-1,X1),title('�з������ص�Ҷ�ֵ�ۼƺ�'),xlabel('��ֵ'),ylabel('�ۼ�������');

Px0=1;
Px1=1;
%%%%%%%%%%%%�ָ��ַ�%%%%%%%%%%%%%%%%%%
for i=1:7
  while ((X1(1,Px0)<3)&&(Px0<x1))
      Px0=Px0+1;
  end
  Px1=Px0;
  while (((X1(1,Px1)>=3)&&(Px1<x1))||((Px1-Px0)<10))
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







