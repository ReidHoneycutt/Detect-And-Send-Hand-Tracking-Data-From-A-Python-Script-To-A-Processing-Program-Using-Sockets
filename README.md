# Detect-And-Send-Hand-Tracking-Data-From-A-Python-Script-To-A-Processing-Program-Using-Sockets


- This repo contains a python script called "search_for_hands_and_send_data.py" which runs a video capture thread using the opencv-python (cv2) library, and a hand detector object using cvzone/mediapipe, and it also creates a server to send to a client.
- When a client connects to the server (such as one of the processing (.pde) programs, or p5js scripts in this repo), the server will send packets to the client containing the landmarks of the hands that it sees.
- The .pde scripts in this repo contain clients which receive this landmark data, then parse, and display various animations based on this data in various ways. 

  To run it, first open up the .pde files in the creative coding software "Processing", then run the python program after installing the neccessary libraries (included below). Make both hands visible to the camera to see different aesthetics. Various aesthetics will be added to this in additional .pde files. 

REQUIRED PYTHON LIBRARIES: socket, cv2 (called opencv-python in pycharm), cvzone, and mediapipe

NOTES: I used pycharm as my python IDE, and used Windows 10 as my OS. MacOS seems to have some access issues when running scripts that use the webcam.

https://user-images.githubusercontent.com/30945205/235345677-5c68f008-6339-425a-9fb3-da182609e900.mp4

https://user-images.githubusercontent.com/30945205/222884376-b187e47f-abcc-4cec-b0e3-381c5d8e869e.mp4

https://user-images.githubusercontent.com/30945205/235345749-ab56e543-3783-46b4-8243-ab987a01abcb.mp4

