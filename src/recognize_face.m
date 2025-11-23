function [label, isKnown] = recognize_face(faceImg, lbpModel, hogModel, cfg) %#ok<INUSD>
% =====================================================================================================================
% Project: Attendance Marking System using MATLAB
% File: recognize_face.m
% Author: Mobin Yousefi (GitHub: https://github.com/mobinyousefi-cs)
% Created: 2025-11-23
% Updated: 2025-11-23
% License: MIT License (see LICENSE file for details)
% =====================================================================================================================
%
% RECOGNIZE_FACE predicts the student ID for the given face image
% using both LBP and HOG models and fuses the decisions.
%
% Outputs:
%   label   - predicted student ID (string) or "Unknown"
%   isKnown - logical flag indicating whether label is a known ID

lbpFeat = extract_lbp_features(faceImg, cfg);
hogFeat = extract_hog_features(faceImg, cfg);

[predLbp, ~] = predict(lbpModel, lbpFeat);
[predHog, ~] = predict(hogModel, hogFeat);

predLbpStr = string(predLbp);
predHogStr = string(predHog);

if predLbpStr == predHogStr
    label  = predLbpStr;
    isKnown = true;
else
    label  = "Unknown";
    isKnown = false;
end

end
