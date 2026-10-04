%% Real-time 12-bit ADC Noise Plotter (2 Bytes Serial)
clear; clc; close all;

% --- ตั้งค่าพอร์ต (ปรับ COM Port ให้ตรงกับเครื่องที่ใช้งาน) ---
portName = "COM5";
baudRate = 115200;

% ปิดและล้างพอร์ตค้างเดิมถ้ามีอยู่
if exist('s', 'var') && isvalid(s)
    clear s;
end

try
    % เปิดพอร์ต Serial และล้างข้อมูลขยะใน Buffer
    s = serialport(portName, baudRate);
    flush(s);
    disp("เชื่อมต่อพอร์ต " + portName + " สำเร็จแล้ว");

    % --- เตรียมการแสดงผลกราฟ ---
    bufferSize = 200; % จำนวนจุดข้อมูลที่จะแสดงบนหน้าจอ
    dataBuffer = zeros(1, bufferSize);

    fig = figure('Name', 'Real-time 12-bit ADC Signal & Noise', 'NumberTitle', 'off');
    hLine = plot(dataBuffer, 'LineWidth', 1.5, 'Color', [0 0.4470 0.7410]);
    grid on;
    ylim([0 4095]); % ล็อกแกน Y ตามสเกล ADC 12-bit
    
    title('Real-time 12-bit Potentiometer Signal (0 - 4095 LSB)', 'FontSize', 14);
    xlabel('Time (Samples)', 'FontSize', 12);
    ylabel('ADC Value (LSB)', 'FontSize', 12);

    % --- ลูปอ่านข้อมูลและพล็อตกราฟสด ---
    disp("กำลังพล็อตกราฟสด... (ปิดหน้าต่าง Figure เพื่อหยุดทำงาน)");
    
    while ishandle(hLine)
        if s.NumBytesAvailable >= 2
            rawData = read(s, 1, "uint16");
            dataBuffer = [dataBuffer(2:end), rawData];
            hLine.YData = dataBuffer;
            
            % --- แทรกโค้ดปรับแกน Y อัตโนมัติแบบมี Margin ตรงนี้ ---
            current_min = min(dataBuffer);
            current_max = max(dataBuffer);
            
            % ป้องกัน Error กรณีข้อมูลใน Buffer มีค่าเท่ากันหมด
            if current_max > current_min
                % เผื่อระยะขอบบนและล่างอย่างละ 20 LSB ให้กราฟดูสวยงาม ไม่ชนขอบ
                ylim([current_min - 20, current_max + 20]); 
            else
                ylim([current_min - 20, current_max + 20]);
            end
            % ------------------------------------------------
            
            drawnow limitrate;
        end
    end

catch ME
    disp("หยุดการทำงานหรือเกิดข้อผิดพลาด: " + ME.message);
end

% คืนทรัพยากรพอร์ต Serial ให้ระบบอย่างปลอดภัยเสมอ
clear s;
disp("ปิดพอร์ต Serial เรียบร้อยแล้ว");