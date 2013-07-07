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
	NSInteger gamesPlayed = [Settings edgeGamesPlayedForMode:EdgeGameModeEasy];
	gamesPlayed += [Settings edgeGamesPlayedForMode:EdgeGameModeNormal];
	gamesPlayed += [Settings edgeGamesPlayedForMode:EdgeGameModeHard];
	
	return gamesPlayed;
}
+(NSInteger)edgeGamesPlayedForMode:(EdgeGameMode)mode
{
	NSString *key = [Settings getKey:@"edgeGamesPlayed" forMode:mode];
	return [[NSUserDefaults standardUserDefaults] integerForKey:key];
}
+(void)incrementEdgeGamesPlayedForMode:(EdgeGameMode)mode
{
	NSString *key = [Settings getKey:@"edgeGamesPlayed" forMode:mode];
	
	NSUserDefaults* settings = [NSUserDefaults standardUserDefaults];
	[settings setInteger:([settings integerForKey:key] + 1) forKey:key];
	[settings synchronize];
}

+(NSInteger)edgeGamesWon
{
	NSInteger gamesWon = [Settings edgeGamesWonForMode:EdgeGameModeEasy];
	gamesWon += [Settings edgeGamesWonForMode:EdgeGameModeNormal];
	gamesWon += [Settings edgeGamesWonForMode:EdgeGameModeHard];
	
	return gamesWon;
}
+(NSInteger)edgeGamesWonForMode:(EdgeGameMode)mode
{
	NSString *key = [Settings getKey:@"edgeGamesWon" forMode:mode];
	return [[NSUserDefaults standardUserDefaults] integerForKey:key];
}
+(void)incrementEdgeGamesWonForMode:(EdgeGameMode)mode
{
	NSString *key = [Settings getKey:@"edgeGamesWon" forMode:mode];

	NSUserDefaults* settings = [NSUserDefaults standardUserDefaults];
	[settings setInteger:([settings integerForKey:key] + 1) forKey:key];
	[settings synchronize];
}

+(NSString*)getKey:(NSString*)baseKey forMode:(EdgeGameMode)mode
{
	NSString *modeKey = @"";
	switch(mode)
	{
		case EdgeGameModeEasy:
			modeKey = @"easy";
			break;
			
		case EdgeGameModeNormal:
			modeKey = @"normal";
			break;
			
		case EdgeGameModeHard:
			modeKey = @"hard";
			break;
	}
	
	return [NSString stringWithFormat:@"%@_%@", baseKey, modeKey];
}

@end
