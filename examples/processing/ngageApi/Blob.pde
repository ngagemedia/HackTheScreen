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
    centerPos.x       = theOscMessage.get(2).floatValue();
    centerPos.y       = theOscMessage.get(3).floatValue();
    boundingBox.x     = theOscMessage.get(4).floatValue();
    boundingBox.y     = theOscMessage.get(5).floatValue();
    boundingBox.width  = theOscMessage.get(6).floatValue();
    boundingBox.height = theOscMessage.get(7).floatValue();
    velocity.x        = theOscMessage.get(8).floatValue();
    velocity.y        = theOscMessage.get(9).floatValue();
    acceleration.x    = theOscMessage.get(10).floatValue();
    acceleration.y    = theOscMessage.get(11).floatValue();
    contours.clear();
    for (int i = 12; i < theOscMessage.arguments().length; i += 2) {
      PVector point = new PVector();
      point.x = theOscMessage.get(i).floatValue();
      point.y = theOscMessage.get(i + 1).floatValue();
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
      if (pt != null)
        vertex(pt.x, pt.y);
    }
    endShape();
  }
}
