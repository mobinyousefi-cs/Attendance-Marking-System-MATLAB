function [faceImg, bbox] = prepareFace(frame, cfg, detector)
% =====================================================================================================================
% Project: Attendance Marking System using MATLAB
% File: prepareFace.m
% Author: Mobin Yousefi (GitHub: https://github.com/mobinyousefi-cs)
% Created: 2025-11-23
% Updated: 2025-11-23
% License: MIT License (see LICENSE file for details)
% =====================================================================================================================
%
% PREPAREFACE detects the largest face in the RGB frame and returns
% a preprocessed grayscale face image suitable for feature extraction.
%
% Inputs:
%   frame    - RGB image from the webcam
%   cfg      - configuration struct
%   detector - vision.CascadeObjectDetector instance (optional)
%
% Outputs:
%   faceImg  - grayscale, resized face image ([] if no face)
%   bbox     - [x y w h] bounding box of the detected face ([] if none)

if nargin < 3 || isempty(detector)
    detector = vision.CascadeObjectDetector();
end

% Configure detector
try
    detector.MinSize       = cfg.detection.minSize;
    detector.MergeThreshold = cfg.detection.mergeThreshold;
catch
    % Some MATLAB versions may not expose these as settable; ignore.
end

% Detect faces
try
    bboxes = detector(frame);     % Newer syntax
catch
    bboxes = step(detector, frame); % Older syntax
end

if isempty(bboxes)
    faceImg = [];
    bbox    = [];
    return;
end

% Select the largest face
areas = bboxes(:, 3) .* bboxes(:, 4);
[~, idx] = max(areas);
bbox = bboxes(idx, :);

% Crop and preprocess
face = imcrop(frame, bbox);
if size(face, 3) == 3
    gray = rgb2gray(face);
else
    gray = face;
end

faceImg = imresize(gray, cfg.model.faceImageSize);

end
