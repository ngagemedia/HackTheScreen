#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    ngage.connect("192.168.7.247");
}

//--------------------------------------------------------------
void ofApp::update(){
    ngage.update();
}

//--------------------------------------------------------------
void ofApp::draw(){
    ofBackground(0);
    for(int i = 0; i < ngage.blobs.size() ; i++){
        drawBlob(ngage.blobs.at(i));
    }
}

void ofApp::drawBlob(Blob b){
    ofSetColor(255,40);
    int w = ofGetWidth();
    int h = ofGetHeight();
//   ofDrawRectangle(b.boundingBox.x*ofGetWidth(),b.boundingBox.y*ofGetHeight(),b.boundingBox.width*ofGetWidth(),b.boundingBox.height*ofGetHeight());
    ofDrawEllipse(b.centerPos.x*w, b.centerPos.y*h, 10, 10);
    
    ofBeginShape();
    for(int j = 0; j < b.contours.size(); j++){
        ofVec2f pt = b.contours.at(j);
        ofVertex(pt.x*w, pt.y*h);
    }
    ofEndShape();
    
    ofDrawBitmapString("id = "+ofToString(b.id), b.boundingBox.x*w, (b.boundingBox.y*h +b.boundingBox.height*h)+2);
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key){

}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){

}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){

}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseEntered(int x, int y){

}

//--------------------------------------------------------------
void ofApp::mouseExited(int x, int y){

}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h){

}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg){

}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo){ 

}
