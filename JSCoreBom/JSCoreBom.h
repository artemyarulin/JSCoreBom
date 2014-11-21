#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface JSCoreBom : NSObject

+(JSCoreBom*)shared;
-(void)extend:(JSContext*)context;

@end
