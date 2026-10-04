clc;
clear;
close all;

%% File
file1 = 'RelationAB_180deg_cw-ccw_fast 1.mat';
file2 = 'RelationAB_180deg_cw-ccw_fast 2.mat';
file3 = 'RelationAB_180deg_cw-ccw_fast 3.mat';

% ช่วง index
% idx1 = [4501:5500, 7001:10500];
% idx2 = 2801:8200;
idx3 = 6801:12000;


%% Data

%Data 1
D1 = load(file1);

A1 = D1.data.getElement('Gain 1:1').Values;
B1 = D1.data.getElement('Gain 2:1').Values;
x11 = D1.data.getElement('EncoderX1').Values;
x12 = D1.data.getElement('EncoderX2').Values;
x14 = D1.data.getElement('EncoderX4').Values;

idx1a = 4501:5000;
idx1b = 9501:10600;
Ts = A1.Time(2) - A1.Time(1);

t1a = A1.Time(idx1a);
t1a = t1a - t1a(1);
t1b = A1.Time(idx1b);
t1b = t1b - t1b(1) + t1a(end) + Ts;

t1 = [t1a; t1b];

AData1 = [A1.Data(idx1a); A1.Data(idx1b)];

BData1 = [B1.Data(idx1a); B1.Data(idx1b)];

EncoderData1 = [ ...
    x11.Data(idx1a), x12.Data(idx1a), x14.Data(idx1a);
    x11.Data(idx1b), x12.Data(idx1b), x14.Data(idx1b) ...
];


% Data 2
D2 = load(file2);

A2 = D2.data.getElement('Gain 1:1').Values;
B2 = D2.data.getElement('Gain 2:1').Values;
x21 = D2.data.getElement('EncoderX1').Values;
x22 = D2.data.getElement('EncoderX2').Values;
x24 = D2.data.getElement('EncoderX4').Values;

idx2a = 2801:4000;
idx2b = 6501:8500;

Ts2 = A2.Time(2) - A2.Time(1);
t2a = A2.Time(idx2a);
t2a = t2a - t2a(1);
t2b = A2.Time(idx2b);
t2b = t2b - t2b(1) + t2a(end) + Ts2;

t2 = [t2a; t2b];

AData2 = [A2.Data(idx2a); A2.Data(idx2b)];

BData2 = [B2.Data(idx2a); B2.Data(idx2b)];

EncoderData2 = [ ...
    x21.Data(idx2a), x22.Data(idx2a), x24.Data(idx2a);
    x21.Data(idx2b), x22.Data(idx2b), x24.Data(idx2b) ...
];


% Data 3
D3 = load(file3);

A3 = D3.data.getElement('Gain 1:1').Values;
B3 = D3.data.getElement('Gain 2:1').Values;
x31 = D3.data.getElement('EncoderX1').Values;
x32 = D3.data.getElement('EncoderX2').Values;
x34 = D3.data.getElement('EncoderX4').Values;

t3 = A3.Time(idx3);
t3 = t3 - t3(1);

AData3 = A3.Data(idx3);
BData3 = B3.Data(idx3);

EncoderData3 = [x31.Data(idx3), ...
                x32.Data(idx3), ...
                x34.Data(idx3)];


%% Plot

figure


% Data 1 Encoder
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

% xlim([0 10])
yticks(0:30:50)
yticks(sort(unique([yticks 12 24 48])))


% Data 1 A/B
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

% xlim([0 4])
ylim([0 1.5])


% Data 2 Encode
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

xlim([0 2.8])
yticks(0:30:50)
yticks(sort(unique([yticks 12 24 48])))


% Data 2 A/B
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

xlim([0 2.8])
ylim([0 1.5])


% Data 3 Encoder
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

xlim([0 3.6])
yticks(0:30:50)
yticks(sort(unique([yticks 12 24 48])))


% Data 3 A/B
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

xlim([0 3.6])
ylim([0 1.5])

