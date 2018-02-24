
class Area {
  PVector center;
  float r;

  Area(float x, float y, float radius) {
    center = new PVector(x, y);
    r = radius;
  }

  PVector getPoint() {
    PVector p;
    float d;

    while (true) {
      p = center.copy().add(PVector.random2D().mult(r));
      d = center.dist(p);
      if (d <= r) {
        break;
      }
    }

    return p;
  }
}

Area[] areas = new Area[3];

void setup() {
  areas[0] = new Area(50, 80, 5);
  areas[1] = new Area(20, 40, 2);
  areas[2] = new Area(80, 40, 2);

  colorMode(HSB, 100, 100, 100, 100);
  size(800, 800, P3D);
  background(100);
  smooth();
  noLoop();
}

void draw() {
  int num_points = 20000;
  int index = 0, new_index;
  PVector p;
  
  prepara();
  background(100);
  noFill();
  stroke(0, 100, 80, 1);
  strokeWeight(0.2);

  beginShape();
  int np = 0;
  while(np < num_points) {
    new_index  = int(random(0, 3));
    if (new_index != index) {
      p = areas[index].getPoint();
      curveVertex(p.x, p.y);
      index = new_index;
      np++;      
    }
  }
  endShape();
}
