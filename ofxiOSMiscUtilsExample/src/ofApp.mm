#include "ofxiOS.h"
#include "ofxiOSMiscUtils.h"

class ofApp : public ofxiOSApp {
    void showAlert() {
        ofxAlertController controller;
        controller.setup("confirm", "send notification after 5sec", ofxAlertControllerStyle::Alert);
        controller.addAction("OK", ofxAlertActionType::Default, []{
            ofxUserNotificationsContent content;
            content.title = "yeah";
            content.subtitle = "oh yeah!";
            content.badge = 1;
            content.useSound = true;
            ofxAddNotification(content, 5.0f);
            ofLogNotice() << "OK";
        });
        controller.addAction("Canel", ofxAlertActionType::Cancel, []{  ofLogNotice() << "Cancel"; });
        controller.addAction("Trash", ofxAlertActionType::Destructive, []{  ofLogNotice() << "Trash"; });
        controller.show();
        
//        or
//        ofxShowAlert("title", "message", {{
//            {"OK", ofxAlertActionType::Default, []{ ofLogNotice() << "OK"; }},
//            {"Canel", ofxAlertActionType::Cancel, []{  ofLogNotice() << "Cancel"; }},
//            {"Trash", ofxAlertActionType::Destructive, []{  ofLogNotice() << "Trash"; }}
//        }});
    }
public:
    void setup() {
        ofxRegisterUserNotification();
        ofxGetUserNotificationsSettings();
    }
    void update() {}
    void draw() {
        ofBackground(0);
        ofSetColor(255);
        for(int i = 0; i < 10; i++) ofDrawCircle(ofRandomWidth(), ofRandomHeight(), ofRandom(5, 10));
    }
    void exit() {}
    
    void touchDown(ofTouchEventArgs & touch) {
    }
    void touchMoved(ofTouchEventArgs & touch) {}
    void touchUp(ofTouchEventArgs & touch) {}
    void touchDoubleTap(ofTouchEventArgs & touch) {
        showAlert();
    }
    void touchCancelled(ofTouchEventArgs & touch) {}
    
    void lostFocus() {}
    void gotFocus() {}
    void gotMemoryWarning() {}
    void deviceOrientationChanged(int newOrientation) {}
};


int main() {
    //  here are the most commonly used iOS window settings.
    //------------------------------------------------------
    ofiOSWindowSettings settings;
    settings.enableRetina = false; // enables retina resolution if the device supports it.
    settings.enableDepth = false; // enables depth buffer for 3d drawing.
    settings.enableAntiAliasing = false; // enables anti-aliasing which smooths out graphics on the screen.
    settings.numOfAntiAliasingSamples = 0; // number of samples used for anti-aliasing.
    settings.enableHardwareOrientation = false; // enables native view orientation.
    settings.enableHardwareOrientationAnimation = false; // enables native orientation changes to be animated.
    settings.glesVersion = OFXIOS_RENDERER_ES1; // type of renderer to use, ES1, ES2, ES3
    settings.windowMode = OF_FULLSCREEN;
    ofCreateWindow(settings);
    
    return ofRunApp(new ofApp);
}
