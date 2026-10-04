clear; clc;

% --- User settings ---
inputFolder = "lab 1.1 poten 1";
filePattern = "poten*.mat";
startToRemoveSec = 2;
outputFolder = fullfile(inputFolder, "csv_out");

if ~exist(outputFolder, "dir")
    mkdir(outputFolder);
end

files = dir(fullfile(inputFolder, filePattern));

% --- Collect results from all files ---
NumberOfPoten = [];
DegPercent = [];
RepeatNum = [];
MeanValue = [];

for k = 1:numel(files)
    matFile = fullfile(files(k).folder, files(k).name);
    [~, baseName, ~] = fileparts(files(k).name);

    % Expected name: poten<number(s)> <deg>deg <repeat>
    tok = regexp(baseName, '^poten(?<poten>\d+)\s+(?<deg>\d+)deg\s+(?<rep>\d+)$', 'names');
    if isempty(tok)
        warning("Skipping %s: filename does not match expected pattern.", files(k).name);
        continue;
    end

    % Treat poten345 as separate poten 3, 4, 5
    potenDigits = double(tok.poten) - '0';

    S = load(matFile);

    if ~isfield(S, "data") || ~isa(S.data, "timeseries")
        warning("Skipping %s: variable S.data is missing or not a timeseries.", files(k).name);
        continue;
    end

    ts = S.data;
    x = double(ts.Data(:));
    t = double(ts.Time(:));

    if numel(t) ~= numel(x)
        warning("Skipping %s: Time and Data lengths do not match.", files(k).name);
        continue;
    end

    % --- Remove first few seconds ---
    keepIdx = t >= startToRemoveSec;
    xTrim = x(keepIdx);

    if isempty(xTrim)
        warning("Skipping %s: no data left after trimming.", files(k).name);
        continue;
    end

    % --- Mean of trimmed data ---
    xMean = mean(xTrim, "omitnan");

    % --- Convert ADC to voltage ---
    xMean = xMean / 4095 * 3.3;

    % --- Store one row per poten digit ---
    for p = 1:numel(potenDigits)
        NumberOfPoten(end+1, 1) = potenDigits(p);
        DegPercent(end+1, 1) = str2double(tok.deg);
        RepeatNum(end+1, 1) = str2double(tok.rep);
        MeanValue(end+1, 1) = xMean;
    end
end

if isempty(NumberOfPoten)
    warning("No valid files were processed. CSV not created.");
    return;
end

% --- Build summary table with Value1, Value2, Value3 ---
[uniqueKeys, ~, groupIdx] = unique([NumberOfPoten DegPercent], "rows", "stable");

nGroups = size(uniqueKeys, 1);
outFilename = strings(nGroups, 1);
outPoten = uniqueKeys(:, 1);
outDeg = uniqueKeys(:, 2);
Value1 = nan(nGroups, 1);
Value2 = nan(nGroups, 1);
Value3 = nan(nGroups, 1);

for i = 1:nGroups
    idx = groupIdx == i;
    reps = RepeatNum(idx);
    vals = MeanValue(idx);

    outFilename(i) = "poten" + outPoten(i) + " " + outDeg(i) + "deg";

    for j = 1:numel(reps)
        if reps(j) == 1
            Value1(i) = vals(j);
        elseif reps(j) == 2
            Value2(i) = vals(j);
        elseif reps(j) == 3
            Value3(i) = vals(j);
        end
    end
end

summary = table(outFilename, outPoten, outDeg, Value1, Value2, Value3, ...
    'VariableNames', {'Filename', 'NumberOfPoten', 'DegPercent', 'Value1', 'Value2', 'Value3'});

writetable(summary, fullfile(outputFolder, "potentiometer_summary.csv"));
disp("Saved: " + fullfile(outputFolder, "potentiometer_summary.csv"));
