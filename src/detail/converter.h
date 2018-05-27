//
//  converter.h
//
//  Created by ISHII 2bit on 2018/05/27.
//

#ifndef ofxiOSMiscUtils_converter_h
#define ofxiOSMiscUtils_converter_h

#import <Foundation/Foundation.h>

#include <string>

NSString *to_objc(const std::string &str);
const char *to_cpp(NSString *str);

#endif /* ofxiOSMiscUtils_converter_h */
