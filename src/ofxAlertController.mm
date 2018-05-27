//
//  ofxAlertController.mm
//
//  Created by ISHII 2bit on 2018/05/26.
//

#import <UIKit/UIKit.h>

#include "ofxiOS.h"
#include "ofxAlertController.h"
#include "detail/converter.h"

UIAlertAction *to_objc(const ofxAlertActionSetting &setting_) {
    std::shared_ptr<ofxAlertActionSetting> setting = std::make_shared<ofxAlertActionSetting>(setting_);
    return [UIAlertAction actionWithTitle:to_objc(setting->title)
                                    style:(UIAlertActionStyle)setting->type
                                  handler:^(UIAlertAction *action) { setting->handler(); }];
}

namespace ofx {
    AlertController::AlertController(const std::string &title,
                                     const std::string &message,
                                     AlertControllerStyle style,
                                     const std::vector<AlertActionSetting> &actions)
    {
        setup(title, message, style, actions);
    }
    void AlertController::setup(const std::string &title,
                                const std::string &message,
                                AlertControllerStyle style,
                                const std::vector<ofxAlertActionSetting> &actions)
    {
        controller = [UIAlertController alertControllerWithTitle:(title == "") ? nil : to_objc(title)
                                                         message:(message == "" ) ? nil : to_objc(message)
                                                  preferredStyle:(UIAlertControllerStyle)style];
        for(const auto &action : actions) addAction(action);
    }
    
    AlertController &AlertController::addAction(const AlertActionSetting &setting) {
        [(UIAlertController *)controller addAction:to_objc(setting)];
        return *this;
    }
    AlertController &AlertController::addAction(const std::string &title,
                                                AlertActionType type,
                                                std::function<void()> handler)
    {
        addAction({title, type, handler});
        return *this;
    }
    void AlertController::show() {
        [ofxiOSGetViewController() presentViewController:(UIAlertController *)controller
                                                animated:YES
                                              completion:^{}];
    }
}

void ofxShowAlert(std::string title,
                  std::string message,
                  const std::vector<ofxAlertActionSetting> &actions)
{
    ofxAlertController(title, message, ofxAlertControllerStyle::Alert, actions).show();
}

void ofxShowActionSheet(std::string title,
                        std::string message,
                        const std::vector<ofxAlertActionSetting> &actions)
{
    ofxAlertController(title, message, ofxAlertControllerStyle::ActionSheet, actions).show();
}
