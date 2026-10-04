F1 = load('Find_PPR1.mat');
F2 = load('Find_PPR2.mat');
F3 = load('Find_PPR3.mat');

%% =========================
% File 1
% ==========================

F1x1 = F1.data.getElement('EncoderX1').Values;
F1x2 = F1.data.getElement('EncoderX2').Values;
F1x4 = F1.data.getElement('EncoderX4').Values;

t1x1 = F1x1.Time(501:8001);
v1x1 = F1x1.Data(501:8001);

t1x2 = F1x2.Time(501:8001);
v1x2 = F1x2.Data(501:8001);

t1x4 = F1x4.Time(501:8001);
v1x4 = F1x4.Data(501:8001);


%% =========================
% File 2
% ==========================

F2x1 = F2.data.getElement('EncoderX1').Values;
F2x2 = F2.data.getElement('EncoderX2').Values;
F2x4 = F2.data.getElement('EncoderX4').Values;

t2x1 = F2x1.Time(1001:9001);
v2x1 = F2x1.Data(1001:9001);

t2x2 = F2x2.Time(1001:9001);
v2x2 = F2x2.Data(1001:9001);

t2x4 = F2x4.Time(1001:9001);
v2x4 = F2x4.Data(1001:9001);

% แก้ offset เริ่มต้น
v2x1 = v2x1 - 24;
v2x2 = v2x2 - 48;
v2x4 = v2x4 - 96;

%% =========================
% File 3
% ==========================

F3_data = F3.data.getElement(2);

F3x1 = F3_data.getElement('EncoderX1').Values;
F3x2 = F3_data.getElement('EncoderX2').Values;
F3x4 = F3_data.getElement('EncoderX4').Values;

t3x1 = F3x1.Time(1001:9001);
v3x1 = F3x1.Data(1001:9001);

t3x2 = F3x2.Time(1001:9001);
v3x2 = F3x2.Data(1001:9001);

t3x4 = F3x4.Time(1001:9001);
v3x4 = F3x4.Data(1001:9001);

%แก้ offset เริ่มต้น
v3x1 = v3x1 - 48;
v3x2 = v3x2 - 96;
v3x4 = v3x4 - 192;

%% =========================
% Plot Graph
% ==========================

figure

% =========================
% File 1
% =========================
subplot(1,3,1)

plot(t1x1, v1x1, 'LineWidth', 1.5)
hold on
plot(t1x2, v1x2, 'LineWidth', 1.5)
plot(t1x4, v1x4, 'LineWidth', 1.5)

title('First Time')
ylabel('Encoder Count')
xlabel('Time (s)')
legend('X1','X2','X4')
set (gca, 'FontSize', 14)
set(gca, 'LineWidth', 1.5)
grid on
yticks(0:20:100)
yticks(sort(unique([yticks 24 48 96])))


% =========================
% File 2
% =========================
subplot(1,3,2)

plot(t2x1, v2x1, 'LineWidth', 1.5)
hold on
plot(t2x2, v2x2, 'LineWidth', 1.5)
plot(t2x4, v2x4, 'LineWidth', 1.5)

title('Second Time')
ylabel('Encoder Count')
xlabel('Time (s)')
legend('X1','X2','X4')
set (gca, 'FontSize', 14)
set(gca, 'LineWidth', 1.5)
grid on
yticks(0:20:100)
yticks(sort(unique([yticks 24 48 96])))


% =========================
% File 3
% =========================
subplot(1,3,3)

plot(t3x1, v3x1, 'LineWidth', 1.5)
hold on
plot(t3x2, v3x2, 'LineWidth', 1.5)
plot(t3x4, v3x4, 'LineWidth', 1.5)

title('Third Time')
xlabel('Time (s)')
ylabel('Encoder Count')
legend('X1','X2','X4')
set (gca, 'FontSize', 14)
set(gca, 'LineWidth', 1.5)
grid on
yticks(0:20:100)
yticks(sort(unique([yticks 24 48 96])))