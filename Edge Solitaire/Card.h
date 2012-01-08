//
//  Card.h
//  Edge Solitaire
//
//  Created by Greg Walker on 1/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

enum CardSuit
{
	CardSuitClub,
	CardSuitDiamond,
	CardSuitHeart,
	CardSuitSpade
};

@interface Card : NSObject
{
	NSInteger _value;
	enum CardSuit _suit;
}

-(id)initWithSuit:(enum CardSuit)cardSuit andValue:(NSInteger)cardValue;

@property (readonly) NSInteger value;
@property (readonly) enum CardSuit suit;

+(NSMutableArray*)shuffledDeck;

@end
