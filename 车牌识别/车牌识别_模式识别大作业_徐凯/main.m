% function [d]=main()
 close all
 clc    % �������ڵ�������������������������

%�Զ�������ʾ�����ͼ��
 [filename,filepath]=uigetfile('.jpg','����һ����Ҫʶ��ĳ���ͼ��');% ֱ���Զ�����%
 file=strcat(filepath,filename); %strcat�����������ַ�������filepath���ַ�����filename�����ӣ���·��/�ļ���
 I=imread(file);
 figure('name','ԭͼ'),imshow(I);title('ԭͼ')
 %ͼ����ǿ
 % h=ones(5,5)/25; %������h
 % I=imfilter(I,h);%���ɫ��ǿ
 % figure('name','���ɫ��ǿ');imshow(I);title('���ɫ��ǿ');

I1=rgb2gray(I); % RGBͼ��ת�Ҷ�ͼ��
 % %figure('name','�Ҷȴ���ǰ'),subplot(1,2,1),imshow(I1);title('�Ҷȴ���ǰ�ĻҶ�ͼ');
% % subplot(1,2,2),imhist(I1);title('�Ҷȴ���ǰ�ĻҶ�ͼֱ��ͼ');
%���ԻҶȱ任
 I1=imadjust(I1,[0.3,0.7],[]);
 figure('name','�Ҷȴ����'),subplot(1,2,1),imshow(I1);title('�Ҷȴ����ĻҶ�ͼ');
 subplot(1,2,2),imhist(I1);title('�Ҷȴ����ĻҶ�ͼֱ��ͼ');
%������ֵ�˲�
 I1=medfilt2(I1);
 figure,imshow(I1);title('��ֵ�˲�');

%��Ե��⣺sobel,roberts,canny,prewitt��
 I2=edge(I1,'roberts',0.25,'both'); %��Ե����㷨��ǿ��С����ֵ0.15�ı�Ե��ʡ�Ե�,'both'���������⣨ȱʡĬ�ϣ�
figure('name','��Ե���'),imshow(I2);title('robert���ӱ�Ե���') 
 se=[1;1;1];
 I3=imerode(I2,se);% ��ʴImerode(X,SE).����X�Ǵ������ͼ��SE�ǽṹԪ�ض���
figure('name','��ʴ��ͼ��'),imshow(I3);title('��ʴ���ͼ��');
 se=strel('rectangle',[20,20]);% 25X25�ľ��� strel???
 I4=imclose(I3,se);% ��25*25�ľ��ζ�ͼ����б�����(�����ͺ�ʴ)��ƽ���߽�����
 figure('name','ƽ������'),imshow(I4);title('ƽ��ͼ�������');
 I5=bwareaopen(I4,1000);% �Ӷ�����ͼ�����Ƴ���������2000���ص����Ӷ�����ʧ���������İ�ɫ������������2000���ַ�
 figure('name','�Ƴ�С����'),imshow(I5);title('�Ӷ������Ƴ�С����');
 [y,x,z]=size(I5);% y��������x��������z��ά��
 myI=double(I5);% ת��˫������
 tic   % ��ʼ��ʱ
 Blue_y=zeros(y,1);% zeros(M,N) ��ʾ����M��*N�е�ȫ0����
 for i=1:y
     for j=1:x
          if(myI(i,j,1)==1) %% �ж���ɫ����
            Blue_y(i,1)= Blue_y(i,1)+1;% ��ɫ���ص�ͳ�� 
          end  
      end       
 end
 [temp MaxY]=max(Blue_y);% Y����������ȷ�� [temp MaxY]��ʱ����MaxY
 PY1=MaxY;  % ����Ϊ�ҳ���Y������Сֵ
 while ((Blue_y(PY1,1)>=5)&&(PY1>1))%% Ϊʲô�ж���ɫ���ص�>=5��������ɫ����������
         PY1=PY1-1;
 end    
 PY2=MaxY; % ����Ϊ�ҳ���Y�������ֵ ???�ѵ����ֵ����MaxY????
 while ((Blue_y(PY2,1)>=5)&&(PY2<y))
         PY2=PY2+1;
 end
 % IY=I(PY1:PY2,:,:);
 %%%%%%%%%%%%%%%%% X���� %%%%%%%%%
 Blue_x=zeros(1,x);% ��һ��ȷ��x����ĳ�������
 for j=1:x
      for i=PY1:PY2  % ֻ��ɨ�����
          if(myI(i,j,1)==1) %% �ж���ɫ����
             Blue_x(1,j)= Blue_x(1,j)+1; % ��ɫ���ص�ͳ��             
          end 
      end   
 end

 PX1=1;% ����Ϊ�ҳ���X������Сֵ
 while ((Blue_x(1,PX1)<5)&&(PX1<x))%% Ϊʲô�ж���ɫ���ص�<3��������ɫ������������
        PX1=PX1+1;
 end    
 PX2=x;% ����Ϊ�ҳ���X�������ֵ
 while ((Blue_x(1,PX2)<3)&&(PX2>PX1))
         PX2=PX2-1;
 end
 PY1=PY1-2;% �Գ��������У�� ΪʲôҪ��ô+��������
 PX1=PX1-2;
 PX2=PX2+3;
 PY2=PY2+10;


 dw=I(PY1:PY2-8,PX1:PX2,:);% �ü�ͼ��
 toc %t=toc; % ֹͣ��ʱ
 %figure(7),subplot(1,2,1),imshow(IY),title('�з����������');
 figure('name','��λ���к�Ĳ�ɫ����ͼ��'),%subplot(1,2,2),
 imshow(dw),title('��λ���к�Ĳ�ɫ����ͼ��')
 imwrite(dw,'dw.jpg');
 % ֱ���Զ�����%[filename,filepath]=uigetfile('dw.jpg','����һ����λ�ü���ĳ���ͼ��');
 %jpg=strcat(filepath,filename); % strcat�����������ַ�������filepath���ַ�����filename�����ӣ���·��/�ļ���
 a=imread('dw.jpg');
 b=rgb2gray(a);
 imwrite(b,'1.���ƻҶ�ͼ��.jpg');
figure('name','���ƴ���');subplot(3,2,1),imshow(b),title('1.���ƻҶ�ͼ��')

%g_max=double(max(max(b)));% ��������ֵ�����Ҷ�ͼת��ֵͼ��
 %g_min=double(min(min(b)));% max(a)���ÿ�е����ֵ����һά���ݣ�max(max(a)) ������һά���ݵ����ֵ��
 %T=round(g_max-(g_max-g_min)/2); % T Ϊ��ֵ������ֵ  round��ȡ��Ϊ���������
 %[m,n]=size(b);% m:b���������� n:b����������
 %d=(double(b)>=T);  % d:��ֵͼ��
 %imwrite(d,'2.���ƶ�ֵͼ��.jpg');

%���ԻҶȱ任
 b=imadjust(b,[0.3,0.7],[]);
 subplot(3,2,2),imshow(b);title('2.���ԻҶȴ����ĻҶ�ͼ');

%���ж�ֵ������
 d=im2bw(b,0.4);%���Ҷ�ͼ����ж�ֵ������
 imwrite(d,'2.���ƶ�ֵͼ��.jpg');
 subplot(3,2,3),imshow(d),title('3.���ƶ�ֵͼ��');%��ʾ��ֵ��ͼ��

%������ֵ�˲�
 d=medfilt2(d);
 imwrite(d,'4.��ֵ�˲���.jpg');
 subplot(3,2,4),imshow(d);title('4.��ֵ�˲���');

% ��ֵ�˲�
 %h=fspecial('average',3);
 %d=im2bw(round(filter2(h,d)));% �˲���im2bw()����ͼ��ת�ɶ�ֵͼ�� (���Բ���round���� Ҳ��һ����)
 %imwrite(d,'4.��ֵ�˲���.jpg');
 %subplot(3,2,4),imshow(d),title('4.��ֵ�˲���')

% ĳЩͼ����в���
 % ���ͻ�ʴ  �������о�ûʲôЧ���֣�����
 % se=strel('square',3);  % ʹ��һ��3X3�������ν��Ԫ�ض���Դ�����ͼ���������
 % 'line'/'diamond'/'ball'/'square'/'dish'... ��/����/��/������/Բ
 se=eye(2); % eye(n) ����n��n��һ���� ��λ����
 [m,n]=size(d);
 if bwarea(d)/m/n>=0.365 % ����bwarea ����Ŀ������������λ�����أ�bwarea/m/n��Ϊ�������أ���
     d=imerode(d,se);% ��ʴ
 elseif bwarea(d)/m/n<=0.235
     d=imdilate(d,se);% ����
 end
 imopen(d,se);

%se=eye(7);
 %imopen(d,se);
 imwrite(d,'5.���ͻ�ʴ�����.jpg');
 subplot(3,2,5),imshow(d),title('5.���ͻ�ʴ�����')
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%�����ַ�ʶ��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Ѱ�����������ֵĿ飬�����ȴ���ĳ��ֵ������Ϊ�ÿ��������ַ���ɣ���Ҫ�ָ�
 d=qiege(d);% ����qiege()�ӳ���
 [m,n]=size(d);
 figure,subplot(2,1,1),imshow(d),title(n)
 k1=1;k2=1;
 j=1;
 s=sum(d);%sum(x)����������ӣ���ÿ�еĺͣ������������;sum(x,2)��ʾ����x�ĺ�����ӣ���ÿ�еĺͣ��������������sum(X(:))��ʾ�������

while j~=n   %%%%% ʲôԭ������
     while s(j)==0  %% �����֣�����Ϊʲô������
         j=j+1;
     end
     k1=j;
     while s(j)~=0 && j<=n-1
         j=j+1;
     end
     k2=j-1;
     if k2-k1>=round(n/6.5)
         [val,num]=min(sum(d(:,[k1+5:k2-5])));
         d(:,k1+num+5)=0;  % �ָ�
     end
 end
 % ���и�
 %d=qiege(d);
 % �и�� 7 ���ַ�
 y1=10;y2=0.25;flag=0;word1=[];
 while flag==0  % flagΪ�Զ��壬�Ա���ѭ����
     [m,n]=size(d);
   left=1;
     wide=0;
     while sum(d(:,wide+1))~=0 % ��ֵͼ�񣺺�ɫ���ش������Ȥ�Ķ������ɫ���ش��������߼�����ֻ����0(��ʾΪ��ɫ)��1(��ʾΪ��ɫ)
         wide=wide+1;% ��wide�����壿
     end
     if wide<y1   % ��Ϊ�������� Ϊʲô��10��
         d(:,[1:wide])=0; % ����ɫ����ǰ�İ�ɫŪ�ɺ�ɫ
 %       figure,imshow(d);
         d=qiege(d); % ������ź��ٴε����и��ӳ���
     else
         temp=qiege(imcrop(d,[1 1 wide m]));% imcrop������ȡͼ��[xmin ymin width height]
         [m,n]=size(temp);
         all=sum(sum(temp));
         two_thirds=sum(sum(temp([round(m/3):2*round(m/3)],:)));
         if two_thirds/all>y2 %����ʲô��˼����
             flag=1;word1=temp;   %��һ���ַ�
         end
         d(:,[1:wide])=0;d=qiege(d); %��Ϊʲô�ִ���һ�Σ�
     end
 end
 % �ָ���ڶ����ַ�
 [word2,d]=getword(d);
 % �ָ���������ַ�
 [word3,d]=getword(d);
 % �ָ�����ĸ��ַ�
 [word4,d]=getword(d);
 % �ָ��������ַ�
 [word5,d]=getword(d);
 % �ָ���������ַ�
 [word6,d]=getword(d);
 % �ָ�����߸��ַ�
 [word7,d]=getword(d);
 subplot(5,7,1),imshow(word1),title('1');
 subplot(5,7,2),imshow(word2),title('2');
 subplot(5,7,3),imshow(word3),title('3');
 subplot(5,7,4),imshow(word4),title('4');
 subplot(5,7,5),imshow(word5),title('5');
 subplot(5,7,6),imshow(word6),title('6');
 subplot(5,7,7),imshow(word7),title('7');
 [m,n]=size(word1);

% ����ϵͳ�����й�һ����СΪ 40*20,�˴���ʾ
 word1=imresize(word1,[40 20]);%imresize��ͼ�������Ŵ������õ��ø�ʽΪ��B=imresize(A,ntimes,method)������method��ѡnearest,bilinear��˫���ԣ�,bicubic,box,lanczors2,lanczors3��
 word2=imresize(word2,[40 20]);
 word3=imresize(word3,[40 20]);
 word4=imresize(word4,[40 20]);
 word5=imresize(word5,[40 20]);
 word6=imresize(word6,[40 20]);
 word7=imresize(word7,[40 20]);

subplot(5,7,15),imshow(word1),title('11');
 subplot(5,7,16),imshow(word2),title('22');
 subplot(5,7,17),imshow(word3),title('33');
 subplot(5,7,18),imshow(word4),title('44');
 subplot(5,7,19),imshow(word5),title('55');
 subplot(5,7,20),imshow(word6),title('66');
 subplot(5,7,21),imshow(word7),title('77');
 imwrite(word1,'1.jpg'); % ������λ�����ַ�ͼ��
 imwrite(word2,'2.jpg');
 imwrite(word3,'3.jpg');
 imwrite(word4,'4.jpg');
 imwrite(word5,'5.jpg');
 imwrite(word6,'6.jpg');
 imwrite(word7,'7.jpg');
 liccode=char(['0':'9' 'A':'Z' '��������³��']);  %�����Զ�ʶ���ַ������'������۰ļ���³ԥ������������ո���������̨�¸��ƴ���ڲ��ɹ�����'
 % ��ţ�0-9�ֱ�Ϊ 1-10;A-Z�ֱ�Ϊ 11-36;
 % ��  ��  ��  ��  ��  ��  ��  ��  ³  ԥ  ��  ��  ��  ��  ��  ��  ��
 % ��  ��  ��  ��  ��  ̨  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��
 % 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 
 % 60 61 62 63 64 65 66 67 68 69 70
 SubBw2=zeros(40,20); % ����һ��40��20�е�0����
 l=1;
 for I=1:7
       ii=int2str(I); % ����������ת��Ϊ�ַ���������
      t=imread([ii,'.jpg']);% ���ζ�����λ�����ַ�
       SegBw2=imresize(t,[40 20],'nearest'); % �Զ�����ַ���������
         if I==1                 % ��һλ����ʶ��
             kmin=37;
             kmax=42;
         elseif I==2             % �ڶ�λ A~Z ��ĸʶ��
             kmin=11;
             kmax=36;
         else   I>=3         % ����λ�Ժ�����ĸ������ʶ�� ;��I>=3
             kmin=1;
             kmax=36;        
         end
         
         for k2=kmin:kmax
             fname=strcat('namebook\',liccode(k2),'.jpg'); % strcat�����������ַ���
             SamBw2 = imread(fname);
             for  i=1:40
                 for j=1:20
                     SubBw2(i,j)=SegBw2(i,j)-SamBw2(i,j);
                 end
             end
            % �����൱������ͼ����õ�������ͼ ����ƥ��
             Dmax=0; % ��ģ�岻ͬ�ĵ����
             for k1=1:40
                 for l1=1:20
                     if  ( SubBw2(k1,l1) > 5 | SubBw2(k1,l1) < -5 ) % "|"/"||" ����� ��>2 15��20����������
                         Dmax=Dmax+1;
                     end
                 end
             end
             Error(k2)=Dmax; % ��¼���ַ���ģ��k2��ͬ�ĵ����
         end      
         Error1=Error(kmin:kmax);
         MinError=min(Error1); % �����С��
         findc=find(Error1==MinError); % �ҳ������С��ģ��
       %  Code(l)=liccode(findc(1)+kmin-1); % �˴���2*l-1�Һ����2*l=' ',�ڸ�һ�ո����һ���ַ�
        % Code(3)=' ';Code(4)=' ';
       %  l=l+1;
       %  if  l==3;% ����λ��ǰ��λ�ַ�����
        %     l=l+2;
      %   end
         Code(l*2-1)=liccode(findc(1)+kmin-1);
        Code(l*2)=' ';
        l=l+1;
 end
 figure(10),subplot(5,7,1:7),imshow(dw),title('��һ�������ƶ�λ'),
 xlabel({'�ڶ��������Ʒָ�'}); %'',

subplot(6,7,15),imshow(word1);
 subplot(6,7,16),imshow(word2);
 subplot(6,7,17),imshow(word3);
 subplot(6,7,18),imshow(word4);
 subplot(6,7,19),imshow(word5);
 subplot(6,7,20),imshow(word6);
 subplot(6,7,21),imshow(word7);

subplot(6,7,22:42),imshow('dw.jpg');%
 xlabel(['��������ʶ����Ϊ(�Ѵ���excel���):', Code],'Color','b');
 xlswrite('C:\Users\MrLevo\Desktop\ģʽʶ�����ҵ_�쿭\���Ƽ�¼.xls',Code,'A1:M1'); %����excel��񣬱����Ҫ�洢������ʱ�����·���������Թ���ԱȨ�޴�matlab
% % handles = guihandles(gcf);              %��û��excel����
 % %set(handles.text1,'string',num2str(Code)); %��������gui���ӻ��ġ�
 