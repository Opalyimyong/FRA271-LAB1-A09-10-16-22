F1 = load('Find2_PPR1.mat');
F2 = load('Find2_PPR2.mat');
F3 = load('Find2_PPR3.mat');

%% =========================
% File 1
% ==========================

F1x1 = F1.data.getElement('EncoderX1').Values;
F1x2 = F1.data.getElement('EncoderX2').Values;
F1x4 = F1.data.getElement('EncoderX4').Values;

t1x1 = F1x1.Time(1030:8001);
v1x1 = F1x1.Data(1030:8001);

t1x2 = F1x2.Time(1030:8001);
v1x2 = F1x2.Data(1030:8001);

t1x4 = F1x4.Time(1030:8001);
v1x4 = F1x4.Data(1030:8001);


%% =========================
% File 2
% ==========================

F2x1 = F2.data.getElement('EncoderX1').Values;
F2x2 = F2.data.getElement('EncoderX2').Values;
F2x4 = F2.data.getElement('EncoderX4').Values;

t2x1 = F2x1.Time;
v2x1 = F2x1.Data;

t2x2 = F2x2.Time;
v2x2 = F2x2.Data;

t2x4 = F2x4.Time;
v2x4 = F2x4.Data;

%% =========================
% File 3
% ==========================

F3x1 = F3.data.getElement('EncoderX1').Values;
F3x2 = F3.data.getElement('EncoderX2').Values;
F3x4 = F3.data.getElement('EncoderX4').Values;

t3x1 = F3x1.Time(301:9001);
v3x1 = F3x1.Data(301:9001);

t3x2 = F3x2.Time(301:9001);
v3x2 = F3x2.Data(301:9001);

t3x4 = F3x4.Time(301:9001);
v3x4 = F3x4.Data(301:9001);

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
yticks(0:1500:9000)
yticks(sort(unique([yticks 2025 4050 8100])))


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
yticks(0:3000:10000)
yticks(sort(unique([yticks 2166 4332 8664])))


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
yticks(0:3000:8000)
yticks(sort(unique([yticks 2230 4462 8920])))
