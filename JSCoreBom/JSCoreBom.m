//
//  JSCoreBom.m
//  JSCoreBom
//
//  Created by fessguid on 21/11/14.
//  Copyright (c) 2014 fessguid. All rights reserved.
//

#import "JSCoreBom.h"


@implementation JSCoreBom

+(instancetype)shared
{
    static dispatch_once_t pred;
    static JSCoreBom* sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[JSCoreBom alloc] init];
    });
    return sharedInstance;
}

-(void)extend:(JSContext*)context
{
    context[@"setTimeout"] = ^(JSValue* function, JSValue* timeout) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)([timeout toInt32] * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
            [function callWithArguments:@[]];
        });
    };
}
@end
