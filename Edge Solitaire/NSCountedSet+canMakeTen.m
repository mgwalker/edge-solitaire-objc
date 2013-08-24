//
//  NSCountedSet.m
//  Edge Solitaire
//
//  Created by Greg Walker on 1/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSCountedSet+canMakeTen.h"

@implementation NSCountedSet(canMakeTen)
-(BOOL)canMakeTen
{
	static NSArray* tensSums = nil;
	if(tensSums == nil)
		tensSums = [NSArray arrayWithObjects:
					[NSCountedSet setWithObject:@10],
					
					// Face cards count as ten if they're in the
					// list of cards to be checked.
					[NSCountedSet setWithObject:@11],
					[NSCountedSet setWithObject:@12],
					[NSCountedSet setWithObject:@13],

					[NSCountedSet setWithObjects: @1, @1, @1, @1, @2, @2, @2, nil],
					[NSCountedSet setWithObjects: @1, @1, @2, @2, @2, @2, nil],
					[NSCountedSet setWithObjects: @1, @1, @1, @2, @2, @3, nil],
					[NSCountedSet setWithObjects: @1, @2, @2, @2, @3, nil],
					[NSCountedSet setWithObjects: @1, @1, @1, @1, @3, @3, nil],
					[NSCountedSet setWithObjects: @1, @1, @2, @3, @3, nil],
					[NSCountedSet setWithObjects: @2, @2, @3, @3, nil],
					[NSCountedSet setWithObjects: @1, @3, @3, @3, nil],
					[NSCountedSet setWithObjects: @1, @1, @1, @1, @2, @4, nil],
					[NSCountedSet setWithObjects: @1, @1, @2, @2, @4, nil],
					[NSCountedSet setWithObjects: @2, @2, @2, @4, nil],
					[NSCountedSet setWithObjects: @1, @1, @1, @3, @4, nil],
					[NSCountedSet setWithObjects: @1, @2, @3, @4, nil],
					[NSCountedSet setWithObjects: @3, @3, @4, nil],
					[NSCountedSet setWithObjects: @1, @1, @4, @4, nil],
					[NSCountedSet setWithObjects: @2, @4, @4, nil],
					[NSCountedSet setWithObjects: @1, @1, @1, @2, @5, nil],
					[NSCountedSet setWithObjects: @1, @2, @2, @5, nil],
					[NSCountedSet setWithObjects: @1, @1, @3, @5, nil],
					[NSCountedSet setWithObjects: @2, @3, @5, nil],
					[NSCountedSet setWithObjects: @1, @4, @5, nil],
					[NSCountedSet setWithObjects: @5, @5, nil],
					[NSCountedSet setWithObjects: @1, @1, @1, @1, @6, nil],
					[NSCountedSet setWithObjects: @1, @1, @2, @6, nil],
					[NSCountedSet setWithObjects: @2, @2, @6, nil],
					[NSCountedSet setWithObjects: @1, @3, @6, nil],
					[NSCountedSet setWithObjects: @4, @6, nil],
					[NSCountedSet setWithObjects: @1, @1, @1, @7, nil],
					[NSCountedSet setWithObjects: @1, @2, @7, nil],
					[NSCountedSet setWithObjects: @3, @7, nil],
					[NSCountedSet setWithObjects: @1, @1, @8, nil],
					[NSCountedSet setWithObjects: @2, @8, nil],
					[NSCountedSet setWithObjects: @1, @9, nil],
					
					nil];
	
	for(NSCountedSet* sum in tensSums)
	{
		if([sum isSubsetOfSet:self])
		{
			BOOL isSum = YES;
			for(NSNumber* num in sum)
			{
				if([self countForObject:num] < [sum countForObject:num])
				{
					isSum = NO;
					break;
				}
			}
			if(isSum)
				return YES;
		}
	}
	return NO;
}
@end
