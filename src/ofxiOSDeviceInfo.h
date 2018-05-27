//
//  ofxiOSDeviceInfo.h
//
//  Created by ISHII 2bit on 2018/05/27.
//

#ifndef ofxiOSDeviceInfo_h
#define ofxiOSDeviceInfo_h

#include <string>
#include <functional>

namespace ofx {
    namespace iOSDevice {
        enum class BatteryState {
            Unknown,
            Unplugged,
            Charging,
            Full
        };
        enum class UserInterfaceIdiom {
            Unspecified = -1,
            Phone,
            Pad,
            TV,
            CarPlay,
        };
    }
}

using ofxiOSDeviceBatteryState = ofx::iOSDevice::BatteryState;
using ofxiOSDeviceUserInterfaceIdiom = ofx::iOSDevice::UserInterfaceIdiom;

std::string ofxGetiOSDeviceName();
std::string ofxGetiOSDeviceSystemName();
std::string ofxGetiOSDeviceSystemVersion();
std::string ofxGetiOSDeviceModel();
std::string ofxGetIOSDeviceIdentifierForVendor();
ofxiOSDeviceUserInterfaceIdiom ofxGetIOSDeviceUserInterfaceIdiom();

float ofxGetiOSDeviceBatteryLevel();
ofxiOSDeviceBatteryState ofxGetiOSDeviceBatteryState();
void ofxRegisterBatteryLevelDidChangeCallback(const std::string &key,
                                              std::function<void(float)> callback);
void ofxRegisterBatteryStateDidChangeCallback(const std::string &key,
                                              std::function<void(ofxiOSDeviceBatteryState)> callback);

bool ofxGetProximityState();
bool ofxGetProximityMonitoringEnabled();
void ofxSetProximityMonitoringState(bool state);
void ofxRegisterProximityStateDidChangeCallback(const std::string &key,
                                                std::function<void(bool)> callback);

#endif /* ofxiOSDeviceInfo_h */
