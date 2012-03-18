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
	
	for(int i = 51; i > 0; i--)
	{
		[deck exchangeObjectAtIndex:(arc4random() % (i + 1))
				  withObjectAtIndex:i];
	}
	
	return deck;
}

@end
