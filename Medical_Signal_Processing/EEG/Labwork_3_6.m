%% - Labwork 3.6
sphereRadiuss = 100;
electrodes = 72;
sphereShape = 'h';
elect = elposition(sphereRadiuss,electrodes,sphereShape);%electrode
cortex = elposition(75,electrodes,sphereShape);%cortex
dip = elposition(65,electrodes,sphereShape);%dipoles
n=1;
%randomly shift
dip(:,1) = dip(:,1)+rand(n);
dip(:,2) = dip(:,2)+rand(n);
dip(:,3) = dip(:,3)+rand(n);
orr = (rand(72,3)*2)-1;% calculate orientation
%% General model - Simulate potentials on both - head and cortical surface
Ah = ILF_34(elect,dip,orr);
Ac = ILF_34(cortex,dip,orr);

imagesc(Ah);
imagesc(Ac);
S = rand(72,100);
Xh = inv(Ah)*S;
Xc = inv(Ac)*S;
%% Laplasian surface operator
Distance_mat = squareform(pdist(elect));
imagesc(Distance_mat);
estimatedXc=Xh;
%% Apply Hjorth Laplacian montage
for i = 1:size(Distance_mat,1)
    [S_d,ind] = sort(Distance_mat(i,:));% sort to find the smallest distances
    closestNeighboors=ind(S_d<40);%find neighbors whos distance is less than 40 
    closestNeighboors(closestNeighboors==i) = []; %set current as empty
    if (length(closestNeighboors)>4)%check how many neighbors are choosen
        closestNeighboors=closestNeighboors(1:4);%take only five neighbors
    end
    XhMean=mean(Xh(closestNeighboors,:));% calculate neighbors total mean value
    estimatedXc(i,:)=Xh(i,:)-XhMean;%remove mean value from generated Xh
end
%% Compare estimated potentials with simulated cortical potentials.
corrcoef(Xh(:,1),Xc(:,1));
errors=(Xc-estimatedXc);
MSE=mean(mean(errors.^2));
RMSE=sqrt(MSE);
%% Create image representation
close all;
j=5;
figure, scalpMap(Xh(:,j),cortex)
figure, scalpMap(estimatedXc(:,j),cortex)