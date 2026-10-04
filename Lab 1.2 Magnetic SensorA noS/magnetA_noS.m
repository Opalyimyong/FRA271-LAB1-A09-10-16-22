% 1. กำหนดพิกัดแกน X ที่ต้องการพล็อต
groups = compose('%.1f',1.1:0.2:4.3);
num_files_per_group = 3;

% เตรียมตัวแปรเก็บค่า Y แบบ 1 ค่า ต่อ 1 กลุ่ม (รวม 5 ค่า)
y_plot_values1 = zeros(1, length(groups));
y_plot_values2 = zeros(1, length(groups));
y_plot_values3 = zeros(1, length(groups));
y_plot_values = zeros(1, length(groups));
y_plot_mag = zeros(1, length(groups));

% 2. วนลูปดึงข้อมูลทีละกลุ่ม
for i = 1:length(groups)
    group_name = groups{i};

    y_sum_all = 0;
    total_data_points = 0;

    % ดึงไฟล์ย่อย (1, 2, 3) ในกลุ่มมารวมกัน
    for j = 1:num_files_per_group
        filename = sprintf('magnetA_noS %s %d.mat', group_name, j);

        if isfile(filename)
            temp = load(filename);
            
            % 1. ดึงแกน X และ Y ออกมาเก็บไว้ในตัวแปรชั่วคราวก่อน
            x_raw = double(temp.data.Time);            
            y_raw = double(squeeze(temp.data.Data));   
            
         
            
            % 3. ดึงค่า Y ออกมาเฉพาะตำแหน่งที่ผ่านเงื่อนไขเวลาเท่านั้น
            y_data = y_raw((x_raw >= 1) & (x_raw <= 5));

            % รวมยอดค่า Y และนับจำนวนจุดข้อมูลทั้งหมด
            if j == 1
                y_plot_values1(i) = round((mean(y_data)/4095)*3.3,4);
            elseif j == 2
                y_plot_values2(i) = round((mean(y_data)/4095)*3.3,4);
            elseif j == 3
                y_plot_values3(i) = round((mean(y_data)/4095)*3.3,4);
            end
                
            y_sum_all = y_sum_all + sum(y_data);
            total_data_points = total_data_points + length(y_data);
        end
    end

    % 3. หาค่าเฉลี่ย Y ของกลุ่มนี้ เพื่อใช้เป็นตัวแทนพล็อตลงบนพิกัด X
    if total_data_points > 0
        y_plot_values(i) = round(((y_sum_all / total_data_points)/4095)*3.3,4);
        y_plot_mag(i)=round(((y_plot_values(i)*1000)-(1.65*1000))/30,4);
    else
        y_plot_values(i) = NaN; % ถ้ากลุ่มไหนไฟล์หาย ให้เว้นว่างจุดนั้นไว้ (กัน Error)
    end
end

% 4. พล็อตกราฟเส้นเดียวเชื่อมต่อกัน
figure;
hold on
grid on;
% ใช้ '-o' เพื่อวาดเส้นตรงและมีจุดวงกลมมาร์คในแต่ละพิกัด X
plot(str2double(groups), y_plot_values1, '-o', 'LineWidth', 2, 'MarkerSize', 8, 'MarkerFaceColor', 'b');

xticks(str2double(groups)); 
xlabel('phase (mm)');
ylabel('Voltage (V)');
title('Voltage comparison');
hold off;



% subplot(1,2,2);
% plot(str2double(groups), y_plot_mag, '-o', 'LineWidth', 2, 'MarkerSize', 8, 'MarkerFaceColor', 'b');
% hold on
% grid on;
% 
% % ตั้งค่าแกน X ให้แสดงเลขเฉพาะกลุ่มที่มี
% xticks(str2double(groups)); 
% xlabel('phase (mm)');
% ylabel('Magnetic Flux (mT)');
% title('Magnet north no shield');