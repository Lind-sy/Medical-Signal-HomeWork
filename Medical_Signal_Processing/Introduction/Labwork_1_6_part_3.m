%% Lab work 1.6.
Fs = 1000;
f1 = 100;f2 = 200; f3 = 300;
A1 = 1; A2 = 1; A3 = 1;
phi = 0;
t = 0 : 1/Fs : 1-1/Fs;
s1 = A1 * sin( 2*pi*f1*t + phi);
s2 = A2 * sin( 2*pi*f2*t + phi);
s3 = A3 * sin( 2*pi*f3*t + phi);
s4 = s1+s2+s3;
plot(t, s4);
%% Filtering of frequencies
f_min = 280/(0.5*Fs);
f_max = 310/(0.5*Fs);
%f_min = 80//(0.5*Fs);
%f_max = 110/(0.5*Fs);
%f_min = 180//(0.5*Fs);
%f_max = 210/(0.5*Fs);
b = fir1(240,[f_min f_max]);%define filter coeficients
s_c_fil1 = filtfilt(b,1,s4);%filter
hold on
plot(t, s_c_fil1);
freq  = ( ( 0 : length(t)-1 ) /length(t) -0.5 ) * Fs;%frequencys in signal
Xf_s12_filter = abs(fftshift(fft( s_c_fil1 )));% fast fourier transformation 
stem(freq,Xf_s12_filter/length(t)) ;
%% convolution performance
s5 = conv(b,s4);%b filter coeficients, s4 - original signal
Fs2 = 1240;
hold on
t2 = 0 : 1/Fs2 : 1-1/Fs2;
plot(t2,s5);