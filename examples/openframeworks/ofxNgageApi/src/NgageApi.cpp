//
//  NgageApi.cpp
//  SimpleExample
//
//  Created by Daan Krijnen on 27/10/16.
//
//

#include "NgageApi.h"

NgageApi::NgageApi(){
    
}

// connect to server
void NgageApi::connect(string myIp){
    ngageSender.setup(HOST, PORT);
    vector<string> ipStr;
    ofxOscMessage m;
    m.setAddress(CONNECT_ADR);
    
    // convert IP to ints for connect
    ipStr = ofSplitString(myIp, ".");
    for(int i = 0 ; i < ipStr.size() ; i++){
        m.addIntArg(ofToInt(ipStr.at(i)));
    }
    ngageSender.sendMessage(m, false);
    ngageReceiver.setup(PORT);
}

void NgageApi::update(){
    checkOscMessages();
}


void NgageApi::checkOscMessages(){
    
    while(ngageReceiver.hasWaitingMessages()){
        ofxOscMessage m;
        ngageReceiver.getNextMessage(m); //read message
        
        // check for blob or face data
        if(m.getAddress() == BLOB_ADR){
            updateBlobs(m);
        }
        else if(m.getAddress() == FACE_ADR){
            updateFaces(m);
        }
        
    }
}


void NgageApi::updateBlobs(ofxOscMessage m){
    int counter = 0;
    for(int i = 0; i < blobs.size() ; i++){

        if(blobs.at(i).id == m.getArgAsInt(0)){
            //we need to update the blob
            blobs.at(i).update(m);
        } else {
            //different blob
            //check if it's 'alive'
            if(!blobs.at(i).isAlive()){
                //delete the blob
                blobs.erase(blobs.begin()+i);
            } else {
                //blob is alive and kicking
                counter++;
            }
        }
    }
    if(counter == blobs.size()){
        //all blobs accounted for, nothing updated. This must be a new blob
        blobs.push_back(Blob(m));
    }
    
}

void NgageApi::updateFaces(ofxOscMessage m){
    int counter = 0;
    for(int i = 0; i < faces.size() ; i++){
        Face f = faces.at(i);
        if(m.getArgAsInt(0) == f.id){
            //we need to update the face
            f.update(m);
        } else {
            //different face
            //check if it's 'alive'
            if(!f.isAlive()){
                //delete the face
                faces.erase(faces.begin()+i);
            } else {
                //blob is alive and kicking
                counter++;
            }
        }
    }
    if(counter == faces.size()){
        //all faces accounted for, nothing updated. This must be a new face
        faces.push_back(Face(m));
    }
    
}
