%% Labwork 3.7
close all
clear a
radiuss=100;
electrodeCount=72;
elect = elposition(radiuss,electrodeCount,'h');%electrodes
source = elposition(65,electrodeCount,'h');%source 

hold on
scatter3(elect(:,1),elect(:,2),elect(:,3),'b');
scatter3(source(:,1),source(:,2),source(:,3),'*r');
orr=elect-source;%calculate orientation 
quiver3(source(:,1),source(:,2),source(:,3),orr(:,1),orr(:,2),orr(:,3),'r');
A=ILF_34(elect,source,orr);

% Simulate 3 active sources
S=zeros(72,100);
S(4,:)=rand(1,100);
S(24,:)=rand(1,100);
S(34,:)=rand(1,100);
X=A*S;

for ii = 1:size(A,1)
   A(:,ii) = A(:,ii)./norm(A(:,ii));%normalization
end
%% Lectures code example
estimateActiveSourceIndexes=zeros(size(S,1),3);
for i=1:size(S,2)
      estimateActiveSourceIndexes(i,:)= mp_lessson_version(X(:,i)', A, 3 )';
end
%% Code from https://github.com/seunghwanyoo/omp/blob/master/mp.m
estimateActiveSources=zeros(size(S,1),1);
for i=1:size(S,2)
    estimateActiveSources(:,i)=mp(A,X(:,i),3);
end