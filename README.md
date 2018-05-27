# ofxiOSMiscUtils

thin wrapper of UIKit APIs

## ofxiOSDeviceInfo

### about info

* `std::string ofxGetiOSDeviceName();`
* `std::string ofxGetiOSDeviceSystemName();`
* `std::string ofxGetiOSDeviceSystemVersion();`
* `std::string ofxGetiOSDeviceModel();`
* `std::string ofxGetIOSDeviceIdentifierForVendor();`
* `ofxiOSDeviceUserInterfaceIdiom ofxGetIOSDeviceUserInterfaceIdiom();`

### about battery

* `float ofxGetiOSDeviceBatteryLevel();`
* `ofxiOSDeviceBatteryState ofxGetiOSDeviceBatteryState();`
* `void ofxRegisterBatteryLevelDidChangeCallback(std::string key, std::function<void(float)> callback);`
* `void ofxRegisterBatteryStateDidChangeCallback(std::string key, std::function<void(ofxiOSDeviceBatteryState)> callback);`

### about proximity sensor

* `bool ofxGetProximityState();`
* `bool ofxGetProximityMonitoringEnabled();`
* `void ofxSetProximityMonitoringState(bool state);`
* `void ofxRegisterProximityStateDidChangeCallback(std::string key, std::function<void(bool)> callback);`

## ofxAlertController

* `ofxShowAlert(std::string title, std::string message, ofxAlertControllerStyle style, std::vector<ofxAlertActionSetting> action)`
* `ofxShowActionSheet(std::string title, std::string message, ofxAlertControllerStyle style, std::vector<ofxAlertActionSetting> action)`

## ofxUserNotifications

* `void ofxRegisterUserNotification(ofxUserNotificationsAuthorizationOptions options);`
* `ofxUserNotificationsSettings ofxGetUserNotificationsSettings();`
* `void ofxAddNotification(ofxUserNotificationsContent context, ofxDateComponents date, bool repeats);`
* `void ofxAddNotification(ofxUserNotificationsContent context, float interval, bool repeats);`
* `std::vector<ofxUserNotificationsRequest> ofxGetPendingNotificationRequests();`
* `std::vector<ofxUserNotificationsDeliveredNotification> ofxGetDeliveredNotifications(); `

## Update history

### 2018/05/26 ver 0.0.1

## License

MIT License.

## Author

* ISHII 2bit
* i[at]2bit.jp

## At the last

Please create a new issue if there is a problem.

And please throw a pull request if you have a cool idea!!

If you get happy with using this addon, and you're rich, please donation for support continuous development.

Bitcoin: `17AbtW73aydfYH3epP8T3UDmmDCcXSGcaf`

