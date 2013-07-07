//
//  Card.h
//  Edge Solitaire
//
//  Created by Greg Walker on 1/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
	CardSuitClub,
	CardSuitDiamond,
	CardSuitHeart,
	CardSuitSpade
} CardSuit;

typedef enum
{
	CardValueAce = 1,
	CardValueTwo = 2,
	CardValueThree = 3,
	CardValueFour = 4,
	CardValueFive = 5,
	CardValueSix = 6,
	CardValueSeven = 7,
	CardValueEight = 8,
	CardValueNine = 9,
	CardValueTen = 10,
	CardValueJack = 11,
	CardValueQueen = 12,
	CardValueKing = 13
} CardValue;

@interface Card : NSObject
{
	NSInteger _value;
	CardSuit _suit;
}

-(id)initWithSuit:(CardSuit)cardSuit andValue:(NSInteger)cardValue;

@property (readonly) NSInteger value;
@property (readonly) CardSuit suit;
@property (readonly) NSString* suitFirstCharacter;

+(NSMutableArray*)shuffledDeck;

@end
