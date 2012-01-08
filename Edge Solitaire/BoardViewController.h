//
//  BoardViewController.h
//  Edge Solitaire
//
//  Created by Greg Walker on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIUniversalViewController.h"
#import "CardSpot.h"

@interface BoardViewController : UIUniversalViewController <CardSpotDelegate>
{
	// Array of Cards
	NSMutableArray* _cardDeck;
	NSArray* _allCardSpots;
}

@property (retain) IBOutlet CardSpot* spot0;
@property (retain) IBOutlet CardSpot* spot1;
@property (retain) IBOutlet CardSpot* spot2;
@property (retain) IBOutlet CardSpot* spot3;

@property (retain) IBOutlet CardSpot* spot4;
@property (retain) IBOutlet CardSpot* spot5;
@property (retain) IBOutlet CardSpot* spot6;
@property (retain) IBOutlet CardSpot* spot7;

@property (retain) IBOutlet CardSpot* spot8;
@property (retain) IBOutlet CardSpot* spot9;
@property (retain) IBOutlet CardSpot* spot10;
@property (retain) IBOutlet CardSpot* spot11;

@property (retain) IBOutlet CardSpot* spot12;
@property (retain) IBOutlet CardSpot* spot13;
@property (retain) IBOutlet CardSpot* spot14;
@property (retain) IBOutlet CardSpot* spot15;

@property (retain) IBOutlet UILabel* instruction;
@property (retain) IBOutlet CardSpot* nextCard;
@property (retain) IBOutlet UIButton* tensDoneButton;

@end
