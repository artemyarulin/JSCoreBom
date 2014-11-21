#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "JSCoreBom.h"
#import "AGWaitForAsyncTestHelper.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface JSCoreBomTests : XCTestCase

@end

@implementation JSCoreBomTests
{
    JSContext* context;
}

-(void)testSetTimeout
{
    [context evaluateScript:@"var flag=false; setTimeout(function(){ flag=true },1000)"];
    XCTAssertFalse([[context evaluateScript:@"flag"] toBool],@"Flag should be true by default");
    [self sleepWithoutBlocking:2000];
    XCTAssertTrue([[context evaluateScript:@"flag"] toBool],@"Flag has to be set to true");
}

-(void)setUp
{
    context = [[JSContext alloc] init];
    [[JSCoreBom shared] extend:context];
}

-(void)sleepWithoutBlocking:(float)ms
{
    __block BOOL isDone = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(ms * USEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
        isDone = YES;
    });
    WAIT_WHILE(!isDone, 30);
}

@end
