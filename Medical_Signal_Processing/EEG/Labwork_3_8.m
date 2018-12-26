clear all;
close all;
%[V,m,h,n,t]=hhrun( 10.5, 200, -70, 0.4, 0.2, 0.5, 0.1);
[V,m,h,n,t]=hhrun( 10.5, 200, -70, 0.4, 0.2, 0.5, 0.1);
plot(V)

  dt = 0.001;               % time step for forward euler method
  loop  = ceil(200/dt);   % no. of iterations of euler
  
  gNa = 120;  
  eNa=115;
  gK = 36;  
  eK=-12;
  gL=0.3;  
  eL=10.6;

  % Initializing variable vectors
  
  t = (1:loop)*dt;
  V3 = zeros(loop,1);
  m2 = zeros(loop,1);
  h2 = zeros(loop,1);
  n2 = zeros(loop,1);
  
  % Set initial values for the variables
  
  V3(1)=v;
  m2(1)=mi;
  h2(1)=hi;
  n2(1)=ni;
  
  for i=1:loop-1
      V3(i+1) = V3(i) + dt*(gNa*m2(i)^3*h2(i)*(eNa-(V3(i)+65)) + gK*n2(i)^4*(eK-(V3(i)+65)) + gL*(eL-(V3(i)+65)) + I);
      m2(i+1) = m2(i) + dt*(alphaM(V3(i))*(1-m2(i)) - betaM(V3(i))*m2(i));
      h2(i+1) = h2(i) + dt*(alphaH(V3(i))*(1-h2(i)) - betaH(V3(i))*h2(i));
      n2(i+1) = n2(i) + dt*(alphaN(V3(i))*(1-n2(i)) - betaN(V3(i))*n2(i));
  end