# EOptomizer Lite - Note 9
A Flutter based mobile app to perform DVFS easily on Samsung Galaxy Note 9 and record system performance metrics such as power consumption, FPS, temperature of big CPUs, LITTLE CPUs & GPUs.

## Installation

Flutter/Dart need to be installed on the development platform to be able to build and generate the .apk of the app for Android.

To install Flutter on your system follow the instructions below:
- [Build Flutter Apps for iOS and Android Tutorial](https://youtube.com/playlist?list=PLSzsOkUDsvdtl3Pw48-R8lcK2oYkk40cm)

Make sure that you have the following version of Flutter/Dart installed on your computer:

> **Flutter 3.3.8** • channel stable • https://github.com/flutter/flutter.git
> Framework • revision 52b3dc25f6 (12 days ago) • 2022-11-09 12:09:26 +0800
> Engine • revision 857bd6b74c
> Tools • **Dart 2.18.4** • DevTools 2.15.0

To check Flutter version after you have downloaded and installed Flutter/Dart use the following command:
```
flutter --version
```	

### Recording & Fetching System Performance Metrics

To record the system performance metrics such as power consumption, FPS, temperature of big CPUs, LITTLE CPUs & GPUs of Note 9 make sure that the files from the /scripts folder are offloaded to the Note 9 device in the following directory: /data/local/tmp

Also, need to provide executable permission to profiling.sh, get_fps.sh & utils.sh in the /data/local/tmp of Note 9. This can be done by accessing /data/local/tmp and then executing the following commands:

```
chmod +x utils.sh
chmod +x get_fps.sh
chmod +x profiling.sh
```	

## App UI/UX

![Graphical interface of ‘EOptomizer Lite - Note 9’ mobile app. (a) shows the app UI when CPUs & GPUs operate on default frequencies of the schedutil governor; (b) shows the app UI when the CPUs & GPUs operate at a chosen frequency for LITTLE & big CPUs and GPUs respectively](EOptomizer-Lite.png)

Graphical interface of ‘EOptomizer Lite - Note 9’ mobile app. (a) shows the app UI when CPUs & GPUs operate on default frequencies of the schedutil governor; (b) shows the app UI when the CPUs & GPUs operate at a chosen frequency for LITTLE & big CPUs and GPUs respectively
