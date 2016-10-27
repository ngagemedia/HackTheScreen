#pragma once
#include "ofMain.h"
#include "ofxOscMessage.h"
#include "ofxOsc.h"

#define MAX_TIME_FACE 100

class Face {
    
public:
    Face(ofxOscMessage m);
    int id, gid;
    ofVec2f centerPos, velocity, acceleration;
    ofRectangle boundingBox;
    
    void update(ofxOscMessage m);
    bool isAlive();
    int lastSeen;
};