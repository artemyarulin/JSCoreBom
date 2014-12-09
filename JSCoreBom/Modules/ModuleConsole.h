#import <JavaScriptCore/JavaScriptCore.h>

@protocol ExportConsole <JSExport>

@property JSValue* log;

-(void)__write:(NSString*)logLevel :(NSArray*)params;

@end

@interface ModuleConsole : NSObject <ExportConsole>

-(instancetype)initWithLogHandler:(void (^)(NSString*,NSArray*))logHandler;

@end
