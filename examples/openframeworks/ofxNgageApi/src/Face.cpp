//
//  Face.cpp
//  SimpleExample
//
//  Created by Daan Krijnen on 27/10/16.
//
//

#include "Face.h"


Face::Face(ofxOscMessage m){
    update(m);
}

void Face::update(ofxOscMessage m){
    
    id                = m.getArgAsInt(0);
    gid               = m.getArgAsInt(1);
    centerPos.x       = m.getArgAsFloat(2);
    centerPos.y       = m.getArgAsFloat(3);
    boundingBox.x     = m.getArgAsFloat(4);
    boundingBox.y     = m.getArgAsFloat(5);
    boundingBox.width  = m.getArgAsFloat(6);
    boundingBox.height = m.getArgAsFloat(7);
    velocity.x        = m.getArgAsFloat(8);
    velocity.y        = m.getArgAsFloat(9);
    acceleration.x    = m.getArgAsFloat(10);
    acceleration.y    = m.getArgAsFloat(11);
    lastSeen = ofGetElapsedTimeMillis();
    
}

bool Face::isAlive(){
    if(ofGetElapsedTimeMillis() - lastSeen > MAX_TIME_FACE) {
        return false;
    } else return true;
    
}