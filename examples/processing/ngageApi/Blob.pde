class Blob {
  int id, gid;
  PVector centerPos, velocity, acceleration;
  Rectangle boundingBox;
  ArrayList<PVector> contours;
  int lastSeen;
  Blob(OscMessage theOscMessage) {
    lastSeen = millis();
    centerPos = new PVector();
    boundingBox = new Rectangle();
    velocity = new PVector();
    acceleration = new PVector();
    contours     = new ArrayList<PVector>();
    update(theOscMessage);
  }

  void update(OscMessage theOscMessage) {
    id                = theOscMessage.get(0).intValue();
    gid               = theOscMessage.get(1).intValue();
    centerPos.x       = theOscMessage.get(2).floatValue()*width;
    centerPos.y       = theOscMessage.get(3).floatValue()*height;
    boundingBox.x     = theOscMessage.get(4).floatValue()*width;
    boundingBox.y     = theOscMessage.get(5).floatValue()*height;
    boundingBox.w     = theOscMessage.get(6).floatValue()*width;
    boundingBox.h     = theOscMessage.get(7).floatValue()*height;
    velocity.x        = theOscMessage.get(8).floatValue();
    velocity.y        = theOscMessage.get(9).floatValue();
    acceleration.x    = theOscMessage.get(10).floatValue();
    acceleration.y    = theOscMessage.get(11).floatValue();
    contours.clear();
    for (int i = 12; i < theOscMessage.arguments().length; i += 2) {
      PVector point = new PVector();
      point.x = theOscMessage.get(i).floatValue()*width;
      point.y = theOscMessage.get(i + 1).floatValue()*width;
      contours.add(point);
    }

    lastSeen = millis();
  }

  boolean isAlive() {
    if (millis() - lastSeen > 300) {
      return false;
    } else {
      return true;
    }
  }
  
  void drawContours(){
    stroke(255,100);
    beginShape();
    for (int i=0; i < contours.size(); i++){
      PVector pt = contours.get(i);
      vertex(pt.x, pt.y);
    }
    endShape();
  }
}