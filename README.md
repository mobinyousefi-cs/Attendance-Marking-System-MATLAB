# Attendance Marking System using MATLAB

## Overview

This project implements an automated **Attendance Marking System** using
**face recognition** in MATLAB. It replaces manual attendance processes
by detecting student faces via webcam and marking their attendance
directly into an Excel sheet.

The system uses two classical computer vision descriptors:

-   **LBP (Local Binary Patterns)**
-   **HOG (Histogram of Oriented Gradients)**

Both feature sets are classified using **ECOC SVM models**, and
decisions are fused for robust face recognition.

------------------------------------------------------------------------

## Features

### ✓ Automatic Attendance

-   Detects faces via webcam.
-   Recognizes students using trained LBP/HOG models.
-   Marks attendance immediately without manual intervention.

### ✓ Training Pipeline

-   Supports multiple students.
-   Reads face images from structured dataset.
-   Automatically extracts LBP and HOG features.
-   Trains separate ECOC SVM classifiers for each descriptor.

### ✓ Real-Time Recognition

-   Live webcam feed.
-   Face detection using Viola--Jones.
-   Bounding boxes & labels displayed on screen.
-   Attendance logged into daily Excel file.

### ✓ Modular & Extendable

-   Clean MATLAB project structure.
-   Easy to upgrade feature extractors or classifiers.
-   Compatible with academic research workflows.

------------------------------------------------------------------------

## Directory Structure

    project/
    │
    ├── main.m
    ├── config.m
    ├── setupProject.m
    ├── run_attendance.m
    ├── train_models.m
    ├── recognize_face.m
    ├── mark_attendance.m
    │
    ├── models/
    │   ├── lbpModel.mat
    │   └── hogModel.mat
    │
    ├── data/
    │   ├── students.csv
    │   └── faces/
    │       ├── S001/
    │       │   ├── img1.jpg
    │       │   └── img2.jpg
    │       └── S002/
    │           ├── img1.jpg
    │           └── img2.jpg
    │
    ├── attendance/
    │   └── attendance_YYYY-MM-DD.xlsx
    │
    └── logs/

------------------------------------------------------------------------

## Requirements

### MATLAB Toolboxes:

-   **Computer Vision Toolbox**
-   **Image Processing Toolbox**
-   **Statistics and Machine Learning Toolbox**

### Hardware:

-   A functioning webcam.

------------------------------------------------------------------------

## How to Use

### 1. Prepare Student Dataset

Edit:

    data/students.csv

Add your Student IDs and Names.

For each student, create a folder:

    data/faces/<StudentID>/

Place cropped face images inside.

### 2. Train Models

Run:

``` matlab
main
```

Choose option:

    1) Train / retrain face recognition models

This will generate:

    models/lbpModel.mat
    models/hogModel.mat

### 3. Run Attendance Session

From the main menu:

    2) Run attendance session (webcam)

Press **q** to stop the session.

The system automatically generates:

    attendance/attendance_YYYY-MM-DD.xlsx

with:

  StudentID   Name   Date   Time   Status   Method
  ----------- ------ ------ ------ -------- --------

------------------------------------------------------------------------

## Notes

-   Images must contain a **clear view of the student's face**.
-   Better training images → higher recognition accuracy.
-   You can replace SVMs with deep learning models in the future.

------------------------------------------------------------------------

## License

This project is licensed under the **MIT License**.

------------------------------------------------------------------------

## Author

**Mobin Yousefi**\
GitHub: https://github.com/mobinyousefi-cs
