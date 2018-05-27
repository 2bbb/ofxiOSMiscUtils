//
//  ofxUserNotifications.mm
//
//  Created by ISHII 2bit on 2018/05/26.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

#include "ofxiOS.h"
#include "ofxUserNotifications.h"

#include "detail/converter.h"

ofxUserNotificationsContent to_cpp(UNNotificationContent *content) {
    ofxUserNotificationsContent c;
    c.title = to_cpp(content.title);
    c.subtitle = to_cpp(content.subtitle);
    c.body = to_cpp(content.body);
    c.badge = content.badge ? content.badge.integerValue : 0;
    c.categoryIdentifier = to_cpp(content.categoryIdentifier);
    return c;
}

ofxUserNotificationsRequest to_cpp(UNNotificationRequest *request) {
    ofxUserNotificationsRequest req;
    req.content = to_cpp(request.content);
    req.content.identifier = to_cpp(request.identifier);
    req.impl = request;
    return req;
}

ofxUserNotificationsDeliveredNotification to_cpp(UNNotification *notification) {
    ofxUserNotificationsDeliveredNotification n;
    n.request = to_cpp(notification.request);
    n.timestamp = notification.date.timeIntervalSince1970;
    n.dateString = to_cpp(notification.date.description);
    return n;
}

namespace ofx {
    namespace UserNotifications {
        AuthorizationOptions operator|(AuthorizationOptions a, AuthorizationOptions b)
        {
            using int_t = typename std::underlying_type<AuthorizationOptions>::type;
            return static_cast<AuthorizationOptions>(static_cast<int_t>(a) | static_cast<int_t>(b));
        }
        
    }
}

void ofxRegisterUserNotification(ofxUserNotificationsAuthorizationOptions options) {
    UNUserNotificationCenter *center = UNUserNotificationCenter.currentNotificationCenter;
    [center requestAuthorizationWithOptions:static_cast<UNAuthorizationOptions>(options)
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              // Enable or disable features based on authorization.
                          }];
}

ofxUserNotificationsSettings ofxGetUserNotificationsSettings() {
    using namespace ofxUN;
    
    __block UNNotificationSettings *settings = nil;
    UNUserNotificationCenter *center = UNUserNotificationCenter.currentNotificationCenter;
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings *settings_) {
        settings = settings_.copy;
    }];
    while(settings == nil);
    
    ofxUserNotificationsSettings setting;
    
    setting.alertStatus = (Status)settings.alertSetting;
    setting.alertStyle = (AlertStyle)settings.alertStyle;
    setting.badgeStatus = (Status)settings.badgeSetting;
    setting.soundStatus = (Status)settings.soundSetting;
    setting.carPlayStatus = (Status)settings.carPlaySetting;
    
    NSOperatingSystemVersion version = {11, 0, 0};
    BOOL isOSVersion11Later = [[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:version];
    if(isOSVersion11Later) setting.showPreviewsSetting = (ShowPreviewsSetting)[settings showPreviewsSetting];
    setting.notificationCenterStatus = (Status)settings.notificationCenterSetting;
    setting.lockScreenSetting = (Status)settings.lockScreenSetting;
    
    return setting;
}

namespace {
    void ofxAddNotification(const ofxUserNotificationsContent &content_,
                            UNNotificationTrigger *trigger)
    {
        UNMutableNotificationContent *content = UNMutableNotificationContent.alloc.init;
        content.title = content_.title == "" ? nil : to_objc(content_.title);
        content.subtitle = content_.subtitle == "" ? nil : to_objc(content_.subtitle);
        content.body = content_.body == "" ? nil : to_objc(content_.body);
        content.badge = @(content_.badge);
        if(content_.useSound) {
            content.sound = UNNotificationSound.defaultSound;
        }
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:to_objc(content_.identifier)
                                                                              content:content trigger:trigger];
        UNUserNotificationCenter *center = UNUserNotificationCenter.currentNotificationCenter;
        [center addNotificationRequest:request
                 withCompletionHandler:^(NSError * _Nullable error) {
                     if(error) ofLogError("ofxAddNotification") << to_cpp(error.description);
                 }];
    }
};

void ofxAddNotification(const ofxUserNotificationsContent &content,
                        const ofxDateComponents &date,
                        bool repeats)
{
    NSDateComponents *components = NSDateComponents.alloc.init;
    components.year = date.year;
    components.month = date.month;
    components.day = date.day;
    components.hour = date.hour;
    components.minute = date.minute;
    components.second = date.second;
    components.nanosecond = date.nanosecond;
    
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:repeats ? YES : NO];
    ofxAddNotification(content, trigger);
}

void ofxAddNotification(const ofxUserNotificationsContent &content,
                        float interval,
                        bool repeats)
{
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:interval repeats:repeats ? YES : NO];
    ofxAddNotification(content, trigger);
}

std::vector<ofxUserNotificationsRequest> ofxGetPendingNotificationRequests() {
    using namespace ofxUN;
    
    __block NSArray<UNNotificationRequest *> * _Nonnull requests = nil;
    UNUserNotificationCenter *center = UNUserNotificationCenter.currentNotificationCenter;
    [center getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests_) {
        requests = requests_.copy;
    }];
    while(requests == nil);
    
    std::vector<ofxUserNotificationsRequest> reqs;
    for(UNNotificationRequest *request in requests) {
        reqs.push_back(to_cpp(request));
    }
    return reqs;
}

std::vector<ofxUserNotificationsDeliveredNotification> ofxGetDeliveredNotifications() {
    using namespace ofxUN;
    
    __block NSArray<UNNotification *> * _Nonnull notifications = nil;
    UNUserNotificationCenter *center = UNUserNotificationCenter.currentNotificationCenter;
    [center getDeliveredNotificationsWithCompletionHandler:^(NSArray<UNNotification *> * _Nonnull notifications_) {
        notifications = notifications_.copy;
    }];
    while(notifications == nil);
    
    std::vector<ofxUserNotificationsDeliveredNotification> ns;
    for(UNNotification *notification in notifications) {
        ns.push_back(to_cpp(notification));
    }
    return ns;
}
