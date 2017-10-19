function dw=location(I)
I=imread('che.jpg');%读取图像

I1=rgb2gray(I);%转化为灰度图像

I2=edge(I1,'roberts',0.09,'both');%采用robert算子进行边缘检测

se=[1;1;1]; %线型结构元素 
I3=imerode(I2,se);    %腐蚀图像

se=strel('rectangle',[25,25]);  %矩形结构元素
I4=imclose(I3,se);%图像聚类、填充图像    imclose:闭合

I5=bwareaopen(I4,2000);%去除聚团灰度值小于2000的部分

[y,x,z]=size(I5);
I6=double(I5);     % size(I6) 为480*640
 Y1=zeros(y,1);
 for i=1:y
    for j=1:x
             if(I6(i,j,1)==1) % I6(i,j,1)即I6(i,j)，那个1表示第三维度，I6(i,j,2)就会出错，超出维度
                Y1(i,1)= Y1(i,1)+1; 
            end  
     end       
 end
 [temp MaxY]=max(Y1);
 
  %%%%%%%求的车牌的行起始位置和终止位置%%%%%%%%%
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
 
 %%%%%%%求的车牌的列起始位置和终止位置%%%%%%%%% 
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
 %分割出车牌图像%
dw=I(PY1:PY2,PX1:PX2,:); 
