//
//  Settings.m
//  Edge Solitaire
//
//  Created by Greg Walker on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Settings.h"

@implementation Settings

+(BOOL)isMuted
{
	return [[NSUserDefaults standardUserDefaults] boolForKey:@"muted"];
}
+(void)setIsMuted:(BOOL)muted
{
	[[NSUserDefaults standardUserDefaults] setBool:muted forKey:@"muted"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSInteger)edgeGamesPlayed
{
	return [[NSUserDefaults standardUserDefaults] integerForKey:@"edgeGamesPlayed"];
}
+(void)incrementEdgeGamesPlayed
{
	NSUserDefaults* settings = [NSUserDefaults standardUserDefaults];
	[settings setInteger:([settings integerForKey:@"edgeGamesPlayed"] + 1) forKey:@"edgeGamesPlayed"];
	[settings synchronize];
}

+(NSInteger)edgeGamesWon
{
	return [[NSUserDefaults standardUserDefaults] integerForKey:@"edgeGamesWon"];
}
+(void)incrementEdgeGamesWon
{
	NSUserDefaults* settings = [NSUserDefaults standardUserDefaults];
	[settings setInteger:([settings integerForKey:@"edgeGamesWon"] + 1) forKey:@"edgeGamesWon"];
	[settings synchronize];
}

@end
