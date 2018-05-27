//
//  ofxUserNotifications.h
//
//  Created by ISHII 2bit on 2018/05/26.
//

#ifndef ofxUserNotifications_h
#define ofxUserNotifications_h

#include <type_traits>
#include <string>

#include "ofxDateComponents.h"

namespace ofx {
    namespace UserNotifications {
        enum class AuthorizationOptions {
            Badge   = (1 << 0),
            Sound   = (1 << 1),
            Alert   = (1 << 2),
            CarPlay = (1 << 3)
        };
        AuthorizationOptions operator|(AuthorizationOptions a, AuthorizationOptions b);
        
        // UNAuthorizationStatus
        enum class AuthorizationStatus {
            NotDetermined = 0,
            Denied,
            Authorized
        };
        
        // UNNotificationSetting
        enum class Status {
            NotSupported = 0,
            Disabled,
            Enabled
        };
        
        // UNAlertStyle
        enum class AlertStyle {
            None = 0,
            Banner,
            lert
        };
        
        // UNShowPreviesSetting
        enum class ShowPreviewsSetting {
            Always,
            WhenAuthenticated,
            Never
        };
        
        // UNNotificationSettings
        struct Settings {
            AuthorizationStatus authorizationsStatus;
            Status carPlayStatus;
            Status notificationCenterStatus;
            Status lockScreenSetting;
            
            Status alertStatus;
            AlertStyle alertStyle;
            Status badgeStatus;
            Status soundStatus;
            ShowPreviewsSetting showPreviewsSetting;
        };
        
        struct Content {
            std::string title{""};
            std::string subtitle{""};
            std::string body{""};
            std::uint64_t badge{0};
            bool useSound{false};
            
            std::string identifier{"cc.openframeworks.addons.ofxiOSMiscUtils.ofxUserNotifications.Content"};
            std::string categoryIdentifier{""};
        };
        
        struct Request {
            std::string identifier;
            Content content;
            void *impl;
        };
        
        struct DeliveredNotification {
            Request request;
            double timestamp;
            std::string dateString;
        };
    };
};

namespace ofxUserNotifications = ofx::UserNotifications;
namespace ofxUN = ofxUserNotifications;

using ofxUserNotificationsAuthorizationOptions = ofxUserNotifications::AuthorizationOptions;
using ofxUserNotificationsAlertStyle = ofxUserNotifications::AlertStyle;
using ofxUserNotificationsStatus = ofxUserNotifications::Status;
using ofxUserNotificationsSettings = ofxUserNotifications::Settings;
using ofxUserNotificationsShowPreviewsSetting = ofxUserNotifications::ShowPreviewsSetting;
using ofxUserNotificationsContent = ofxUserNotifications::Content;
using ofxUserNotificationsRequest = ofxUserNotifications::Request;
using ofxUserNotificationsDeliveredNotification = ofxUserNotifications::DeliveredNotification;

void ofxRegisterUserNotification(ofxUserNotificationsAuthorizationOptions options = ofxUserNotificationsAuthorizationOptions::Badge | ofxUserNotificationsAuthorizationOptions::Sound | ofxUserNotificationsAuthorizationOptions::Alert | ofxUserNotificationsAuthorizationOptions::CarPlay);

ofxUserNotificationsSettings ofxGetUserNotificationsSettings();

void ofxAddNotification(const ofxUserNotificationsContent &context,
                        const ofxDateComponents &date,
                        bool repeats = false);
void ofxAddNotification(const ofxUserNotificationsContent &context,
                        float interval,
                        bool repeats = false);

std::vector<ofxUserNotificationsRequest> ofxGetPendingNotificationRequests();
std::vector<ofxUserNotificationsDeliveredNotification> ofxGetDeliveredNotifications();

#endif /* ofxUserNotifications_h */
