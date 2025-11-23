function train_models(cfg)
% =====================================================================================================================
% Project: Attendance Marking System using MATLAB
% File: train_models.m
% Author: Mobin Yousefi (GitHub: https://github.com/mobinyousefi-cs)
% Created: 2025-11-23
% Updated: 2025-11-23
% License: MIT License (see LICENSE file for details)
% =====================================================================================================================
%
% TRAIN_MODELS builds LBP- and HOG-based face recognition models
% from the labeled face image dataset on disk.
%
% Requirements:
%   - Computer Vision Toolbox (for extractLBPFeatures, extractHOGFeatures)
%   - Statistics and Machine Learning Toolbox (for fitcecoc, templateSVM)

students = readStudentMetadata(cfg.paths.studentsFile);

if isempty(students)
    error('No students defined in students.csv. Please populate it first.');
end

lbpFeatures = [];
hogFeatures = [];
labels      = strings(0, 1);

fprintf('[INFO] Collecting training images and extracting features...\n');

for i = 1:height(students)
    sid   = students.StudentID(i);
    sname = students.Name(i);

    studentFaceDir = fullfile(cfg.paths.faces, char(sid));
    if ~exist(studentFaceDir, 'dir')
        fprintf('[WARN] No face folder found for %s (%s). Skipping.\n', sname, sid);
        continue;
    end

    exts = {'*.jpg', '*.jpeg', '*.png', '*.bmp'};
    imageFiles = [];
    for e = 1:numel(exts)
        imageFiles = [imageFiles; dir(fullfile(studentFaceDir, exts{e}))]; %#ok<AGROW>
    end

    if isempty(imageFiles)
        fprintf('[WARN] No images found in %s. Skipping student %s.\n', studentFaceDir, sid);
        continue;
    end

    fprintf('[INFO] Processing %d images for %s (%s)...\n', numel(imageFiles), sname, sid);

    for k = 1:numel(imageFiles)
        imgPath = fullfile(studentFaceDir, imageFiles(k).name);
        I = imread(imgPath);

        % No detector needed here; assume images are already cropped faces.
        if size(I, 3) == 3
            Igray = rgb2gray(I);
        else
            Igray = I;
        end

        Igray = imresize(Igray, cfg.model.faceImageSize);

        lbpFeat = extract_lbp_features(Igray, cfg);
        hogFeat = extract_hog_features(Igray, cfg);

        lbpFeatures = [lbpFeatures; lbpFeat]; %#ok<AGROW>
        hogFeatures = [hogFeatures; hogFeat]; %#ok<AGROW>
        labels      = [labels; sid]; %#ok<AGROW>
    end
end

if isempty(labels)
    error('No training data collected. Please verify your faces/ folders.');
end

fprintf('[INFO] Training LBP-based ECOC SVM model (%d samples)...\n', numel(labels));

labelsCat = categorical(labels);

svmTemplate = templateSVM('KernelFunction', 'linear', 'Standardize', true);

lbpModel = fitcecoc(lbpFeatures, labelsCat, ...
    'Learners', svmTemplate, ...
    'Coding',   'onevsall', ...
    'Verbose',  0);

fprintf('[INFO] Training HOG-based ECOC SVM model (%d samples)...\n', numel(labels));

hogModel = fitcecoc(hogFeatures, labelsCat, ...
    'Learners', svmTemplate, ...
    'Coding',   'onevsall', ...
    'Verbose',  0);

classNames = categories(labelsCat);

% Save models
lbpModelPath = fullfile(cfg.paths.models, 'lbpModel.mat');
hogModelPath = fullfile(cfg.paths.models, 'hogModel.mat');

save(lbpModelPath, 'lbpModel', 'students', 'cfg', 'classNames', '-v7.3');
save(hogModelPath, 'hogModel', 'students', 'cfg', 'classNames', '-v7.3');

fprintf('[INFO] Models saved to:\n');
fprintf('       %s\n', lbpModelPath);
fprintf('       %s\n', hogModelPath);

end
