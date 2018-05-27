//
//  ofxDateComponents.h
//
//  Created by ISHII 2bit on 2018/05/27.
//

#ifndef ofxDateComponents_h
#define ofxDateComponents_h

#include <cstdint>

namespace ofx {
    struct DateComponents {
        DateComponents();
        
        std::int64_t year;
        std::int64_t month;
        std::int64_t day;
        
        std::int64_t hour;
        std::int64_t minute;
        std::int64_t second;
        
        std::int64_t nanosecond;
    };
};

using ofxDateComponents = ofx::DateComponents;

#endif /* ofxDateComponents_h */
