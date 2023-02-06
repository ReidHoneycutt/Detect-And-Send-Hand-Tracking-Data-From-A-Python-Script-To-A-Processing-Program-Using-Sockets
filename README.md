# Detect-And-Send-Hand-Tracking-Data-From-A-Python-Script-To-A-Processing-Program-Using-Sockets

This repo contains a python script which runs a video capture using the opencv-python (cv2) library, and a hand detector using cvzone/mediapipe, and it also creates a server. When a client connects to the server (such as one of the processing (.pde) programs in this repo), the server will send a packet to the client containing the landmarks of the hands that it sees. The .pde scripts in this repo contains clients which receive this landmark data, then parse, and display various animations based on this data. 

REQUIRED LIBRARIES: socket, cv2 (called opencv-python in pycharm), cvzone, and mediapipe

NOTES: I used pycharm as my python IDE, and used Windows 10 as my OS. Macs seem to have some access issues when running scripts that use the webcam.

