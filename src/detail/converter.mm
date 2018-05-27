//
//  converter.mm
//
//  Created by ISHII 2bit on 2018/05/27.
//

#include "converter.h"

NSString *to_objc(const std::string &str) {
    return [NSString stringWithUTF8String:str.c_str()];
};

const char *to_cpp(NSString *str) {
    return str.UTF8String;
}
