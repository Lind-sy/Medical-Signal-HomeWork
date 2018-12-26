N = 100;
x= -N:N;
y=-N:N;
z = Phantom(x,y);%Create phantom image
imshow(z);
[h,n] = CBPFilter(N);%returns h - filter coeficients
theta = 180;
%% Create projections using angles
j_sum = [];
for i = 1:theta
    J = imrotate(z,i,'bicubic','crop');%bicubic interpolation and crop 
    j_sum(i,:) = sum(J);%sum the rotated image to get a vector
end
imshow(j_sum,[]);
%% back projection - restore image withour fltering 
J_im = zeros(size(z,1),size(z,2));
for i = 1:size(j_sum,1)
    remap_im = repmat(j_sum(i,:),size(z,1),1);%create image using the vector
    remap_im = imrotate(remap_im,i,'bicubic','crop');%rotate image by 1 degree 
    J_im = J_im+remap_im; %sum together two pictures
end
imshow(J_im,[]);
%% restore image using filtering
J_im = zeros(401,401);
for i = 1:size(j_sum,1)
    Con_im = conv(j_sum(i,:),h); %perform convolution between vector and filter coeficients 
    remap_im = repmat(Con_im,401,1);%create image using gained convolution vector
    remap_im = imrotate(remap_im,i,'bicubic','crop');%rotate the created image
    J_im = J_im+remap_im;%sum created image to restored image
end
imshow(J_im,[]);