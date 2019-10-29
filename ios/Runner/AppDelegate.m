#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "GoogleMaps/GoogleMaps.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
[GMSServices provideAPIKey:@"AIzaSyCeB6yv_f3t1OIqjCMU7-Dpn-CBB2aFcTo"];

[GeneratedPluginRegistrant registerWithRegistry:self];

  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
