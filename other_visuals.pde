
//put a function call to any one of these functions under the read() function call inside of the draw() function, where twist() is.

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
