//
//  AppDelegate.m
//  Edge Solitaire
//
//  Created by Greg Walker on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "LandingViewController.h"

#import <GameCircle/GameCircle.h>

@implementation AppDelegate

@synthesize window = _window;

/*
 Achievements:
 
 Lose at Kings in the Corner
 Win at Kings in the Corner
 Win on the first round
 Win with only kings on the board
 Win with the board full
 
 Lost at Royals on Edge
 Win at Royals on Edge
 Win on the first round
 Win with only face cards on the board
 Win with the board full
 Win with the corners occupied by single suits

 Clear all the nines
 
 */

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[GameCircle beginWithFeatures:@[AGFeatureAchievements] completionHandler:^(NSError* error)
	{
	}];

	NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
	NSObject *oldWon = [settings objectForKey:@"edgeGamesWon"];
	NSObject *oldPlayed = [settings objectForKey:@"edgeGamesPlayed"];
	if(oldWon != nil && oldPlayed != nil)
	{
		[settings setObject:oldWon forKey:@"edgeGamesWon_normal"];
		[settings setObject:oldPlayed forKey:@"edgeGamesPlayed_normal"];
		[settings removeObjectForKey:@"edgeGamesWon"];
		[settings removeObjectForKey:@"edgeGamesPlayed"];
	}
	
	[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
	
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	// Override point for customization after application launch.
	
	UINavigationController* nav = [[UINavigationController alloc] init];
	LandingViewController* vc = [[LandingViewController alloc] init];
	self.window.rootViewController = nav;
	[nav pushViewController:vc animated:NO];
	
	self.window.backgroundColor = [UIColor whiteColor];
	[self.window makeKeyAndVisible];

    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [GameCircle handleOpenURL:url
                   sourceApplication:sourceApplication];
}


 #pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
