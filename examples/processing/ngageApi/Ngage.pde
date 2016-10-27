import oscP5.*; //<>// //<>//
import netP5.*;
import java.net.InetAddress;

class Ngage {
  OscP5 oscP5;
  ArrayList<Blob> blobs = new ArrayList<Blob>();
  ArrayList<Face> faces = new ArrayList<Face>();
  String BaseAddress;
  NetAddress hackTheScreenAPI;
  int maxLength;

  Ngage() {
    OscProperties myProperties = new OscProperties();
    // increase the datagram size to 10000 bytes
    // by default it is set to 1536 bytes
    myProperties.setDatagramSize(10000); 
    myProperties.setListeningPort(7004);
    
    
    hackTheScreenAPI = new NetAddress("192.168.7.5", 7004);
    myProperties.setRemoteAddress(hackTheScreenAPI);
    BaseAddress = "/ImageProcessing";

    oscP5 = new OscP5(this, myProperties);
    initNgageAPI();
  }

  void initNgageAPI() {
    OscMessage myMessage = new OscMessage("/OSC/AddClientIP");
    String myIp;
    int[] ipList;

    try {
      InetAddress address = InetAddress.getLocalHost();
      println(address);
      println(InetAddress.getLoopbackAddress());
      myIp = address.getHostAddress();
      println(myIp);
      ipList =  int(split(myIp, '.'));
      myMessage.add(ipList[0]);
      myMessage.add(ipList[1]);
      myMessage.add(ipList[2]);
      myMessage.add(ipList[3]);
      //myMessage.add(192);
      //myMessage.add(168);
      //myMessage.add(7);
      //myMessage.add(247);
      //oscP5.send(myMessage, hackTheScreenAPI);
      oscP5.send(myMessage);
    } 
    catch (Exception e) {
      println("no ip?");
    }
  }

  public void updateBlobs(OscMessage theMessage) {
    //println(theMessage);
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
    if (theOscMessage.checkAddrPattern(BaseAddress+"/Blobs/BlobData") == true) {
      //ImageProcessing Blob Message received
      updateBlobs(theOscMessage);
    }
    if (theOscMessage.checkAddrPattern(BaseAddress+"/Faces/FaceData") == true) {
      //ImageProcessing Face Message received
      updateFaces(theOscMessage);
      println(theOscMessage.typetag());
    }

    /* print the address pattern and the typetag of the received OscMessage */
    //println("### received an osc message.");
    //println("### addrpattern\t"+theOscMessage.addrPattern());
    //maxLength = max(theOscMessage.arguments().length,maxLength);
    //println(maxLength);
    
    //println("### typetag\t"+theOscMessage.typetag());
  }
}