# Detect-And-Send-Hand-Tracking-Data-From-A-Python-Script-To-A-Processing-Program-Using-Sockets


This repo has all the scripts needed to construct a type of interactive art installation (details in the README), it contains a python script which runs a video capture using the opencv-python (cv2) library, and a hand detector using cvzone/mediapipe, and it also creates a server. When a client connects to the server (such as one of the processing (.pde) programs in this repo), the server will send a packet to the client containing the landmarks of the hands that it sees. The .pde scripts in this repo contains clients which receive this data, and display various animations based on this data
