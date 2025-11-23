function feat = extract_hog_features(faceImg, cfg)
% =====================================================================================================================
% Project: Attendance Marking System using MATLAB
% File: extract_hog_features.m
% Author: Mobin Yousefi (GitHub: https://github.com/mobinyousefi-cs)
% Created: 2025-11-23
% Updated: 2025-11-23
% License: MIT License (see LICENSE file for details)
% =====================================================================================================================
%
% EXTRACT_HOG_FEATURES computes HOG features for a preprocessed
% grayscale face image.

if size(faceImg, 3) ~= 1
    error('extract_hog_features expects a single-channel (grayscale) image.');
end

feat = extractHOGFeatures(faceImg, 'CellSize', cfg.model.hogCellSize);

end
