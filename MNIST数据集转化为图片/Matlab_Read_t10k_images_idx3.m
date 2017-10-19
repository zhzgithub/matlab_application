% Matlab_Read_t10k-images_idx3.m
% ���ڶ�ȡMNIST���ݼ���t10k-images.idx3-ubyte�ļ�������ת����bmp��ʽͼƬ�����
% �÷������г��򣬻ᵯ��ѡ�����ͼƬ�����ļ�t10k-labels.idx1-ubyte·���ĶԻ����
% ѡ�񱣴����ͼƬ·���ĶԻ���ѡ��·��������Զ�������ϣ��ڼ����������ʾ������ȡ�
% ͼƬ��TestImage_00001.bmp��TestImage_10000.bmp�ĸ�ʽ������ָ��·����10000���ļ�ռ�ÿռ�39M����
% �����������й����輸����ʱ�䡣
% Written By DXY@HUST IPRAI
% 2009-2-22
clear all;
clc;
%��ȡ����ͼƬ�����ļ�
[FileName,PathName] = uigetfile('*.*','ѡ�����ͼƬ�����ļ�t10k-images.idx3-ubyte');
TrainFile = fullfile(PathName,FileName);
fid = fopen(TrainFile,'r'); %fopen����������ĵĺ����������ļ�����r���������
a = fread(fid,16,'uint8'); %������Ҫ˵�����ǣ�����ǰʮ���ֽ���˵����Ϣ������������������������ᵽ���Ǹ���ҳ���Կ���������һλ����ʲô���塣����a������ȡ����Щ��Ϣ������¼�������������Ľ�������ȶ�����
                            %fread������һ������ʾ�ļ��������ڶ���������ʾa��ά�ȣ�������������ʾa��ÿ��Ԫ�صľ��ȣ���Ϊ8λ���˴����ǵ�������ȫ���޷����ַ������Ե���������ѡȡuint8��
MagicNum = ((a(1)*256+a(2))*256+a(3))*256+a(4);%idx�ļ���ʽ˵�������ֽڣ���32λ���ͱ�������ǰ�����ֽ�����0�������ֽڱ�ʾ�������ͣ������ֽڱ�ʾά�ȣ�1��ʾ������2��ʾ���󡣰���������ֽڱ�ʾ��ʽ
ImageNum = ((a(5)*256+a(6))*256+a(7))*256+a(8);%ͼ�����������ֽڣ���32λ���ͱ���������ʾ�ļ�����������ͼƬ��ѵ�����Ļ���ֵΪ60000�����Լ��Ļ���ֵΪ10000.
ImageRow = ((a(9)*256+a(10))*256+a(11))*256+a(12);%���������ֽڣ���32λ���ͱ���������ֵΪ28
ImageCol = ((a(13)*256+a(14))*256+a(15))*256+a(16);%���������ֽڣ���32λ���ͱ���������ֵΪ28
%�������ᵽ����ҳ����������ľ�
%��ȡ����labels�ļ�
[FileName1,PathName1] = uigetfile('*.*','ѡ�����ͼƬ�����ļ�t10k-label.idx1-ubyte');
TrainFile1 = fullfile(PathName1,FileName1);
fid1 = fopen(TrainFile1,'r'); %fopen����������ĵĺ����������ļ�����r���������
a1 = fread(fid1,8,'uint8'); %������Ҫ˵�����ǣ�����ǰʮ���ֽ���˵����Ϣ������������������������ᵽ���Ǹ���ҳ���Կ���������һλ����ʲô���塣����a������ȡ����Щ��Ϣ������¼�������������Ľ�������ȶ�����
                            %fread������һ������ʾ�ļ��������ڶ���������ʾa��ά�ȣ�������������ʾa��ÿ��Ԫ�صľ��ȣ���Ϊ8λ���˴����ǵ�������ȫ���޷����ַ������Ե���������ѡȡuint8��
MagicNum1 = ((a1(1)*256+a1(2))*256+a1(3))*256+a1(4);%idx�ļ���ʽ˵�������ֽڣ���32λ���ͱ�������ǰ�����ֽ�����0�������ֽڱ�ʾ�������ͣ������ֽڱ�ʾά�ȣ�1��ʾ������2��ʾ���󡣰���������ֽڱ�ʾ��ʽ
ImageNum1 = ((a1(5)*256+a1(6))*256+a1(7))*256+a1(8);%ͼ�����������ֽڣ���32λ���ͱ���������ʾ�ļ�����������ͼƬ��ѵ�����Ļ���ֵΪ60000�����Լ��Ļ���ֵΪ10000.

if ((MagicNum~=2051)||(ImageNum~=10000))
    error('���� MNIST t10k-images.idx3-ubyte �ļ���');
    fclose(fid);    
    return;    
end %����˵����Ϣ���ж�ѡȡ�ļ��Ƿ���ȷ���ų�ѡ�������ļ���
if ((MagicNum1~=2049)||(ImageNum1~=10000))
    error('���� MNIST t10k-label.idx1-ubyte �ļ���');
    fclose(fid1);    
    return;    
end %����˵����Ϣ���ж�ѡȡ�ļ��Ƿ���ȷ���ų�ѡ�������ļ���
savedirectory = uigetdir('','ѡ�����ͼƬ·����');
h_w = waitbar(0,'���Ժ򣬴�����>>');
for i=1:ImageNum
    b = fread(fid,ImageRow*ImageCol,'uint8');   %fread����Ҳ�Ǻ��ĵĺ���֮һ��b��¼����һ��ͼ�����ݴ���ע�����ﻹ�Ǹ������ǿ������κζ��ߵġ�
                                                %ֱ�ӵ���������ָ��ֱ�Ӻ��ƣ�
    b1= fread(fid1,1,'uint8');
    c = reshape(b,[ImageRow ImageCol]); %�������ˣ�reshape���¹��ɾ������ڰѴ�ת�������ˡ�������֪ͼƬ���Ǿ�������reshape�����ĻҶȾ�����Ǹ���д���ֵľ����ˡ�
    d = c'; %ת��һ�£���Ϊc�������Ǻ��ŵġ�����
    e = 255-d; %���ݻҶ����ۣ�0�Ǻ�ɫ��255�ǰ�ɫ��Ϊ��Ū�ɰ׵׺��־ͼ�����e
    e = uint8(e);
    switch b1
        case 0
            savepath = fullfile(savedirectory,'num0',['TestImage_' num2str(i,'%d') '.bmp']);
            imwrite(e,savepath,'bmp'); %�����imwriteд��ͼƬ
        case 1
            savepath = fullfile(savedirectory,'num1',['TestImage_' num2str(i,'%d') '.bmp']);
            imwrite(e,savepath,'bmp'); %�����imwriteд��ͼƬ
        case 2
            savepath = fullfile(savedirectory,'num2',['TestImage_' num2str(i,'%d') '.bmp']);
            imwrite(e,savepath,'bmp'); %�����imwriteд��ͼƬ
        case 3
            savepath = fullfile(savedirectory,'num3',['TestImage_' num2str(i,'%d') '.bmp']);
            imwrite(e,savepath,'bmp'); %�����imwriteд��ͼƬ
        case 4
            savepath = fullfile(savedirectory,'num4',['TestImage_' num2str(i,'%d') '.bmp']);
            imwrite(e,savepath,'bmp'); %�����imwriteд��ͼƬ
        case 5
            savepath = fullfile(savedirectory,'num5',['TestImage_' num2str(i,'%d') '.bmp']);
            imwrite(e,savepath,'bmp'); %�����imwriteд��ͼƬ
        case 6
            savepath = fullfile(savedirectory,'num6',['TestImage_' num2str(i,'%d') '.bmp']);
            imwrite(e,savepath,'bmp'); %�����imwriteд��ͼƬ
        case 7
            savepath = fullfile(savedirectory,'num7',['TestImage_' num2str(i,'%d') '.bmp']);
            imwrite(e,savepath,'bmp'); %�����imwriteд��ͼƬ
        case 8
            savepath = fullfile(savedirectory,'num8',['TestImage_' num2str(i,'%d') '.bmp']);
            imwrite(e,savepath,'bmp'); %�����imwriteд��ͼƬ
        case 9
            savepath = fullfile(savedirectory,'num9',['TestImage_' num2str(i,'%d') '.bmp']);
            imwrite(e,savepath,'bmp'); %�����imwriteд��ͼƬ
    end
    waitbar(i/ImageNum);
end
fclose(fid);
fclose(fid1);
close(h_w);