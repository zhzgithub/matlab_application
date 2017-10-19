clc,clear  
npersons=40;%ѡȡ40���˵���  
global imgrow;  
global imgcol;  
global edit2  
imgrow=112;  
imgcol=92;  
  
set(edit2,'string','��ȡѵ������......')%��ʾ�ھ��Ϊedit2���ı�����  
drawnow     %���´��ڵ����ݣ���Ȼ�������ʱ�Ż���ʾ������ֻ�ܿ������һ��  
f_matrix=ReadFace(npersons,0);%��ȡѵ������  
nfaces=size(f_matrix,1);%��������������  
  
set(edit2,'string','ѵ������PCA������ȡ......')  
drawnow  
mA=mean(f_matrix);  
k=20;%��ά��20ά  
[pcaface,V]=fastPCA(f_matrix,k,mA);%���ɷַ�����������ȡ  
  
set(edit2,'string','ѵ�����ݹ淶��......')  
drawnow  
lowvec=min(pcaface);  
upvec=max(pcaface);  
scaledface = scaling( pcaface,lowvec,upvec);  
  
set(edit2,'string','SVM����ѵ��......')  
drawnow  
gamma=0.0078;  
c=128;  
multiSVMstruct=multiSVMtrain( scaledface,npersons,gamma,c);  
save('recognize.mat','multiSVMstruct','npersons','k','mA','V','lowvec','upvec');  
  
set(edit2,'string','��ȡ��������......')  
drawnow  
[testface,realclass]=ReadFace(npersons,1);  
  
set(edit2,'string','��������������ά......')  
drawnow  
m=size(testface,1);  
for i=1:m  
    testface(i,:)=testface(i,:)-mA;  
end  
pcatestface=testface*V;  
  
set(edit2,'string','�������ݹ淶��......')  
drawnow  
scaledtestface = scaling( pcatestface,lowvec,upvec);  
  
set(edit2,'string','SVM��������......')  
drawnow  
class= multiSVM(scaledtestface,multiSVMstruct,npersons);  
set(edit2,'string','������ɣ�')  
accuracy=sum(class==realclass)/length(class);  
msgbox(['ʶ��׼ȷ�ʣ�',num2str(accuracy*100),'%��'])