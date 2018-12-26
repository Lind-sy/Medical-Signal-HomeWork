ecg = load('ecgdemodata1.mat');%grain ecg data
x = ecg.ecg;
Fs = ecg.samplingrate;% Sampling rate
figure(1)
plot(x);
%%
N = length(x);
% Shift zero-frequency component to center of spectrum
X = fftshift(fft(x));       %fast fourier transformation 
dF = Fs/N;                      % hertz
f = -Fs/2:dF:Fs/2-dF;           % hertz
figure;
plot(f,abs(X)/N);
xlabel('Frequency (in hertz)');
title('Magnitude Response');
%%
filterDesigner
%%
x_filt = filter(HighPassFilter(),x);%perform filtering 
plot(x_filt)
%%
N = length(x_filt);%filtered signal lenght
X = fftshift(fft(x_filt));% Shift zero-frequency component to center of spectrum
dF = Fs/N;                      % hertz
f = -Fs/2:dF:Fs/2-dF;           % hertz
figure;
plot(f,abs(X)/N);
xlabel('Frequency (in hertz)');
title('Magnitude Response');
%%
%signal=signalTmp>100;
[pks,locs] = findpeaks(x_filt,Fs,'MinPeakHeight',300);%Find local maxima
findpeaks(x_filt,Fs,'MinPeakHeight',300)
for i = 1:length(locs)-1
    dist(i) = locs(i+1)-locs(i);%distance between two maximum points
end
bps = mean(dist).*60;%average heart beat 