clc;
clear;
close all;

%% =========================
% Data 1
% =========================
D1 = load('Relation2AB_90deg_cw-ccw 1.mat');

A1 = D1.data.getElement('Gain 1:1').Values;
B1 = D1.data.getElement('Gain 2:1').Values;
x11 = D1.data.getElement('EncoderX1').Values;
x12 = D1.data.getElement('EncoderX2').Values;
x14 = D1.data.getElement('EncoderX4').Values;

idx1 = 5001:20320;

t1 = A1.Time(idx1);
t1 = t1 - t1(1);

AData1 = A1.Data(idx1);
BData1 = B1.Data(idx1);

EncoderData1 = [x11.Data(idx1), ...
                x12.Data(idx1), ...
                x14.Data(idx1)];


%% =========================
% Data 2
% =========================
D2 = load('Relation2AB_90deg_cw-ccw 2.mat');

A2 = D2.data.getElement('Gain 1:1').Values;
B2 = D2.data.getElement('Gain 2:1').Values;
x21 = D2.data.getElement('EncoderX1').Values;
x22 = D2.data.getElement('EncoderX2').Values;
x24 = D2.data.getElement('EncoderX4').Values;

idx2 = 7901:32330;

t2 = A2.Time(idx2);
t2 = t2 - t2(1);

AData2 = A2.Data(idx2);
BData2 = B2.Data(idx2);

EncoderData2 = [x21.Data(idx2), ...
                x22.Data(idx2), ...
                x24.Data(idx2)];


%% =========================
% Data 3
% =========================
D3 = load('Relation2AB_90deg_cw-ccw 3.mat');

A3 = D3.data.getElement('Gain 1:1').Values;
B3 = D3.data.getElement('Gain 2:1').Values;
x31 = D3.data.getElement('EncoderX1').Values;
x32 = D3.data.getElement('EncoderX2').Values;
x34 = D3.data.getElement('EncoderX4').Values;

idx3 = 5501:44189;

t3 = A3.Time(idx3);
t3 = t3 - t3(1);

AData3 = A3.Data(idx3);
BData3 = B3.Data(idx3);

EncoderData3 = [x31.Data(idx3), ...
                x32.Data(idx3), ...
                x34.Data(idx3)];


%% =========================
% Plot
% =========================
figure


%% Data 1 - Encoder
subplot(3,2,1)

plot(t1, EncoderData1(:,1), 'LineWidth', 1.5)
hold on
plot(t1, EncoderData1(:,2), 'LineWidth', 1.5)
plot(t1, EncoderData1(:,3), 'LineWidth', 1.5)

title('Data 1 - Encoder Count', 'FontSize', 16)
xlabel('Time (s)', 'FontSize', 12)
ylabel('Encoder Count', 'FontSize', 12)
legend('X1','X2','X4')
grid on

set(gca, 'FontSize', 12)
set(gca, 'LineWidth', 1.5)

xlim([0 15.32])
xticks(0:2:15)

ylim([0 2250])
yticks(0:750:2250)
yticks(sort(unique([yticks 497 994 1987])))


%% Data 1 - A/B
subplot(3,2,2)

plot(t1, AData1, 'b', 'LineWidth', 1.5)
hold on
plot(t1, BData1, 'r', 'LineWidth', 1.5)

title('Data 1 - A-B Signal', 'FontSize', 16)
xlabel('Time (s)', 'FontSize', 12)
ylabel('Signal', 'FontSize', 12)
legend('A','B')
grid on

set(gca, 'FontSize', 12)
set(gca, 'LineWidth', 1.5)

xticks(0:2:15)
xlim([0 15.32])
ylim([0 1.5])


%% Data 2 - Encoder
subplot(3,2,3)

plot(t2, EncoderData2(:,1), 'LineWidth', 1.5)
hold on
plot(t2, EncoderData2(:,2), 'LineWidth', 1.5)
plot(t2, EncoderData2(:,3), 'LineWidth', 1.5)

title('Data 2 - Encoder Count', 'FontSize', 16)
xlabel('Time (s)', 'FontSize', 12)
ylabel('Encoder Count', 'FontSize', 12)
legend('X1','X2','X4')
grid on

set(gca, 'FontSize', 12)
set(gca, 'LineWidth', 1.5)

xticks(0:2:24)
ylim([0 2250])

yticks(0:750:2250)
yticks(sort(unique([yticks 497 994 1987])))


%% Data 2 - A/B
subplot(3,2,4)

plot(t2, AData2, 'b', 'LineWidth', 1.5)
hold on
plot(t2, BData2, 'r', 'LineWidth', 1.5)

title('Data 2 - A-B Signal', 'FontSize', 16)
xlabel('Time (s)', 'FontSize', 12)
ylabel('Signal', 'FontSize', 12)
legend('A','B')
grid on

set(gca, 'FontSize', 12)
set(gca, 'LineWidth', 1.5)

xticks(0:2:24)
ylim([0 1.5])


%% Data 3 - Encoder
subplot(3,2,5)

plot(t3, EncoderData3(:,1), 'LineWidth', 1.5)
hold on
plot(t3, EncoderData3(:,2), 'LineWidth', 1.5)
plot(t3, EncoderData3(:,3), 'LineWidth', 1.5)

title('Data 3 - Encoder Count', 'FontSize', 16)
xlabel('Time (s)', 'FontSize', 12)
ylabel('Encoder Count', 'FontSize', 12)
legend('X1','X2','X4')
grid on

set(gca, 'FontSize', 12)
set(gca, 'LineWidth', 1.5)

xticks(0:2:40)
xlim([0 39])
ylim([0 2500])

yticks(0:800:2500)
yticks(sort(unique([yticks 531 1060 2121])))


%% Data 3 - A/B
subplot(3,2,6)

plot(t3, AData3, 'b', 'LineWidth', 1.5)
hold on
plot(t3, BData3, 'r', 'LineWidth', 1.5)

title('Data 3 - A-B Signal', 'FontSize', 16)
xlabel('Time (s)', 'FontSize', 12)
ylabel('Signal', 'FontSize', 12)
legend('A','B')
grid on

set(gca, 'FontSize', 12)
set(gca, 'LineWidth', 1.5)

xticks(0:2:40)
xlim([0 39])
ylim([0 1.5])

