//
//  ofxAlertController.h
//
//  Created by ISHII 2bit on 2018/05/26.
//

#ifndef ofxAlertController_h
#define ofxAlertController_h

#include <string>
#include <vector>
#include <functional>
#include <iostream>

namespace ofx {
    enum class AlertActionType {
        Default,
        Cancel,
        Destructive
    };
    
    struct AlertActionSetting {
        AlertActionSetting(const std::string &title,
                           AlertActionType type,
                           std::function<void()> handler = []{})
        : title(title)
        , type(type)
        , handler(handler) {};
        
        std::string title{"Action"};
        AlertActionType type{AlertActionType::Default};
        std::function<void()> handler{[]{}};
    };
    
    enum class AlertControllerStyle {
        ActionSheet,
        Alert
    };
    
    struct AlertController {
        AlertController() = default;
        AlertController(const std::string &title,
                        const std::string &message,
                        AlertControllerStyle style,
                        const std::vector<AlertActionSetting> &actions = {});
        void setup(const std::string &title,
                   const std::string &message,
                   AlertControllerStyle style,
                   const std::vector<AlertActionSetting> &actions = {});
        AlertController &addAction(const AlertActionSetting &setting);
        AlertController &addAction(const std::string &title,
                                   AlertActionType type,
                                   std::function<void()> handler);
        void show();
    private:
        void *controller;
    };
};

using ofxAlertActionType = ofx::AlertActionType;
using ofxAlertActionSetting = ofx::AlertActionSetting;
using ofxAlertControllerStyle = ofx::AlertControllerStyle;
using ofxAlertController = ofx::AlertController;

void ofxShowAlert(std::string title,
                  std::string message,
                  const std::vector<ofxAlertActionSetting> &actions);
void ofxShowActionSheet(std::string title,
                        std::string message,
                        const std::vector<ofxAlertActionSetting> &actions);

#endif /* ofxAlertController_h */
