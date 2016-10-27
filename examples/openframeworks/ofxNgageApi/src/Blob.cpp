//
//  Blob.cpp
//  SimpleExample
//
//  Created by Daan Krijnen on 27/10/16.
//
//

#include "Blob.h"


Blob::Blob(ofxOscMessage m){
    update(m);
}

void Blob::update(ofxOscMessage m){
    
    id                = m.getArgAsInt(0);
    gid               = m.getArgAsInt(1);
    centerPos.set(m.getArgAsFloat(2), m.getArgAsFloat(3));
    boundingBox.set(m.getArgAsFloat(4), m.getArgAsFloat(5), m.getArgAsFloat(6), m.getArgAsFloat(7));
    velocity.set(m.getArgAsFloat(8), m.getArgAsFloat(9));
    acceleration.set(m.getArgAsFloat(10), m.getArgAsFloat(11));
    contours.clear();
    for (int i = 12; i < m.getNumArgs(); i += 2) {
        ofVec2f point;
        point.set(m.getArgAsFloat(i),m.getArgAsFloat(i+1));
        contours.push_back(point);
    }
    lastSeen = ofGetElapsedTimeMillis();
}

bool Blob::isAlive(){
    if((ofGetElapsedTimeMillis() - lastSeen) > MAX_TIME_BLOB) {
        return false;
    } else return true;
    
}