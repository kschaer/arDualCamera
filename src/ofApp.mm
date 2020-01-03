#include "ofApp.h"
//--------------------------------------------------------------
ofApp :: ofApp (ARSession * session){
    // create a world tracking config, but set face tracking to true.
    // enables face tracking while using rear camera.
    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];
    configuration.userFaceTrackingEnabled = true;
    [session runWithConfiguration:configuration];
    
    this->session = session;
    cout << "creating ofApp" << endl;
}

ofApp::ofApp(){}

//--------------------------------------------------------------
ofApp :: ~ofApp () {
    cout << "destroying ofApp" << endl;
}

void ofApp::printInfo() {
    
    string infoString = std::string("touchX: " + std::to_string(touchX) + "\n touchY: " + std::to_string(touchY));
//    std::string infoString = std::string("Current mode: ") + std::string(bDrawTriangles ? "mesh triangles" : "circles");
//    infoString += "\nNormals: " + std::string(bDrawNormals ? "on" : "off");
//    infoString += std::string("\n\nTap right side of the screen to change drawing mode.");
//    infoString += "\nTap left side of the screen to toggle normals.";
//    verandaFont.drawString(infoString, 10, ofGetHeight() * 0.85);
    debugFont.drawString(infoString, 10, ofGetHeight() * 0.85);
}

//--------------------------------------------------------------
void ofApp::setup(){	
    ofBackground(127);
    ofSetColor(255);
    ofSetFrameRate(60);
    ofEnableDepthTest();

    int fontSize = 8;
    if (ofxiOSGetOFWindow()->isRetinaSupportedOnDevice()){
        fontSize *= 2;
    }

    processor = ARProcessor::create(session);
    processor->setup();
    
    debugFont.load("fonts/mono0755.ttf", 30);
    ofSetFrameRate(60);
}

//--------------------------------------------------------------
void ofApp::update(){
    processor->update();
    processor->updateFaces();
}
// ------------------------------------------------------------- helpers --------
void drawFaceCircles(ofMesh faceMesh) {
    auto verts = faceMesh.getVertices();
    for (int i = 0; i < verts.size(); ++i){
        ofDrawCircle(verts[i] * ofVec3f(1, 1, 1), 0.002);
    }
}

//--------------------------------------------------------------
void ofApp::draw(){
	ofDisableDepthTest();
    processor->draw();
    
    camera.begin();
    processor->setARCameraMatrices();
    
    auto allFaces = processor->getFaces();
    
    if(allFaces.size() > 0){
        cout << "FOUND A FACE" << endl;
        auto face = allFaces[0];
        
//        ofFill();
//        if(face.raw && face.raw.transform){
//
//
//        }
//        if(face.raw.transform !== nullptr){
            ofMatrix4x4 temp = ofxARKit::common::toMat4(face.raw.transform);

            ofPushMatrix();
            ofMultMatrix(temp);
            
            ofScale(1.5, 1.5);

            mesh.addVertices(face.vertices);
            mesh.addTexCoords(face.uvs);
            mesh.addIndices(face.indices);
            
//
//        ofR(0, touchY,touchX,1);
//        ofRotateYDeg(touchY);
        ofRotateZDeg(touchX);

            ofTranslate(0,0,1);
        
            drawFaceCircles(mesh);

            ofPopMatrix();
//        }


        mesh.clear();
        
        
        
        //---------------------------------------------------------------------
//        processor->anchorController->loopAnchors([=](ARObject obj)->void {
//
//            camera.begin();
//    //        processor->setARCameraMatrices();
//
//            ofPushMatrix();
//            ofMultMatrix(obj.modelMatrix);
//
//            ofRotate(90,0,0,1);
//
//            ofDrawSphere(0, 0, 1);
//
//            drawFaceCircles(mesh);
//
//
//            ofPopMatrix();
//            camera.end();
//        });
    }
    
    camera.end();
    
    printInfo();

    
//    mesh.clear();


//    for (auto & face : processor->getFaces()){
//        ofFill();
//
//        ofMatrix4x4 temp = ofxARKit::common::toMat4(face.raw.transform);
//
//        ofPushMatrix();
//        ofMultMatrix(temp);
//
//        mesh.addVertices(face.vertices);
//        mesh.addTexCoords(face.uvs);
//        mesh.addIndices(face.indices);
//
//        drawFaceCircles(mesh);
//
//        mesh.clear();
//
//        ofPopMatrix();
//    }
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    processor->addAnchor(ofVec3f(touch.x,touch.y,-0.2));
//    processor->a
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    touchX = ofMap(touch.x, 0, ofGetWidth(), 0, 360);
    touchY = ofMap(touch.y, 0, ofGetWidth(), 0, 360);
}
 
//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){

}

//--------------------------------------------------------------
void ofApp::gotFocus(){

}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){

}
