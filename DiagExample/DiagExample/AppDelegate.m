//
//  AppDelegate.m
//  DiagExample
//
//  Created by diag on 2023/12/19.
//

#import "AppDelegate.h"
#import "ViewController.h"
@import Diagnosis;
@import TDUIProvider;
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ViewController *vc = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Diag" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    [TDDUIConfig setupConfigWith:@"Theme_Diag.json" in:bundle imagePath:@"DiagImages"];
    return YES;
}



@end
