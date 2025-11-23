function mark_attendance(studentId, students, cfg)
% =====================================================================================================================
% Project: Attendance Marking System using MATLAB
% File: mark_attendance.m
% Author: Mobin Yousefi (GitHub: https://github.com/mobinyousefi-cs)
% Created: 2025-11-23
% Updated: 2025-11-23
% License: MIT License (see LICENSE file for details)
% =====================================================================================================================
%
% MARK_ATTENDANCE appends (or updates) the daily Excel attendance file
% for the recognized student.

sessionDate = string(datetime('today', 'Format', 'yyyy-MM-dd'));
sessionTime = string(datetime('now',   'Format', 'HH:mm:ss'));

attendanceFile = fullfile(cfg.paths.attendance, ...
    sprintf('attendance_%s.xlsx', sessionDate));

if isfile(attendanceFile)
    T = readtable(attendanceFile, 'TextType', 'string');
else
    T = table('Size', [0 6], ...
        'VariableTypes', {'string', 'string', 'string', 'string', 'string', 'string'}, ...
        'VariableNames', {'StudentID', 'Name', 'Date', 'Time', 'Status', 'Method'});
end

% Avoid double-marking the same student on the same date
alreadyIdx = find(T.StudentID == studentId & T.Date == sessionDate, 1);
if ~isempty(alreadyIdx)
    fprintf('[INFO] Attendance already marked for student %s on %s.\n', studentId, sessionDate);
    return;
end

idx = find(students.StudentID == studentId, 1);
if isempty(idx)
    studentName = "Unknown";
else
    studentName = students.Name(idx);
end

newRow = {studentId, studentName, sessionDate, sessionTime, "Present", "LBP+HOG"};
T = [T; newRow]; %#ok<AGROW>

writetable(T, attendanceFile);

fprintf('[INFO] Attendance recorded for %s (%s) at %s.\n', studentName, studentId, sessionTime);

end
