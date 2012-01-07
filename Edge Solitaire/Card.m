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

+(NSArray*)shuffledDeck
{
	return nil;
}

@end
