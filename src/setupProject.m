function setupProject(cfg)
% =====================================================================================================================
% Project: Attendance Marking System using MATLAB
% File: setupProject.m
% Author: Mobin Yousefi (GitHub: https://github.com/mobinyousefi-cs)
% Created: 2025-11-23
% Updated: 2025-11-23
% License: MIT License (see LICENSE file for details)
% =====================================================================================================================
%
% SETUPPROJECT ensures that the directory structure exists and that
% a sample students.csv file is present.

% Create required directories
requiredDirs = { ...
    cfg.paths.data, ...
    cfg.paths.faces, ...
    cfg.paths.models, ...
    cfg.paths.logs, ...
    cfg.paths.attendance ...
    };

for k = 1:numel(requiredDirs)
    ensureDir(requiredDirs{k});
end

% Create a sample students.csv if it does not exist yet
if ~isfile(cfg.paths.studentsFile)
    fprintf('[INFO] Creating sample students.csv at %s\n', cfg.paths.studentsFile);
    students = table();
    students.StudentID = ["S001"; "S002"]; %#ok<*SAGROW>
    students.Name      = ["Example Student 1"; "Example Student 2"];
    
    writetable(students, cfg.paths.studentsFile);
    fprintf('[INFO] Please update students.csv with real student IDs and names.\n');
end

end
