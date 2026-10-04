% ========================================================
% 1. โหลดข้อมูลจากทั้ง 3 ไฟล์ (แก้ไขชื่อตัวแปรที่พิมพ์ตก)
% ========================================================
a=load('loadcell2.mat');   
sig_A4_1  = a.data.getElement('A4');
time_A4_1 = sig_A4_1.Values.Time;
data_A4_1 = sig_A4_1.Values.Data;
sig_raw_1  = a.data.getElement('raw');
time_raw_1 = sig_raw_1.Values.Time;
data_raw_1 = sig_raw_1.Values.Data;

b=load('loadcell1.mat');   
sig_A4_2  = b.data.getElement('A4');
time_A4_2 = sig_A4_2.Values.Time;
data_A4_2 = sig_A4_2.Values.Data;
sig_raw_2  = b.data.getElement('raw');
time_raw_2 = sig_raw_2.Values.Time;
data_raw_2 = sig_raw_2.Values.Data;

c=load('loadcell3.mat');   
sig_A4_3  = c.data.getElement('A4');
time_A4_3 = sig_A4_3.Values.Time;
data_A4_3 = sig_A4_3.Values.Data;
sig_raw_3  = c.data.getElement('raw');
time_raw_3 = sig_raw_3.Values.Time;
data_raw_3 = sig_raw_3.Values.Data;

x_values = [0.508,1.008,1.516,2.001,2.495,2.991,3.464,3.962,4.462,4.943,5.443,5.937,6.429,...
    6.916,7.411,7.909,8.423,8.942,9.416,9.906];
x=zeros(1,20);
% ========================================================
% 2. คำนวณหาค่าเฉลี่ยของแต่ละไฟล์
% ========================================================
% --- ไฟล์ที่ 1 ---
is_high1 = (data_A4_1(:) > 4000); 
edges1 = diff([0; is_high1; 0]); 
s1 = find(edges1 == 1); e1 = find(edges1 == -1) - 1;
valid1 = (time_raw_1(e1) - time_raw_1(s1)) > 10;
s1 = s1(valid1); e1 = e1(valid1);
mean_file1 = zeros(1, length(s1));
for i = 1:length(s1)
    mean_file1(i) = round((mean(data_raw_1(s1(i):e1(i)))/4095)*3.3,4);
end

% --- ไฟล์ที่ 2 ---
is_high2 = (data_A4_2(:) > 4000); 
edges2 = diff([0; is_high2; 0]); 
s2 = find(edges2 == 1); e2 = find(edges2 == -1) - 1;
valid2 = (time_raw_2(e2) - time_raw_2(s2)) > 10;
s2 = s2(valid2); e2 = e2(valid2);
mean_file2 = zeros(1, length(s2));
for i = 1:length(s2)
    mean_file2(i) = round((mean(data_raw_2(s2(i):e2(i)))/4095)*3.3,4);
end

% --- ไฟล์ที่ 3 ---
is_high3 = (data_A4_3(:) > 4000); 
edges3 = diff([0; is_high3; 0]); 
s3 = find(edges3 == 1); e3 = find(edges3 == -1) - 1;
valid3 = (time_raw_3(e3) - time_raw_3(s3)) > 10;
s3 = s3(valid3); e3 = e3(valid3);
mean_file3 = zeros(1, length(s3));
for i = 1:length(s3)
    mean_file3(i) = round((mean(data_raw_3(s3(i):e3(i)))/4095)*3.3,4);
end

% ========================================================
% 3. รวมข้อมูลและหาค่าเฉลี่ยรวม (ป้องกัน Error ขนาด Array ไม่เท่ากัน)
% ========================================================
% หาจำนวนรอบที่น้อยที่สุดจากทั้ง 3 ไฟล์
min_len = min([length(mean_file1), length(mean_file2), length(mean_file3)]);

% ตัดให้ความยาวเท่ากับ min_len ก่อนจับมารวม Matrix
all_means = [mean_file1(1:min_len); 
             mean_file2(1:min_len); 
             mean_file3(1:min_len)];
         
overall_mean = round(mean(all_means, 1), 4);
 
p = polyfit(overall_mean, x_values(1:min_len), 1);

m = p(1);
b = p(2);

% น้ำหนักของแต่ละช่วง
weight_est = polyval(p, overall_mean);
m_each = diff(x_values(1:min_len)) ./ diff(overall_mean);
% ========================================================
% 4. พล็อตกราฟเปรียบเทียบ
% ========================================================
figure;
hold on;
% % plot(mean_file1(1:min_len), 'r--', 'DisplayName', 'File 1');
% % plot(mean_file2(1:min_len), 'g--', 'DisplayName', 'File 2');
% % plot(mean_file3(1:min_len), 'm--', 'DisplayName', 'File 3');
% plot(overall_mean, 'b-o', 'LineWidth', 2, 'MarkerFaceColor', 'b', 'DisplayName', 'Average of 3 round');
% 
% % 3. เปลี่ยนป้ายชื่อแกน X (XTickLabels) ให้แสดงเป็นตัวเลขที่เรากำหนด
% xticks(1:min_len);
% xticklabels(string(x_values(1:min_len)));
% xtickangle(45); % เอียงตัวหนังสือ 45 องศาเพื่อไม่ให้ตัวเลขทับกัน
% 
% title('Average Raw Value Comparison');
% xlabel('Target Value'); % เปลี่ยนชื่อแกนตามชื่อข้อมูลของคุณ
% ylabel('Average Raw Value');
% legend('Location', 'best');
% grid on;
% hold off;
weight = x_values(1:min_len);
voltage = overall_mean;

% หาเส้นตรงประมาณค่า น้ำหนัก = m*V + b
p_vw = polyfit(voltage, weight, 1);
weight_fit = polyval(p_vw, voltage);

figure;
plot(weight, voltage, 'b-o', 'LineWidth', 2, 'MarkerFaceColor', 'b');
hold on;
plot(weight_fit, voltage, 'r-o', 'LineWidth', 2);
grid on;

xlabel('Voltage (V)');
ylabel('Weight');
title('Voltage vs Weight');
legend('real', 'load cell', 'Location', 'best');
hold off;