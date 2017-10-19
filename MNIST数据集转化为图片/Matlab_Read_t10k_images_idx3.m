% Matlab_Read_t10k-images_idx3.m
% 用于读取MNIST数据集中t10k-images.idx3-ubyte文件并将其转换成bmp格式图片输出。
% 用法：运行程序，会弹出选择测试图片数据文件t10k-labels.idx1-ubyte路径的对话框和
% 选择保存测试图片路径的对话框，选择路径后程序自动运行完毕，期间进度条会显示处理进度。
% 图片以TestImage_00001.bmp～TestImage_10000.bmp的格式保存在指定路径，10000个文件占用空间39M。。
% 整个程序运行过程需几分钟时间。
% Written By DXY@HUST IPRAI
% 2009-2-22
clear all;
clc;
%读取测试图片数据文件
[FileName,PathName] = uigetfile('*.*','选择测试图片数据文件t10k-images.idx3-ubyte');
TrainFile = fullfile(PathName,FileName);
fid = fopen(TrainFile,'r'); %fopen（）是最核心的函数，导入文件，‘r’代表读入
a = fread(fid,16,'uint8'); %这里需要说明的是，包的前十六字节是说明信息，后面的是数据区，从上面提到的那个网页可以看到具体那一位代表什么意义。所以a变量提取出这些信息，并记录下来，方便后面的建立矩阵等动作。
                            %fread函数第一参数表示文件变量，第二个参数表示a的维度，第三个参数表示a中每个元素的精度，此为8位。此处考虑到数据区全是无符号字符型所以第三个参数选取uint8，
MagicNum = ((a(1)*256+a(2))*256+a(3))*256+a(4);%idx文件格式说明（四字节，用32位整型表述）：前两个字节总是0；第三字节表示数据类型；第四字节表示维度，1表示向量，2表示矩阵。把其组成四字节表示形式
ImageNum = ((a(5)*256+a(6))*256+a(7))*256+a(8);%图像数量（四字节，用32位整型表述）：表示文件包含多少张图片，训练集的话此值为60000，测试集的话此值为10000.
ImageRow = ((a(9)*256+a(10))*256+a(11))*256+a(12);%行数（四字节，用32位整型表述）：此值为28
ImageCol = ((a(13)*256+a(14))*256+a(15))*256+a(16);%列数（四字节，用32位整型表述）：此值为28
%从上面提到的网页可以理解这四句
%读取测试labels文件
[FileName1,PathName1] = uigetfile('*.*','选择测试图片数据文件t10k-label.idx1-ubyte');
TrainFile1 = fullfile(PathName1,FileName1);
fid1 = fopen(TrainFile1,'r'); %fopen（）是最核心的函数，导入文件，‘r’代表读入
a1 = fread(fid1,8,'uint8'); %这里需要说明的是，包的前十六字节是说明信息，后面的是数据区，从上面提到的那个网页可以看到具体那一位代表什么意义。所以a变量提取出这些信息，并记录下来，方便后面的建立矩阵等动作。
                            %fread函数第一参数表示文件变量，第二个参数表示a的维度，第三个参数表示a中每个元素的精度，此为8位。此处考虑到数据区全是无符号字符型所以第三个参数选取uint8，
MagicNum1 = ((a1(1)*256+a1(2))*256+a1(3))*256+a1(4);%idx文件格式说明（四字节，用32位整型表述）：前两个字节总是0；第三字节表示数据类型；第四字节表示维度，1表示向量，2表示矩阵。把其组成四字节表示形式
ImageNum1 = ((a1(5)*256+a1(6))*256+a1(7))*256+a1(8);%图像数量（四字节，用32位整型表述）：表示文件包含多少张图片，训练集的话此值为60000，测试集的话此值为10000.

if ((MagicNum~=2051)||(ImageNum~=10000))
    error('不是 MNIST t10k-images.idx3-ubyte 文件！');
    fclose(fid);    
    return;    
end %根据说明信息，判断选取文件是否正确，排除选择错误的文件。
if ((MagicNum1~=2049)||(ImageNum1~=10000))
    error('不是 MNIST t10k-label.idx1-ubyte 文件！');
    fclose(fid1);    
    return;    
end %根据说明信息，判断选取文件是否正确，排除选择错误的文件。
savedirectory = uigetdir('','选择测试图片路径：');
h_w = waitbar(0,'请稍候，处理中>>');
for i=1:ImageNum
    b = fread(fid,ImageRow*ImageCol,'uint8');   %fread（）也是核心的函数之一，b记录下了一副图的数据串。注意这里还是个串，是看不出任何端倪的。
                                                %直接到数据区？指针直接后移？
    b1= fread(fid1,1,'uint8');
    c = reshape(b,[ImageRow ImageCol]); %亮点来了，reshape重新构成矩阵，终于把串转化过来了。众所周知图片就是矩阵，这里reshape出来的灰度矩阵就是该手写数字的矩阵了。
    d = c'; %转置一下，因为c的数字是横着的。。。
    e = 255-d; %根据灰度理论，0是黑色，255是白色，为了弄成白底黑字就加入了e
    e = uint8(e);
    switch b1
        case 0
            savepath = fullfile(savedirectory,'num0',['TestImage_' num2str(i,'%d') '.bmp']);
            imwrite(e,savepath,'bmp'); %最后用imwrite写出图片
        case 1
            savepath = fullfile(savedirectory,'num1',['TestImage_' num2str(i,'%d') '.bmp']);
            imwrite(e,savepath,'bmp'); %最后用imwrite写出图片
        case 2
            savepath = fullfile(savedirectory,'num2',['TestImage_' num2str(i,'%d') '.bmp']);
            imwrite(e,savepath,'bmp'); %最后用imwrite写出图片
        case 3
            savepath = fullfile(savedirectory,'num3',['TestImage_' num2str(i,'%d') '.bmp']);
            imwrite(e,savepath,'bmp'); %最后用imwrite写出图片
        case 4
            savepath = fullfile(savedirectory,'num4',['TestImage_' num2str(i,'%d') '.bmp']);
            imwrite(e,savepath,'bmp'); %最后用imwrite写出图片
        case 5
            savepath = fullfile(savedirectory,'num5',['TestImage_' num2str(i,'%d') '.bmp']);
            imwrite(e,savepath,'bmp'); %最后用imwrite写出图片
        case 6
            savepath = fullfile(savedirectory,'num6',['TestImage_' num2str(i,'%d') '.bmp']);
            imwrite(e,savepath,'bmp'); %最后用imwrite写出图片
        case 7
            savepath = fullfile(savedirectory,'num7',['TestImage_' num2str(i,'%d') '.bmp']);
            imwrite(e,savepath,'bmp'); %最后用imwrite写出图片
        case 8
            savepath = fullfile(savedirectory,'num8',['TestImage_' num2str(i,'%d') '.bmp']);
            imwrite(e,savepath,'bmp'); %最后用imwrite写出图片
        case 9
            savepath = fullfile(savedirectory,'num9',['TestImage_' num2str(i,'%d') '.bmp']);
            imwrite(e,savepath,'bmp'); %最后用imwrite写出图片
    end
    waitbar(i/ImageNum);
end
fclose(fid);
fclose(fid1);
close(h_w);