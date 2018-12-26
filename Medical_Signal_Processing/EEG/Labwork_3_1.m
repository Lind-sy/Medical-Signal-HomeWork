%% Labwork 3.1 - Consider head modeled as a half sphere with 32 sensors on it
sphereRadiuss = 100;
electrodes = 32;
sphereShape = 'h';
elect = elposition(sphereRadiuss,electrodes,sphereShape);%generate electrodes
scatter3(elect(:,1),elect(:,2),elect(:,3));
conductivity = 1;
source = elect*0.6;%define source 
hold
scatter3(source(:,1),source(:,2),source(:,3),'filled');
%consider only infinite homogeneous medium leadfield
lf = inf_medium_leadfield(source,elect,conductivity);
orr = elect-source;%electrode orientation
for i = 1:size(orr,1)
    orr(i,:) =orr(i,:)/norm(orr(i,:));%normalized orientation
end
quiver3(source(:,1),source(:,2),source(:,3),orr(:,1),orr(:,2),orr(:,3))
%% %lf trough out 3 columns
counter =1;
A = []; % model
for i = 1:size(source,1)
    A(:,i) = lf(:,counter:counter+2) *orr(i,:)';
    counter = counter+3;
end
imagesc(A)
%% Simulate 1 second signal using Fs = 256Hz
for q = 1:25%for animation
    Fs = 256;%Sampling fequency
    ti = 0 ; tf = 1 ;%time frame
    t  = ti : 1/Fs : tf-1/Fs ;
    step = length(t)/4;%chunk size
    count = 1;
    S = zeros(32,256);
    s1 = 1; s2 = 4; s3 = 7; s4 = 9;  s5 = 11;
    k = 7;
% Each 250ms 5 sources are active, others are with 0 amplitudes
    for i = 1 : 4
        %random source values
        S(s1,count:(count+step-1)) = rand(1,64);
        S(s2,count:(count+step-1)) = rand(1,64);
        S(s3,count:(count+step-1)) = rand(1,64);
        S(s4,count:(count+step-1)) = rand(1,64);
        S(s5,count:(count+step-1)) = rand(1,64);
        count = count + step;
        s1 = s1+k;
        s2 = s2+k;
        s3 = s3+k;
        s4 = s4+k;
        s5 = s5+k;
    end
    V = A*S;
    %affichage(V,256)
    hold on
    scalpMap(V(:,1),elect)%visualize activity
    pause(2)
 end