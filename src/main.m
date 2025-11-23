% =====================================================================================================================
% Project: Attendance Marking System using MATLAB
% File: main.m
% Author: Mobin Yousefi (GitHub: https://github.com/mobinyousefi-cs)
% Created: 2025-11-23
% Updated: 2025-11-23
% License: MIT License (see LICENSE file for details)
% =====================================================================================================================
%
% Entry point script for the Attendance Marking System.
% Use this script to train the face recognition models and
% run an attendance session with a connected webcam.

clear; clc; close all;

fprintf('Attendance Marking System using MATLAB\n');
fprintf('--------------------------------------\n\n');

cfg = config();
setupProject(cfg);

keepRunning = true;

while keepRunning
    fprintf('\nMain Menu\n');
    fprintf('  1) Train / retrain face recognition models\n');
    fprintf('  2) Run attendance session (webcam)\n');
    fprintf('  3) Exit\n');
    
    choice = input('Select an option (1-3): ');
    
    try
        switch choice
            case 1
                fprintf('\n[INFO] Starting training pipeline...\n');
                train_models(cfg);
            case 2
                fprintf('\n[INFO] Starting attendance session...\n');
                run_attendance(cfg);
            case 3
                keepRunning = false;
            otherwise
                fprintf('[WARN] Invalid choice. Please select 1, 2, or 3.\n');
        end
    catch ME
        fprintf(2, '[ERROR] %s\n', ME.message);
        if ~isempty(ME.stack)
            fprintf(2, '  in %s (line %d)\n', ME.stack(1).name, ME.stack(1).line);
        end
    end
end

fprintf('\n[INFO] Exiting Attendance Marking System. Goodbye.\n');
