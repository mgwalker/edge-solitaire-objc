//
//  CardSpot.h
//  Edge Solitaire
//
//  Created by Greg Walker on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@protocol CardSpotDelegate;

typedef enum
{
	EdgeGameModeEasy,
	EdgeGameModeNormal,
	EdgeGameModeHard
} EdgeGameMode;

@interface CardSpot : UIView
{
	CardValue _requiredCardValue;
	CardSuit _requiredCardSuit;
	Card* _card;
	BOOL _highlighted;
}

-(void)setRequiredValue:(CardValue)cardValue;
-(void)setRequiredValue:(CardValue)cardValue withRequiredSuit:(CardSuit)suit;

@property (readonly) CardValue requiredCardValue;
@property (readonly) CardSuit requiredCardSuit;
@property (retain) Card* card;
@property (assign) BOOL highlighted;

@property (retain) id<CardSpotDelegate> delegate;

@end

@protocol CardSpotDelegate
-(void)cardSpotTouched:(CardSpot*)cardSpot;
@end