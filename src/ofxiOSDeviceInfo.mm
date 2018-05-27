//
//  ofxiOSDeviceInfo.mm
//
//  Created by ISHII 2bit on 2018/05/27.
//

#import <UIKit/UIKit.h>

#include "ofxiOS.h"
#include "ofxiOSDeviceInfo.h"

#include "detail/converter.h"

@interface DeviceNotificationHandler : NSObject {
    std::map<std::string, std::function<void(ofxiOSDeviceBatteryState)>> batteryStateCallbacks;
    std::map<std::string, std::function<void(float)>> batteryLevelCallbacks;
    std::map<std::string, std::function<void(bool)>> proximityStateCallbacks;
}

- (std::map<std::string, std::function<void(ofxiOSDeviceBatteryState)>> &)batteryStateCallbacks;
- (std::map<std::string, std::function<void(float)>> &)batteryLevelCallbacks;
- (std::map<std::string, std::function<void(bool)>> &)proximityStateCallbacks;

- (void)batteryStateDidChange:(NSNotification *)notification;
- (void)batteryLevelDidChange:(NSNotification *)notification;
- (void)proximityStateDidChange:(NSNotification *)notification;

@end

@implementation DeviceNotificationHandler

- (std::map<std::string, std::function<void(ofxiOSDeviceBatteryState)>> &)batteryStateCallbacks
{
    return batteryStateCallbacks;
}

- (std::map<std::string, std::function<void(float)>> &)batteryLevelCallbacks
{
    return batteryLevelCallbacks;
}

- (std::map<std::string, std::function<void(bool)>> &)proximityStateCallbacks
{
    return proximityStateCallbacks;
}
- (void)batteryStateDidChange:(NSNotification *)notification {
    
}

- (void)batteryLevelDidChange:(NSNotification *)notification {
    
}

- (void)proximityStateDidChange:(NSNotification *)notification {
    for(const auto &pair : proximityStateCallbacks) {
        pair.second(ofxGetProximityState());
    }
}

@end

DeviceNotificationHandler *getDeviceNotificationHandler() {
    static DeviceNotificationHandler *handler = nil;
    if(!handler) {
        handler = DeviceNotificationHandler.alloc.init;
        NSNotificationCenter *defaultCenter = NSNotificationCenter.defaultCenter;
        [defaultCenter addObserver:handler
                          selector:@selector(batterStatusDidChange:)
                              name:UIDeviceBatteryStateDidChangeNotification
                            object:nil];
        [defaultCenter addObserver:handler
                          selector:@selector(batterLevelDidChange:)
                              name:UIDeviceBatteryLevelDidChangeNotification
                            object:nil];
        [defaultCenter addObserver:handler
                          selector:@selector(proximityStateDidChange:)
                              name:UIDeviceProximityStateDidChangeNotification
                            object:nil];
    }
    return handler;
}

std::string ofxGetiOSDeviceName() {
    return to_cpp(UIDevice.currentDevice.name);
}

std::string ofxGetiOSDeviceSystemName() {
    return to_cpp(UIDevice.currentDevice.systemName);
}

std::string ofxGetiOSDeviceSystemVersion() {
    return to_cpp(UIDevice.currentDevice.systemVersion);
}

std::string ofxGetiOSDeviceModel() {
    return to_cpp(UIDevice.currentDevice.model);
}

std::string ofxGetIOSDeviceIdentifierForVendor() {
    return to_cpp(UIDevice.currentDevice.identifierForVendor.UUIDString);
}

ofxiOSDeviceUserInterfaceIdiom ofxGetIOSDeviceUserInterfaceIdiom() {
    return (ofxiOSDeviceUserInterfaceIdiom)UIDevice.currentDevice.userInterfaceIdiom;
}

float ofxGetiOSDeviceBatteryLevel() {
    return UIDevice.currentDevice.batteryLevel;
}

ofxiOSDeviceBatteryState ofxGetiOSDeviceBatteryState() {
    return (ofxiOSDeviceBatteryState)UIDevice.currentDevice.batteryState;
}

void ofxRegisterBatteryLevelDidChangeCallback(const std::string &key,
                                              std::function<void(float)> callback)
{
    getDeviceNotificationHandler().batteryLevelCallbacks[key] = callback;
}

void ofxRegisterBatteryStateDidChangeCallback(const std::string &key,
                                              std::function<void(ofxiOSDeviceBatteryState)> callback)
{
    getDeviceNotificationHandler().batteryStateCallbacks[key] = callback;
}

bool ofxGetProximityState() {
    return UIDevice.currentDevice.proximityState ? true : false;
}

bool ofxGetProximityMonitoringEnabled() {
    return UIDevice.currentDevice.isProximityMonitoringEnabled ? true : false;
}

void ofxSetProximityMonitoringState(bool state) {
    UIDevice.currentDevice.proximityMonitoringEnabled = state ? YES : NO;
}

void ofxRegisterProximityStateDidChangeCallback(const std::string &key,
                                                std::function<void(bool)> callback)
{
    getDeviceNotificationHandler().proximityStateCallbacks[key] = callback;
}
