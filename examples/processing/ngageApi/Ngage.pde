import oscP5.*;
import netP5.*;
import java.net.InetAddress;

class Ngage {
  OscP5 oscP5;
  ArrayList<Blob> blobs = new ArrayList<Blob>();
  ArrayList<Face> faces = new ArrayList<Face>();
  String BaseAddress;
  NetAddress hackTheScreenAPI;

  Ngage() {
    oscP5 = new OscP5(this, 7004);
    hackTheScreenAPI = new NetAddress("192.168.7.5", 7004);
    BaseAddress = "/ImageProcessing";
    
    initNgageAPI();
  }
  
  void initNgageAPI() {
  OscMessage myMessage = new OscMessage("/OSC/AddClientIP");
  String myIp;
  int[] ipList;

  try {
    InetAddress address = InetAddress.getLocalHost();
    myIp = address.getHostAddress();
    ipList =  int(split(myIp, '.'));
    myMessage.add(ipList[0]);
    myMessage.add(ipList[1]);
    myMessage.add(ipList[2]);
    myMessage.add(ipList[3]);
    //myMessage.add(192);
    //myMessage.add(168);
    //myMessage.add(7);
    //myMessage.add(247);
    oscP5.send(myMessage, hackTheScreenAPI);
  } 
  catch (Exception e) {
    println("no ip?");
  }
}

public void updateBlobs(OscMessage theMessage) {
  int counter = 0;
  for (int i = 0; i < blobs.size(); i++ ) {
    //update centerPos
    Blob b = blobs.get(i);
    if (theMessage.get(0).intValue() == b.id) {
      b.update(theMessage);
    } else {
      if (!b.isAlive()) { 
        blobs.remove(i);
      } else {
        counter++;
      }
    }
  }
  if (counter == blobs.size()) {
    //println("new blob!");
    blobs.add(new Blob(theMessage));
  }
}

public void updateFaces(OscMessage theMessage) {
  int counter = 0;
  for (int i = 0; i < blobs.size(); i++ ) {
    //update centerPos
    Face f = faces.get(i);
    if (theMessage.get(0).intValue() == f.id) {
      f.update(theMessage);
    } else {
      if (!f.isAlive()) { 
        faces.remove(i);
      } else {
        counter++;
      }
    }
  }
  if (counter == blobs.size()) {
    //println("new blob!");
    faces.add(new Face(theMessage));
  }
}

void oscEvent(OscMessage theOscMessage) {
    if (theOscMessage.checkAddrPattern(BaseAddress+"Blobs/BlobData") == true) {
      //ImageProcessing Blob Message received
      updateBlobs(theOscMessage);
    }
    if (theOscMessage.checkAddrPattern(BaseAddress+"Faces/FaceData") == true) {
      //ImageProcessing Face Message received
      updateFaces(theOscMessage);
    }
      
    /* print the address pattern and the typetag of the received OscMessage */
    println("### received an osc message.");
    println("### addrpattern\t"+theOscMessage.addrPattern());
    println("### typetag\t"+theOscMessage.typetag());
    }
}