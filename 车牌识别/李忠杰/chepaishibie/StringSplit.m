function [PIN0,PIN1,PIN2,PIN3,PIN4,PIN5,PIN6]=StringSplit(dw)
% 4.2 车牌字符分割
% 确定车牌位置后下一步的任务就是进行字符切分分离出车牌号码的全部字符图像。
%if isrgb(I)
%   I1 = rgb2gray(I);    %将RGB图像转化为灰度图像
%else   I1=I;  
%end
if isrgb(dw)
   I1 = rgb2gray(dw);    %将RGB图像转化为灰度图像
else   I1=dw;  
end
g_max=double(max(max(I1)));
g_min=double(min(min(I1)));
T=round(g_max-(g_max-g_min)/3); % T 为二值化的阈值
[m,n]=size(I1);% d:二值图像
%h=graythresh(I1);
I1=im2bw(I1,T/256);

I2=bwareaopen(I1,20);

[y1,x1,z1]=size(I2);
I3=double(I2);
TT=1;
%%%%%%%去除图像顶端和底端的不感兴趣区域%%%%%
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


%%%%%% 分割字符按行积累量%%%%%%%
X1=zeros(1,x1);
for j=1:x1
    for i=1:y1
             if(I3(i,j,1)==1) 
                X1(1,j)= X1(1,j)+1;
            end  
     end       
end
figure(5);
plot(0:x1-1,X1),title('列方向像素点灰度值累计和'),xlabel('列值'),ylabel('累计像素量');

Px0=1;
Px1=1;

%%%%%%%%%%%%分割字符%%%%%%%%%%%%%%%%%%
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
    Px0=Px1;
end