% ���������ַ�ʶ�𷽷��������˹������編
close all;
clear all;
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
I11=pretreatment(imread('B.jpg')); 
I12=pretreatment(imread('C.jpg')); 
I13=pretreatment(imread('D.jpg')); 
I14=pretreatment(imread('E.jpg')); 
I15=pretreatment(imread('F.jpg')); 
I16=pretreatment(imread('G.jpg')); 
I17=pretreatment(imread('H.jpg')); 
I18=pretreatment(imread('J.jpg')); 
I19=pretreatment(imread('K.jpg')); 
I20=pretreatment(imread('L.jpg')); 
I21=pretreatment(imread('M.jpg')); 
I22=pretreatment(imread('N.jpg')); 
I23=pretreatment(imread('P.jpg'));
I24=pretreatment(imread('Q.jpg')); 
I25=pretreatment(imread('R.jpg')); 
I26=pretreatment(imread('S.jpg')); 
I27=pretreatment(imread('T.jpg')); 
I28=pretreatment(imread('U.jpg')); 
I29=pretreatment(imread('V.jpg')); 
I30=pretreatment(imread('W.jpg')); 
I31=pretreatment(imread('X.jpg')); 
I32=pretreatment(imread('Y.jpg')); 
I33=pretreatment(imread('Z.jpg')); 

P=[I0',I1',I2',I3',I4',I5',I6',I7',I8',I9',I10',I11',I12',I13',I14',I15',I16',I17',I18',I19',I20',I21',I22',I23',I24',I25',I26',I27',I28',I29',I30',I31',I32',I33'];
T=eye(34,34);
net=newff(minmax(P),[2000,300,34],{'logsig','logsig','logsig'},'trainrp');%minmax()�����ÿһ�����������ֵ����Сֵ
%����newff����һ����ѵ����ǰ�����硣����Ҫ4�����������
%��һ��������һ��Rx2�ľ����Զ���R��������������Сֵ�����ֵ�� 
%�ڶ���������һ���趨ÿ����Ԫ���������飻 
%�����������ǰ���ÿ���õ��Ĵ��ݺ������Ƶ�ϸ�����飻
%���һ���������õ���ѵ�����������ơ�
net.inputWeights{1,1}.initFcn='randnr';
net.inputWeights{2,1}.initFcn='randnr';
net.trainparam.epochs=8000;
net.trainparam.show=50;
net.trainparam.goal=0.0000000001;
net=init(net);%��ʼ��Ȩ�غ�ƫ�õĹ���������init��ʵ�֡������������������󲢳�ʼ��Ȩ�غ�ƫ�ú󷵻��������
[net,tr]=train(net,P,T);

i=imread('chepai.jpg');
dw=location(i);%���ƶ�λ��������ƪ����
[PIN0,PIN1,PIN2,PIN3,PIN4,PIN5,PIN6]=stringsplit(dw);%�ַ��ָ����ƪ����
PIN0=pretreatment(PIN0);
PIN1=pretreatment(PIN1);
PIN2=pretreatment(PIN2);
PIN3=pretreatment(PIN3);
PIN4=pretreatment(PIN4);
PIN5=pretreatment(PIN5);
PIN6=pretreatment(PIN6);

P0=[PIN0',PIN1',PIN2',PIN3',PIN4',PIN5',PIN6'];
for i=2:7
    T0=sim(net,P0(:,i));%T0ΪP0(:,i)����������õ��������T0Ϊ34x1��������
    T1=compet(T0);% compet��������ľ������ݺ���������ָ��������ÿ�е����ֵ����Ӧ���ֵ���е�ֵΪ1�������е�ֵ��Ϊ0
    d=find(T1==1)-1;
    if(d==10)
        str='A';
    elseif(d==11)
        str='B';
    elseif(d==12)
        str='C';
    elseif(d==13)
        str='D';
    elseif(d==14)
        str='E';
    elseif(d==15)
        str='F';
    elseif(d==16)
        str='G';
    elseif(d==17)
        str='H';
    elseif(d==18)
        str='J';
    elseif(d==19)
        str='K';
    elseif(d==20)
        str='L';
    elseif(d==21)
        str='M';
    elseif(d==22)
        str='N';
    elseif(d==23)
        str='P';
    elseif(d==24)
        str='Q';
    elseif(d==25)
        str='R';
    elseif(d==26)
        str='S';
    elseif(d==27)
        str='T';
    elseif(d==28)
        str='U';
    elseif(d==29)
        str='V';
    elseif(d==30)
        str='W';
    elseif(d==31)
        str='X';
    elseif(d==32)
        str='Y';
    elseif(d==33)
        str='Z'; 
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
s=strcat('��',str1,str2,str3,str4,str5,str6);
figure();
imshow(dw),title(s);