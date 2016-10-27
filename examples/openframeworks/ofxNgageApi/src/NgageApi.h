#pragma once
#include "ofMain.h"
#include "ofxOsc.h"
#include "Blob.h"
#include "Face.h"

#define PORT 7004
#define HOST "192.168.7.5"
#define CONNECT_ADR "/OSC/AddClientIP"
#define BLOB_ADR "/ImageProcessing/Blobs/BlobData"
#define FACE_ADR "/ImageProcessing/Faces/FaceData"


class NgageApi {

public:
    NgageApi();
    vector<Blob> blobs;
    vector<Face> faces;
    
    void connect(string myIp);
    void update();

protected:
    
    ofxOscReceiver ngageReceiver;
    ofxOscSender ngageSender;
    void checkOscMessages();
    void updateBlobs(ofxOscMessage m);
    void updateFaces(ofxOscMessage m);
    
};