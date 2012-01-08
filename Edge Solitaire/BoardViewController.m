//
//  BoardViewController.m
//  Edge Solitaire
//
//  Created by Greg Walker on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BoardViewController.h"

@implementation BoardViewController

@synthesize spot0, spot1, spot2, spot3;
@synthesize spot4, spot5, spot6, spot7;
@synthesize spot8, spot9, spot10, spot11;
@synthesize spot12, spot13, spot14, spot15;

@synthesize nextCard;

-(id)init
{
	self = [super initWithNibName:@"BoardView" bundle:nil];
	if(self)
	{
		_cardDeck = [Card shuffledDeck];
	}
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [self init];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
	spot0.cellID = 0;
	spot0.delegate = self;
	spot1.cellID = 1;
	spot1.delegate = self;
	spot2.cellID = 2;
	spot2.delegate = self;
	spot3.cellID = 3;
	spot3.delegate = self;
	
	spot4.cellID = 4;
	spot4.delegate = self;
	spot5.cellID = 5;
	spot5.delegate = self;
	spot6.cellID = 6;
	spot6.delegate = self;
	spot7.cellID = 7;
	spot7.delegate = self;

	spot8.cellID = 8;
	spot8.delegate = self;
	spot9.cellID = 9;
	spot9.delegate = self;
	spot10.cellID = 10;
	spot10.delegate = self;
	spot11.cellID = 11;
	spot11.delegate = self;

	spot12.cellID = 12;
	spot12.delegate = self;
	spot13.cellID = 13;
	spot13.delegate = self;
	spot14.cellID = 14;
	spot14.delegate = self;
	spot15.cellID = 15;
	spot15.delegate = self;
	
	_allCardSpots = [NSArray arrayWithObjects:
					 spot0, spot1, spot2, spot3,
					 spot4, spot5, spot6, spot7,
					 spot8, spot9, spot10, spot11,
					 spot12, spot13, spot14, spot15, nil];
	
	nextCard.card = _cardDeck.lastObject;
	[_cardDeck removeLastObject];
}

-(void)cardSpotTouched:(CardSpot *)cardSpot
{
	if(nextCard.card != nil && cardSpot.card == nil)
	{
		if(nextCard.card.value < 11 || nextCard.card.value == cardSpot.edgeValue)
		{
			cardSpot.card = nextCard.card;
						
			BOOL allOccupied = YES;
			for(CardSpot* spot in _allCardSpots)
			{
				if(spot.card == nil)
				{
					allOccupied = NO;
					break;
				}
			}
			
			if(allOccupied)
			{
				// If all card slots are full, verify that
				// some collection of cards can sum to 10.
				//   - If not, game over.
				//   - If so, move on.

				BOOL sumToTenExists = NO;
				for(int i = 0; i < _allCardSpots.count - 1; i++)
				{
					CardSpot* spot = [_allCardSpots objectAtIndex:i];
					if(spot.card == nil || spot.card.value > 10)
						continue;
					
					NSInteger sum = spot.card.value;
					int j = i + 1;
					while(sum < 10 && j < _allCardSpots.count)
					{
						CardSpot* subsequent = [_allCardSpots objectAtIndex:j++];
						if(subsequent.card == nil || subsequent.card.value > 9)
							continue;
						
						sum += subsequent.card.value;
					}
					
					if(sum == 10)
					{
						sumToTenExists = YES;
						break;
					}
				}
				
				if(sumToTenExists)
				{
					// Start clearing sums of 10
					NSLog(@"Time to clear tens");
				}
				else
				{
					// Game over!
					NSLog(@"Game over - no sums to ten");
				}
			}
			else
			{
				nextCard.card = _cardDeck.lastObject;
				[_cardDeck removeLastObject];

				// Verify that the next card can be played.
				BOOL canPlayNextCard = YES;
				if(nextCard.card.value > 10)
				{
					canPlayNextCard = NO;
					for(CardSpot* spot in _allCardSpots)
					{
						if(spot.edgeValue == nextCard.card.value && spot.card == nil)
						{
							canPlayNextCard = YES;
							break;
						}
					}
				}
				
				if(!canPlayNextCard)
				{
					NSLog(@"Can't play face card.  Game over!");
				}
			}
		}
		else
		{
			// Tried to place a face card on a
			// non-face-card slot.
			NSLog(@"Face cards must go on their assigned spots.");
		}
	}
}

- (void)viewDidUnload
{
    [super viewDidUnload];
	spot0 = spot1 = spot2 = spot3 = nil;
	spot4 = spot5 = spot6 = spot7 = nil;
	spot8 = spot9 = spot10 = spot11 = nil;
	spot12 = spot13 = spot14 = spot15 = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
