function cfg = config()
% =====================================================================================================================
% Project: Attendance Marking System using MATLAB
% File: config.m
% Author: Mobin Yousefi (GitHub: https://github.com/mobinyousefi-cs)
% Created: 2025-11-23
% Updated: 2025-11-23
% License: MIT License (see LICENSE file for details)
% =====================================================================================================================
%
% CONFIG returns a struct with all configurable parameters and paths
% used throughout the project.

rootDir = fileparts(mfilename('fullpath'));

cfg = struct();

% -------------------------------------------------------------------------
% Paths
% -------------------------------------------------------------------------
cfg.paths.root       = rootDir;
cfg.paths.data       = fullfile(rootDir, 'data');
cfg.paths.faces      = fullfile(cfg.paths.data, 'faces');
cfg.paths.studentsFile = fullfile(cfg.paths.data, 'students.csv');
cfg.paths.models     = fullfile(rootDir, 'models');
cfg.paths.logs       = fullfile(rootDir, 'logs');
cfg.paths.attendance = fullfile(rootDir, 'attendance');

% -------------------------------------------------------------------------
% Model and feature parameters
% -------------------------------------------------------------------------
% Face images are converted to grayscale and resized to this size.
cfg.model.faceImageSize = [128 128];

% LBP parameters (see extractLBPFeatures documentation)
cfg.model.lbpCellSize   = [16 16];

% HOG parameters (see extractHOGFeatures documentation)
cfg.model.hogCellSize   = [8 8];

% Thresholding / fusion options (placeholder if you want to extend later)
cfg.model.unknownThreshold = 0.0;  % Not used directly in this baseline

% -------------------------------------------------------------------------
% Face detection and webcam parameters
% -------------------------------------------------------------------------
cfg.detection.minSize       = [80 80];
cfg.detection.mergeThreshold = 4;

% Webcam selection (index into webcamlist())
cfg.webcam.deviceIndex      = 1;  % Adjust if you have multiple cameras
cfg.webcam.frameRate        = 10; % Target frame rate (best-effort)

% Attendance session behavior
cfg.attendance.sessionTimeoutSeconds = 0;  % 0 => no automatic timeout

end
