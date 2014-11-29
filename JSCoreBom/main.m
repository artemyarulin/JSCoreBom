#import <UIKit/UIKit.h>
#import "JSCoreBom.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@end

@implementation AppDelegate

-(void)applicationDidBecomeActive:(UIApplication *)application
{
    JSContext* context = [[JSContext alloc] init];
    [[JSCoreBom shared] extend:context];
    
    // This is good place to start debugging session
    // [context evaluateScript:@""];
}

@end


int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
