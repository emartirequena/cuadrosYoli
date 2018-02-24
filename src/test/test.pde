Curve2d curve;

void setup() {
  size(500, 500);
  smooth();
  noLoop();

  curve = new Curve2d(true);
  curve.addPoint(10, 10);
  curve.addPoint(10, 50);
  curve.addPoint(90, 90);
}

void draw() {
  prepara();
  noStroke();
  background(255);
  curve.draw();
}
