#pragma once
#include "ofMain.h"
#include "ofxOscMessage.h"
#include "ofxOsc.h"

#define MAX_TIME_BLOB 200

class Blob {
    
public:
    Blob(ofxOscMessage m);
    int id, gid;
    ofVec2f centerPos, velocity, acceleration;
    ofRectangle boundingBox;
    vector<ofVec2f> contours;
    void update(ofxOscMessage m);
    bool isAlive();
    int lastSeen;
};