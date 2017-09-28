

close all;
clear all;
%%%%归一化训练样本%%%%%%
I0=pretreatment(imread('0.jpg'));
I1=pretreatment(imread('1.jpg'));
I2=pretreatment(imread('2.jpg'));
I3=pretreatment(imread('3.jpg'));
I4=pretreatment(imread('4.jpg'));
I5=pretreatment(imread('5.jpg'));
I6=pretreatment(imread('6.jpg'));
I7=pretreatment(imread('7.jpg'));
I8=pretreatment(imread('8.jpg'));
I9=pretreatment(imread('9.jpg'));
I10=pretreatment(imread('A.jpg'));
I11=pretreatment(imread('C.jpg'));
I12=pretreatment(imread('G.jpg'));
I13=pretreatment(imread('L.jpg'));
I14=pretreatment(imread('M.jpg'));
I15=pretreatment(imread('R.jpg'));
I16=pretreatment(imread('H.jpg'));
I17=pretreatment(imread('N.jpg'));
P=[I0',I1',I2',I3',I4',I5',I6',I7',I8',I9',I10',I11',I12',I13',I14',I15',I16',I17'];
%输出样本%%%
T=eye(18,18);
%%bp神经网络参数设置
net=newff(minmax(P),[1000,32,18],{'logsig','logsig','logsig'},'trainrp');
net.inputWeights{1,1}.initFcn ='randnr';
net.layerWeights{2,1}.initFcn ='randnr';
net.trainparam.epochs=5000;
net.trainparam.show=50;
%net.trainparam.lr=0.003;
net.trainparam.goal=0.0000000001;
net=init(net);
%%%训练样本%%%%
[net,tr]=train(net,P,T);
%%%%%%%测试%%%%%%%%%
%I=imread('DSC01323.jpg');
I=imread('che.jpg');
dw=location(I);%车牌定位
[PIN0,PIN1,PIN2,PIN3,PIN4,PIN5,PIN6]=StringSplit(dw);%字符分割及处理

%%%%%%%%%%%测试字符，得到识别数值%%%%
PIN0=pretreatment(PIN0);
PIN1=pretreatment(PIN1);
PIN2=pretreatment(PIN2);
PIN3=pretreatment(PIN3);
PIN4=pretreatment(PIN4);
PIN5=pretreatment(PIN5);
PIN6=pretreatment(PIN6);
P0=[PIN0',PIN1',PIN2',PIN3',PIN4',PIN5',PIN6'];
for i=2:7
  T0= sim(net ,P0(:,i));
  T1 = compet (T0) ;
  d =find(T1 == 1) - 1
 if (d==10)
    str='A';
 elseif (d==11)
     str='C';
 elseif (d==12)
     str='G';
 elseif (d==13)
     str='L';
 elseif (d==14)
     str='M';
 elseif (d==15)
     str='R';
 elseif (d==16)
     str='H';
 elseif (d==17)
     str='N';
 else
    str=num2str(d);
 end
 switch i
     case 2
         str1=str;
     case 3
         str2=str;
     case 4
         str3=str;
     case 5
         str4=str;
     case 6
         str5=str;
     otherwise
         str6=str;
  end
end 
%%%%%%%显示定位后的分割出的车牌彩图，%%%
%%%%%%识别结果以标题形式显示在图上%%%
s=strcat('渝',str1,str2,str3,str4,str5,str6); 
figure();
imshow(dw),title(s);