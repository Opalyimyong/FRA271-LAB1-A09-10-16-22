clc;
clear;
close all;

D = load('Relation2AB_90deg_cw-ccw 1.mat');

A = D.data.getElement('Gain 1:1').Values;
B = D.data.getElement('Gain 2:1').Values;
x1 = D.data.getElement('EncoderX1').Values;
x2 = D.data.getElement('EncoderX2').Values;
x4 = D.data.getElement('EncoderX4').Values;


idx = (4501 : 20320);

t = A.Time(idx);
t = t - t(1);

AData = A.Data(idx);
BData = B.Data(idx);
EncoderData = [x1.Data(idx), x2.Data(idx), x4.Data(idx)];


%% Plot

figure

%Encoder
subplot(2,1,1)

plot(t, EncoderData(:,1), 'LineWidth', 1.5)
hold on
plot(t, EncoderData(:,2), 'LineWidth', 1.5)
plot(t, EncoderData(:,3), 'LineWidth', 1.5)

title('Encoder Count', 'Fontsize',16)
xlabel('Time (s)', 'Fontsize',12)
ylabel('Encoder Count', 'Fontsize',12)
legend('X1','X2','X4')
grid on
set (gca, 'FontSize', 12)
set(gca, 'LineWidth', 1.5)
xlim([0 15.32])
ylim([0 2250])
yticks(0:750:2250)
yticks(sort(unique([yticks 497 994 1987])))


%A/B
subplot(2,1,2)

plot(t, AData, 'b', 'LineWidth', 1.5)
hold on
plot(t, BData, 'r', 'LineWidth', 1.5)

title('A-B Signal', 'Fontsize',16)
xlabel('Time (s)', 'Fontsize',12)
ylabel('Signal', 'Fontsize',12)
legend('A','B')
grid on
set (gca, 'FontSize', 12)
set(gca, 'LineWidth', 1.5)
xlim([0 15.32])
ylim([0 1.5])
