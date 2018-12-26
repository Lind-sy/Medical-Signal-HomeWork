%% Labwork 3.3 
sphereRadiuss = 100;
electrodes = 32;
sphereShape = 'h';
%Simulate EEG signals using sources beneath each electrode with normal 
%orientation to the surface.
elect = elposition(sphereRadiuss,electrodes,sphereShape);%electrodes
scatter3(elect(:,1),elect(:,2),elect(:,3));
conductivity = 1;
source = elect*0.6;
orr = elect-source;
%Shift each source position by 0.5 cm in random direction, but keep the orientations.
source2(:,1) = source(:,1)+rand(1);
source2(:,2) = source(:,2)+rand(1);
source2(:,3) = source(:,3)+rand(1);
hold
scatter3(source(:,1),source(:,2),source(:,3),'filled');
quiver3(source(:,1),source(:,2),source(:,3),orr(:,1),orr(:,2),orr(:,3))
scatter3(source2(:,1),source2(:,2),source2(:,3),'o');
orr2 = elect-source2;% calculate new orientation
quiver3(source2(:,1),source2(:,2),source2(:,3),orr(:,1),orr(:,2),orr(:,3))
%% General model
LF1 = ILF_33(elect,source2,orr);
imagesc(LF1)
%% Planar model
LF2 = ILF_planar(elect,source2);
imagesc(LF2)
%% Compute Goodness of Fit between original S and estimated S_hat
S = rand(32,100);
X = LF1*S;
S_hat = inv(LF2)*X;
MSE1 = immse(S,S_hat);
errors=(S-S_hat);
MSE2 =mean( mean(errors.^2));