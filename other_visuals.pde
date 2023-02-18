//put a function call to any one of these functions under the read_and_parse() function call inside of the draw() function, where twist() in the main program.

                                                                              // A SPIRAL
void spiral() {
  if (coords.size() > 21) {
    float d = dist(coords.get(0)[0], coords.get(0)[1], coords.get(30)[0], coords.get(30)[1]) / 5;
    translate(width / 2, height / 2);
    for (int i = 0; i < 100; i++) {
      fill(i * 10, 255 - i * 25, 255 - i * 10);
      scale(0.95);
      rotate(radians(d/5));
      rect(0, 0, 600, 600);
    }
  }
}
                                                                              // A BUNCH OF EYES LOOKING AT YOUR HAND
String orientation = "camera facing you";
int num_eyes = 50;
Vector<Eye> E = new Vector<Eye>();
void preload_objects() {
  //preload random eyes
  for (int i = 0; i < num_eyes; i++) {
    E.add(new Eye(int(random(width)), int(random(height)), int(random(360))));
  }
}
void eye_watch() {
  if (coords.size() > 0) {
    if (orientation.equals("camera facing you")) {
      for (int j = 0; j < num_eyes; j++) {
        E.get(j).update(int(coords.get(0)[0]), int(coords.get(0)[1]));
        E.get(j).display();
      }
    } else {
      for (int j = 0; j < num_eyes; j++) {
        E.get(j).update(width - int(coords.get(0)[0]), int(coords.get(0)[1]));
        E.get(j).display();
      }
    }
  }
}
class Eye {
  int x, y;
  int size;
  float angle = 0.0;
  Eye(int tx, int ty, int ts) {
    x = tx;
    y = ty;
    size = ts;
 }
  void update(int mx, int my) {
    angle = atan2(my-y, mx-x);
  }
  void display() {
    pushMatrix();
    translate(x, y);
    fill(255);
    ellipse(0, 0, size, size);
    rotate(angle);
    fill(0);
    ellipse(size/4, 0, size/2, size/2);
    popMatrix();
  }
}
