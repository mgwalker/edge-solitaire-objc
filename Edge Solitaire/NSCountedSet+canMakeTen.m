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
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:2],
					 [NSNumber numberWithInt:2],
					 [NSNumber numberWithInt:2], nil],
					
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:2],
					 [NSNumber numberWithInt:2],
					 [NSNumber numberWithInt:2],
					 [NSNumber numberWithInt:2], nil],
					
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:2],
					 [NSNumber numberWithInt:2],
					 [NSNumber numberWithInt:3], nil],
					
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:2],
					 [NSNumber numberWithInt:2],
					 [NSNumber numberWithInt:2],
					 [NSNumber numberWithInt:3], nil],
					
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:3],
					 [NSNumber numberWithInt:3], nil],
					
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:2],
					 [NSNumber numberWithInt:3],
					 [NSNumber numberWithInt:3], nil],
					
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:2],
					 [NSNumber numberWithInt:2],
					 [NSNumber numberWithInt:3],
					 [NSNumber numberWithInt:3], nil],
					
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:3],
					 [NSNumber numberWithInt:3],
					 [NSNumber numberWithInt:3], nil],
					
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:2],
					 [NSNumber numberWithInt:4], nil],
					
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:2],
					 [NSNumber numberWithInt:2],
					 [NSNumber numberWithInt:4], nil],
					
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:2],
					 [NSNumber numberWithInt:2],
					 [NSNumber numberWithInt:2],
					 [NSNumber numberWithInt:4], nil],
					
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:3],
					 [NSNumber numberWithInt:4], nil],
					
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:2],
					 [NSNumber numberWithInt:3],
					 [NSNumber numberWithInt:4], nil],
					
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:3],
					 [NSNumber numberWithInt:3],
					 [NSNumber numberWithInt:4], nil],
					
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:4],
					 [NSNumber numberWithInt:4], nil],
					
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:2],
					 [NSNumber numberWithInt:4],
					 [NSNumber numberWithInt:4], nil],
					
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:2],
					 [NSNumber numberWithInt:5], nil],
					
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:2],
					 [NSNumber numberWithInt:2],
					 [NSNumber numberWithInt:5], nil],
					
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:3],
					 [NSNumber numberWithInt:5], nil],
					
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:2],
					 [NSNumber numberWithInt:3],
					 [NSNumber numberWithInt:5], nil],
					
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:4],
					 [NSNumber numberWithInt:5], nil],
					
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:5],
					 [NSNumber numberWithInt:5], nil],
					
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:6], nil],
					
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:2],
					 [NSNumber numberWithInt:6], nil],
					
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:2],
					 [NSNumber numberWithInt:2],
					 [NSNumber numberWithInt:6], nil],
					
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:3],
					 [NSNumber numberWithInt:6], nil],
					
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:4],
					 [NSNumber numberWithInt:6], nil],
					
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:7], nil],
					
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:2],
					 [NSNumber numberWithInt:7], nil],
					
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:3],
					 [NSNumber numberWithInt:7], nil],
					
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:8], nil],
					
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:2],
					 [NSNumber numberWithInt:8], nil],
					
					[NSCountedSet setWithObjects:
					 [NSNumber numberWithInt:1],
					 [NSNumber numberWithInt:9], nil],
					nil];
	
	for(NSCountedSet* sum in tensSums)
	{
		if([sum isSubsetOfSet:self])
		{
			BOOL isSum = YES;
			for(NSNumber* num in self)
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
