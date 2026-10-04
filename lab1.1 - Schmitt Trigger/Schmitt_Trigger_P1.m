clc;
clear;
close all;

D = load('poten5 schmitt trigger.mat');

I = D.data.getElement(1).Values;
O = D.data.getElement(2).Values;

idx = (1 : 23000);

t = I.Time(idx);
t = t - t(1);

Idata = I.Data(idx);
Odata = O.Data(idx)/5;

%% Plot

figure

%Encoder
% subplot(2,1,1)
plot(t, Idata, 'LineWidth', 2)
hold on
plot(t, Odata, 'LineWidth', 2)
title('Potentiometer Vs Schmitt Trigger Signal', 'Fontsize',16)
xlabel('Time (s)', 'Fontsize',12)
ylabel('Signal (V)', 'Fontsize',12)
legend('Poten','Schmitt')
grid on
grid minor
set (gca, 'FontSize', 12)
set(gca, 'LineWidth', 1.5)
% xlim([0 25])