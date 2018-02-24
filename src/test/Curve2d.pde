import java.lang.Math;

class Curve2d {
  PVector[] points;
  boolean closed;
  float factor;

  Curve2d(boolean closed) {
    this.closed = closed;
    points = new PVector[0];
    factor = 1.0/3.0;
  }

  void addPoint(float x, float y) {
    int len = points.length;
    points = (PVector[]) expand(points, len+1);
    points[len] = new PVector(x, y);
  }

  PVector[] _getControlPoints(int segment) {
  	PVector[] controls = new PVector[4];
  	
  	// if not enough points, return void array
  	if (points.length < 2) {
  		for (int i = 0; i < 4; i++) {
  			controls[i] = new PVector(0, 0);
  		}
  		return controls;
  	}

    // compute indexes
    int len = points.length;
    int i0 = (segment-1+len)%len;
    int i1 = (i0+1)%len;
    int i2 = (i1+1)%len;
    int i3 = (i2+1)%len;
    if (!closed && i1 == 0) {
      i0 = i1;
    } 
    if (!closed && i2 == len-1) {
      i3 = i2;
    }

    // compute first control point
    PVector d0 = PVector.sub(points[i0], points[i1]);
    PVector d1 = PVector.sub(points[i2], points[i1]);
    PVector t0;
    if (d0.mag() == 0.0) {
      t0 = PVector.mult(d1, factor).add(points[i1]);
    } else {
      t0 = PVector.add(d0, d1).normalize().rotate(HALF_PI);
      t0.mult(Math.signum(t0.dot(d0)*factor)).add(points[i1]);
    }
    
    // compute second control point
    PVector d2 = PVector.sub(points[i1], points[i2]);
    PVector d3 = PVector.sub(points[i3], points[i2]);
    PVector t1;
    if (d3.mag() == 0.0) {
      t1 = PVector.mult(d2, (-factor)).add(points[i2]);
    } else {
      t1 = PVector.add(d2, d3).normalize().rotate(HALF_PI);
      t1.mult(Math.signum(t1.dot(d2)*factor)).add(points[i2]);
    }

    // fill array
    controls[0] = points[i1];
    controls[1] = t0;
    controls[2] = t1;
    controls[3] = points[i2];

    for (int i=0; i<4;i++) {
      println("p"+i+"=("+controls[i].x+", "+controls[i].y+")");
    }

    return controls;
  }

  void _drawSegment(int segment) {
    PVector[] c = _getControlPoints(segment);
    bezier(c[0].x, c[0].y, c[1].x, c[1].y, c[2].x, c[2].y, c[3].x, c[3].y);
  }

  void draw() {
    noFill();
    stroke(0, 0, 0);
    for (int segment=0; segment < points.length; segment++) {
      _drawSegment(segment);
    }
  }

  void print() {
    for (int i = 0; i < points.length; i++) {
      println(i + ": " + points[i].x + ", " + points[i].y);
    }
  }
}

