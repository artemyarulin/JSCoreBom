#import <JavaScriptCore/JavaScriptCore.h>

@protocol ExportConsole <JSExport>

@property JSValue* log;
@property JSValue* debug;
@property JSValue* error;
@property JSValue* info;
@property JSValue* warn;

-(void)__write:(NSString*)logLevel :(NSArray*)params;

@end

@interface ModuleConsole : NSObject <ExportConsole>

-(instancetype)initWithLogHandler:(void (^)(NSString*,NSArray*,NSString*))logHandler;

@end
