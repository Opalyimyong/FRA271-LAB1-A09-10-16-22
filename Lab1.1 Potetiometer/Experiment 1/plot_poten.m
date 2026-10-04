clear; clc; close all;

csvFile = fullfile("lab 1.1 poten 3", "csv_out", "potentiometer_summary.csv");

T = readtable(csvFile);

% Compute average of the 3 repeats
T.AverageValue = mean(T{:, {'Value1', 'Value2', 'Value3'}}, 2, 'omitnan');

% Convert to percent of 3.3 V
T.PercentValue = (T.AverageValue / 3.3) * 100;

% Get unique potentiometer numbers
potenList = unique(T.NumberOfPoten, 'stable');

figure;
tiledlayout(numel(potenList), 1, "TileSpacing", "compact", "Padding", "compact");

for i = 1:numel(potenList)
    idx = T.NumberOfPoten == potenList(i);

    x = T.DegPercent(idx);
    y = T.PercentValue(idx);

    [x, order] = sort(x);
    y = y(order);

    nexttile;
    
    plot(x, y, '-o', 'LineWidth', 1.5);
    grid on;
    grid minor
    ylim([0 100]);
    xlim([0 100]);
    yticks(0:10:100);
    xticks(0:10:100);
    axis square

    set(gca, 'FontSize', 12)
    
    xlabel("Rotational Travel (%)", 'FontSize', 14);
    ylabel("$\frac{\mathrm{Terminal\ 1\!-\!2\ Output\ Voltage}}{\mathrm{Terminal\ 1\!-\!3\ Input\ Voltage}} \times 100\ (\%)$", ...
       "Interpreter", "latex");
    title("Potentiometer " + potenList(i), 'FontSize', 14);
end
