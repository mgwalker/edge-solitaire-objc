//
//  Settings.h
//  Edge Solitaire
//
//  Created by Greg Walker on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject

+(BOOL)isMuted;
+(void)setIsMuted:(BOOL)muted;

+(NSInteger)edgeGamesPlayed;
+(void)incrementEdgeGamesPlayed;

+(NSInteger)edgeGamesWon;
+(void)incrementEdgeGamesWon;

@end
