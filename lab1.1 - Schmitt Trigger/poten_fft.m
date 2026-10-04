y = double(data_2_50.DATA);
t = data_2_50.TIME;

y_cut = double(y(2001:5001));
t_cut = double(t(2001:5001));

figure;
tiledlayout(2,1)

nexttile
plot(t_cut, y_cut);

xlabel('Time (s)');
ylabel('ADC Count');
title('Raw Potentiometer Signal');
grid on;

%sampling
fs = 1000;

%noise
y_noise = y_cut - mean(y_cut);

%fourier
Y = fft(y_cut);
f = (0:length(Y)-1)*fs/length(Y);
mag = abs(Y)/(length(y_cut)/2);

nexttile
plot(f, mag);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Fourier Transform of Potentiometer Signal');
grid on;