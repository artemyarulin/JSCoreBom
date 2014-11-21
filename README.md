# JSCoreBOMObjectiveCBinding
JavaScriptCore is missing some things from BOM you get used to - setTimeout, XMLHttpRequest, etc. This projects extends JSContext with native implementation of **some** function of BOM using Objective-C

## How to use it?
Whenever you would like to extend JSContext with BOM function just use:
```
JSContext* context = [[JSContext alloc] init];
[JSCoreBom shared] extendContext:context]
```

Then just use it:
```
[context evaluateScript:@"setTimeout(function(){
    console.log('Hello in 5 seconds!')
},5000]
```

## What does it contain?

Name            | Description
---             | ---
setTimeout      | Implemented using dispatch_after
XmlHTTPRequest  | Using NSUrlSession 
console.log     | Would forward everything to NSLog

## How does it work?
Like Apple said to!
```
@interface JSExtensions: NSObject <JSBridge>
@end
@implementation JSExtensions
- (void)setTimeout:^(JSValue* function, JSValue* timeout) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)([timeout toInt32] * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
      [function callWithArguments:@[]];
    });
}

JSContext* context = [[JSContext alloc] init];
context[@"ext"] = [[JSExtensions alloc] init];

```

