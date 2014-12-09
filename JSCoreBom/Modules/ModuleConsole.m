#import "ModuleConsole.h"

@implementation ModuleConsole
{
    JSValue* logWrapper;
    void (^_logHandler)(NSString*,NSArray*);
}

-(instancetype)initWithLogHandler:(void (^)(NSString*,NSArray*))logHandler
{
    if (self = [super init])
    {
        _logHandler = logHandler;
    }
    return self;
}

-(JSValue*)log
{
    if (!logWrapper)
        logWrapper = [[JSContext currentContext] evaluateScript:@"c = function() { console.__write('log', Array.prototype.slice.call(arguments, 0)) }"];

    return logWrapper;
}

-(void)__write:(NSString*)logLevel :(NSArray*)params
{
    if (_logHandler)
        _logHandler(logLevel,params);
    else
    {
        if (params.count == 0)
            return;
        else if (params.count == 1)
            NSLog(@"%@",params[0]);
        else if (![params[0] isKindOfClass:NSString.class] ||
                 ![((NSString*)params[0]) containsString:@"%"])
            NSLog(@"%@",params);
        else
        {
            NSString* format = params[0];
            __block NSString* output = @"";
            NSMutableArray* formatParams = [[params subarrayWithRange:NSMakeRange(1, params.count-1)] mutableCopy];
            __block BOOL isOperator = NO;
            
            [format enumerateSubstringsInRange:NSMakeRange(0, format.length)
                                       options:NSStringEnumerationByComposedCharacterSequences
                                    usingBlock:^(NSString *symbol, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                if ([symbol isEqualToString:@"%"])
                    isOperator = YES;
                else if (isOperator)
                {
                    if ([symbol isEqualToString:@"s"] ||    // TODO: Should we actually implement format templates?
                        [symbol isEqualToString:@"d"] ||
                        [symbol isEqualToString:@"i"] ||
                        [symbol isEqualToString:@"f"] ||
                        [symbol isEqualToString:@"o"] ||
                        [symbol isEqualToString:@"O"] ||
                        [symbol isEqualToString:@"c"])
                        output = [output stringByAppendingFormat:@"%@", [formatParams firstObject]];
                    
                    [formatParams removeObjectAtIndex:0];
                    isOperator = NO;
                }
                else
                    output = [output stringByAppendingString:symbol];
            }];
            

            NSLog(@"%@ %@",output,formatParams.count ? formatParams : @"");
        }
    }
}


@end
