# the client has to connect first before it starts searching for hands
import socket
import cv2
import time
from cvzone.HandTrackingModule import HandDetector
import math

# initialize the video capture, detector, and socket objects
def init_cap():
    cap = cv2.VideoCapture(0)
    return cap

def init_detector():
    detector = HandDetector(detectionCon=0.7, maxHands=2)
    return detector

def init_server():
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.bind(("127.0.0.1", 5000))  # the 5000 is the server ip that client is going to connect to.
    s.listen(5)  # the queue
    return s

# functions to establish the client, and to send to the client
def getClient(s):
    while True:
        clientsocket, Address = s.accept()
        print(f'IP Address [{Address}] has connect to the server')
        if clientsocket:
            return clientsocket


def send(clientsocket, packet):
    clientsocket.send(packet)


def msg_construction(hands, max_w, max_h):
    num_hands = 0
    num_landmarks = 0
    packet = ""
    if len(hands) > 0:
        num_hands = 1
        num_landmarks += len(hands[0]["lmList"])
        for i in range(len(hands[0]["lmList"])):
            if i < len(hands[0]["lmList"]) - 1:
                packet += str(round(hands[0]["lmList"][i][0] / max_w, 2)) + ":" + str(round(hands[0]["lmList"][i][1] / max_h, 2)) + "@"
            else:
                packet += str(round(hands[0]["lmList"][i][0] / max_w, 2)) + ":" + str(round(hands[0]["lmList"][i][1] / max_h, 2))
        if len(hands) > 1:
            num_hands = 2
            num_landmarks += len(hands[1]["lmList"])
            for i in range(len(hands[0]["lmList"])):
                if i < len(hands[0]["lmList"]) - 1:
                    packet += str(round(hands[1]["lmList"][i][0] / max_w, 2)) + ":" + str(round(hands[1]["lmList"][i][1] / max_h, 2)) + "@"
                else:
                    packet += str(round(hands[1]["lmList"][i][0] / max_w, 2)) + ":" + str(round(hands[1]["lmList"][i][1] / max_h, 2))

    data_len = len(packet).to_bytes(4, "big", signed=False)
    num_hands = num_hands.to_bytes(1, "big", signed=False)
    num_landmarks = num_landmarks.to_bytes(1, "big", signed=False)
    data = packet.encode("utf-8")
    packet = data_len + num_hands + num_landmarks + data
    return packet

def search_for_hands(clientsocket, cap, detector):
    max_w = 1
    max_h = 1
    while True:
        success, img = cap.read()
        hands, img = detector.findHands(img)
        if len(hands) > 0:
            if max(hands[0]["lmList"][:][0]) > max_w:
                max_w = max(hands[0]["lmList"][:][0])

            if max(hands[0]["lmList"][:][1]) > max_h:
                max_h = max(hands[0]["lmList"][:][1])

            if len(hands) > 1:
                if max(hands[1]["lmList"][:][0]) > max_w:
                    max_w = max(hands[0]["lmList"][:][0])

                if max(hands[1]["lmList"][:][1]) > max_h:
                    max_h = max(hands[0]["lmList"][:][1])

        msg = msg_construction(hands, max_w, max_h)
        send(clientsocket, msg)
        cv2.waitKey(0)


def main():
    s = init_server()
    c = getClient(s)
    cap = init_cap()
    detector = init_detector()
    search_for_hands(c, cap, detector)


if __name__ == '__main__':
    main()
