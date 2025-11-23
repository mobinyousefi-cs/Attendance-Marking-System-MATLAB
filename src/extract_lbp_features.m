function feat = extract_lbp_features(faceImg, cfg)
% =====================================================================================================================
% Project: Attendance Marking System using MATLAB
% File: extract_lbp_features.m
% Author: Mobin Yousefi (GitHub: https://github.com/mobinyousefi-cs)
% Created: 2025-11-23
% Updated: 2025-11-23
% License: MIT License (see LICENSE file for details)
% =====================================================================================================================
%
% EXTRACT_LBP_FEATURES computes LBP features for a preprocessed
% grayscale face image.

if size(faceImg, 3) ~= 1
    error('extract_lbp_features expects a single-channel (grayscale) image.');
end

feat = extractLBPFeatures(faceImg, 'CellSize', cfg.model.lbpCellSize);

end
