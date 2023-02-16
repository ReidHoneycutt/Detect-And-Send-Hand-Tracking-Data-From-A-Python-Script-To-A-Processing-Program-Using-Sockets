// after you've run the python program, make both hands visible to your webcam (a few feet away), and a mandalic pattern should show up.
// the mandala's diameter, and number of chords are functions of how far apart your hands are.

import java.io.*;
import java.net.*;
import java.util.*;
import java.nio.ByteBuffer;
import processing.sound.*;

Socket socket;
InputStream is;
byte[] buffer = new byte[1024];
Vector<float[]> coords = new Vector<float[]>();

void setup() {
  fullScreen();
  strokeCap(CORNER);
  stroke(255);
  // establish a connection
  try {
      socket = new Socket("127.0.0.1", 5000);
      is = socket.getInputStream();
      System.out.println("Connected");
  }
  catch (UnknownHostException u) {
      System.out.println(u);
      return;
  }
  catch (IOException i) {
      System.out.println(i);
      return;
  }
}
// the read_and_parse() function tries to read the bytes from the InputStream object
void read_and_parse() {
  int data_len;
  int num_hands;
  int num_landmarks;
  try {
    byte[] len_buffer = new byte[4];
    byte[] num_hand_buffer = new byte[1];
    byte[] num_landmark_buffer = new byte[1];
    
    is.read(len_buffer, 0, 4);
    is.read(num_hand_buffer, 0, 1);
    is.read(num_landmark_buffer, 0, 1);
    
    data_len = ByteBuffer.wrap(len_buffer).getInt();
    num_hands = Byte.toUnsignedInt(num_hand_buffer[0]);
    num_landmarks = Byte.toUnsignedInt(num_landmark_buffer[0]);
    
    // read in the actual hand data
    byte[] data_buffer = new byte[data_len];
    is.read(data_buffer, 0, data_len);
    
    String data = new String(data_buffer, 0, data_len);
    coords = new Vector<float[]>();
    
    // parses the hand data packet using the delimiters "@" to seperate the coordinates, and ":" to seperate the two components of each coordinate
    String[] delimited_coords = data.split("@");
    for (int i = 0; i < num_landmarks -1; i++) {
      String[] p = delimited_coords[i].split(":");
      if (p.length == 2) {
        float[] c = {width - width * float(p[0]), height * float(p[1])};
        coords.add(c);
      }
    }
  } catch (IOException i) {
    System.out.println(i);
  }
} 
float R = 200;
void draw() {
  try {
    if (is.available() > 0) {
      background(0);
      read_and_parse();
      // THIS IS WHERE THE DISPLAY FUNCTIONS SHOULD GO
      // the twist function uses the distance between each hand to determine the diameter of a mandalic form
      twist();       
    }
  } catch (IOException i) {
      System.out.println(i);
      return;
  }
}

void twist() {
// there are 21 landmarks per hand (no less, it recognizes either all 21 or nothing
// so if coords has more than 21 elements, that means it sees 2 hands, I don't have it do anything if it sees only one hand
  if (coords.size() > 21) {
    // use the distance between each hand to determine the diameter
    float d = dist(coords.get(0)[0], coords.get(0)[1], coords.get(30)[0], coords.get(30)[1]) / 5;
    translate(width / 2, height / 2);
    for (int a = 0; a < 360; a+= d/5) {
      pushMatrix();
      rotate(radians(a));
      for (int b = 0; b < 180; b += d/5) {
        line(sin(radians(b)) * d, cos(radians(b)) * d, sin(radians(-b)) * d, cos(radians(-b)) * d );
      }
      popMatrix();
    }
    // in case you want to send the final diameter to another function -to preserve the visual continuity
    R = d;
  }
}
