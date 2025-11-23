function ensureDir(folderPath)
% =====================================================================================================================
% Project: Attendance Marking System using MATLAB
% File: ensureDir.m
% Author: Mobin Yousefi (GitHub: https://github.com/mobinyousefi-cs)
% Created: 2025-11-23
% Updated: 2025-11-23
% License: MIT License (see LICENSE file for details)
% =====================================================================================================================
%
% ENSUREDIR creates the directory if it does not already exist.

if ~exist(folderPath, 'dir')
    mkdir(folderPath);
end

end
