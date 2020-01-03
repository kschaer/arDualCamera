#pragma once

#include "ofxiOS.h"
#include <ARKit/ARKit.h>
#include "ofxARKit.h"

class ofApp : public ofxiOSApp {
	
    public:
        ofApp (ARSession * session);
        ofApp();
        ~ofApp ();
    
        void setup();
        void update();
        void draw();
        void exit();
	
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);

        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);
    
        void printInfo();
    
        vector < matrix_float4x4 > mats;
        vector<ARAnchor*> anchors;
        ofCamera camera;
        ofTrueTypeFont font;

        // ====== AR STUFF ======== //
        ARSession * session;
        ARRef processor;
    
        // ======= Drawing stuff ===== //
        ofMesh mesh;
    
        float touchX;
        float touchY;
    
        ofTrueTypeFont debugFont;


};


