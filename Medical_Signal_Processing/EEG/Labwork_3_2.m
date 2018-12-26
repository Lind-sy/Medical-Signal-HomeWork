%% Labwork 3.2
sphereRadiuss = 100;
electrodes = 32;
sphereShape = 'h';
elect = elposition(sphereRadiuss,electrodes,sphereShape);%electrodes 
scatter3(elect(:,1),elect(:,2),elect(:,3));
conductivity = 1;
source = elect*0.6;%create sources
hold
scatter3(source(:,1),source(:,2),source(:,3),'filled');
orr = elect-source;% calculate orientation
for i = 1:size(orr,1)
    orr(i,:) =orr(i,:)/norm(orr(i,:));% normalize orientation vector
end
quiver3(source(:,1),source(:,2),source(:,3),orr(:,1),orr(:,2),orr(:,3))
%% General model
LF1 = ILF(elect,source);
imagesc(LF1)
%% Planar model
LF2 = ILF_planar(elect,source);
imagesc(LF2)
%% Compute Goodness of Fit between original S and estimated S_hat
S = rand(32,100);
X = LF1*S;
S_hat = inv(LF2)*X;
MSE1 = immse(S,S_hat);