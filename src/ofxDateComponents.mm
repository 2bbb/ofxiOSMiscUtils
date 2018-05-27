//
//  ofxDateComponents.mm
//
//  Created by ISHII 2bit on 2018/05/27.
//

#import <Foundation/Foundation.h>

#include "ofxDateComponents.h"

namespace ofx {
    DateComponents::DateComponents() {
        NSDateComponents *components = NSDateComponents.alloc.init;
        year = components.year;
        month = components.month;
        day = components.day;
        
        hour = components.hour;
        minute = components.minute;
        second = components.second;
        
        nanosecond = components.nanosecond;
    };
};
