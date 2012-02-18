//
//  Card.m
//  Edge Solitaire
//
//  Created by Greg Walker on 1/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Card.h"

@implementation Card

-(id)initWithSuit:(enum CardSuit)cardSuit andValue:(NSInteger)cardValue
{
	self = [super init];
	if(self)
	{
		_suit = cardSuit;
		_value = cardValue;
	}
	return self;
}

-(NSInteger)value { return _value; }
-(enum CardSuit)suit { return _suit; }

+(NSMutableArray*)shuffledDeck
{
	NSMutableArray* deck = [NSMutableArray array];
	for(int i = 1; i < 14; i++)
	{
		[deck addObject:[[Card alloc] initWithSuit:CardSuitClub andValue:i]];
		[deck addObject:[[Card alloc] initWithSuit:CardSuitDiamond andValue:i]];
		[deck addObject:[[Card alloc] initWithSuit:CardSuitHeart andValue:i]];
		[deck addObject:[[Card alloc] initWithSuit:CardSuitSpade andValue:i]];		
	}
	
	for(int i = 0; i < (52 * 4); i++)
	{
		NSInteger r = arc4random() % 52;
		[deck exchangeObjectAtIndex:(i % 52) withObjectAtIndex:r];
	}
	
	return deck;
}

@end
