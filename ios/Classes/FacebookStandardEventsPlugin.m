#import "FacebookStandardEventsPlugin.h"
#import <facebook_standard_events/facebook_standard_events-Swift.h>

@implementation FacebookStandardEventsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFacebookStandardEventsPlugin registerWithRegistrar:registrar];
}
@end
