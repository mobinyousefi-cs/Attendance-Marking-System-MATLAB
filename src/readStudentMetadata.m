function students = readStudentMetadata(studentsFile)
% =====================================================================================================================
% Project: Attendance Marking System using MATLAB
% File: readStudentMetadata.m
% Author: Mobin Yousefi (GitHub: https://github.com/mobinyousefi-cs)
% Created: 2025-11-23
% Updated: 2025-11-23
% License: MIT License (see LICENSE file for details)
% =====================================================================================================================
%
% READSTUDENTMETADATA loads the students.csv file into a table and
% normalizes types for downstream processing.

if ~isfile(studentsFile)
    error('Student metadata file not found at %s. Run setupProject first.', studentsFile);
end

students = readtable(studentsFile, 'TextType', 'string');

requiredVars = {"StudentID", "Name"};
for k = 1:numel(requiredVars)
    if ~ismember(requiredVars{k}, students.Properties.VariableNames)
        error('students.csv must contain a "%s" column.', requiredVars{k});
    end
end

% Normalize to string type
students.StudentID = string(students.StudentID);
students.Name      = string(students.Name);

end
