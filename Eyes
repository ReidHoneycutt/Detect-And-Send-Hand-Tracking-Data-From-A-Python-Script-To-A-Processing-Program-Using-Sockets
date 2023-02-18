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
