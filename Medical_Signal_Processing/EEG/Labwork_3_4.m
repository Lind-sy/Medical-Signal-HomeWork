%% Labwork 3.4 
sphereRadiuss = 100;
electrodes = 32;
sphereShape = 'h';
elect = elposition(sphereRadiuss,electrodes,sphereShape);%electrode
scatter3(elect(:,1),elect(:,2),elect(:,3));
conductivity = 1;
source = elect*0.6;% calculate source 
orr = elect-source;%calculate orientation
n=1;
for i = 1:100
    hold on
    orr2 = (rand(32,3)*2)-1;
    scatter3(source2(:,1),source2(:,2),source2(:,3),'go');
    quiver3(source2(:,1),source2(:,2),source2(:,3),orr2(:,1),orr2(:,2),orr2(:,3),'g')
    % General model
    LF1 = ILF_34(elect,source,orr2);
    % Planar model
    LF2 = ILF_planar(elect,source); 
 % Compute Goodness of Fit between original S and estimated S_hat   
    S = rand(32,100);
    X = LF1*S;
    S_hat = inv(LF2)*X;
    MSE1 = immse(S,S_hat);
    errors = (S-S_hat);
    MSE2(i) = mean( mean(errors.^2)); 
end
plot(MSE2)
mean_total_error = mean(MSE2);