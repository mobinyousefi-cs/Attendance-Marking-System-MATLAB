function run_attendance(cfg)
% =====================================================================================================================
% Project: Attendance Marking System using MATLAB
% File: run_attendance.m
% Author: Mobin Yousefi (GitHub: https://github.com/mobinyousefi-cs)
% Created: 2025-11-23
% Updated: 2025-11-23
% License: MIT License (see LICENSE file for details)
% =====================================================================================================================
%
% RUN_ATTENDANCE starts a webcam-based attendance session. Faces are
% detected in real time, recognized using LBP + HOG models, and
% attendance is written to an Excel sheet.

% -------------------------------------------------------------------------
% Load models and metadata
% -------------------------------------------------------------------------
lbpModelPath = fullfile(cfg.paths.models, 'lbpModel.mat');
hogModelPath = fullfile(cfg.paths.models, 'hogModel.mat');

if ~isfile(lbpModelPath) || ~isfile(hogModelPath)
    error('Trained models not found. Please run train_models first.');
end

lbpData = load(lbpModelPath, 'lbpModel', 'students', 'classNames');
hogData = load(hogModelPath, 'hogModel');

lbpModel = lbpData.lbpModel;
hogModel = hogData.hogModel;
students = lbpData.students;

% -------------------------------------------------------------------------
% Initialize webcam and detector
% -------------------------------------------------------------------------
camList = webcamlist;
if isempty(camList)
    error('No webcam detected. Please connect a camera and try again.');
end

camIdx = min(cfg.webcam.deviceIndex, numel(camList));
cam    = webcam(camIdx);

faceDetector = vision.CascadeObjectDetector();

% Track which students have already been marked present
presentMap = containers.Map('KeyType', 'char', 'ValueType', 'logical');

sessionDate = string(datetime('today', 'Format', 'yyyy-MM-dd'));

fprintf('[INFO] Attendance session started for %s. Press "q" in the figure to stop.\n', sessionDate);

hFig = figure('Name', 'Attendance Session', ...
    'NumberTitle', 'off', ...
    'MenuBar', 'none', ...
    'ToolBar', 'none');
setappdata(hFig, 'keyPressed', '');
set(hFig, 'KeyPressFcn', @(src, evt) setappdata(src, 'keyPressed', evt.Key));

try
    while ishandle(hFig)
        frame = snapshot(cam);

        [faceImg, bbox] = prepareFace(frame, cfg, faceDetector);
        labelText = 'No face';

        if ~isempty(faceImg)
            [label, isKnown] = recognize_face(faceImg, lbpModel, hogModel, cfg);

            if isKnown
                labelKey = char(label);
                if ~isKey(presentMap, labelKey) || ~presentMap(labelKey)
                    mark_attendance(label, students, cfg);
                    presentMap(labelKey) = true;
                end

                % Map student ID to name for display
                idx = find(students.StudentID == label, 1);
                if ~isempty(idx)
                    labelText = sprintf('%s (%s)', students.Name(idx), label);
                else
                    labelText = char(label);
                end
            else
                labelText = 'Unknown';
            end

            % Draw bounding box and label
            frame = insertShape(frame, 'Rectangle', bbox, 'LineWidth', 3);
            frame = insertText(frame, bbox(1:2) + [0 -20], labelText, ...
                'FontSize', 14, 'BoxOpacity', 0.7);
        end

        imshow(frame, 'Parent', gca);
        title(sprintf('Attendance Session - %s', sessionDate));
        drawnow;

        key = getappdata(hFig, 'keyPressed');
        if strcmpi(key, 'q')
            break;
        end
    end
catch ME
    clear cam;
    if ishandle(hFig)
        close(hFig);
    end
    rethrow(ME);
end

if ishandle(hFig)
    close(hFig);
end

clear cam;

fprintf('[INFO] Attendance session finished.\n');

end
