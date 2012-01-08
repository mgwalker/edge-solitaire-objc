//
//  BoardViewController.m
//  Edge Solitaire
//
//  Created by Greg Walker on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BoardViewController.h"

@interface NSCountedSet(canMakeTen)
-(BOOL)canMakeTen;
@end

@implementation NSCountedSet(canMakeTen)
-(BOOL)canMakeTen
{
	static NSArray* tensSums = nil;
	if(tensSums == nil)
		tensSums = [NSArray arrayWithObjects:
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:2], [NSNumber numberWithInt:2], nil],
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:2], [NSNumber numberWithInt:2], [NSNumber numberWithInt:2], nil],
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3], nil],
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:2], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3], nil],
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:3], [NSNumber numberWithInt:3], nil],
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3], [NSNumber numberWithInt:3], nil],
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3], [NSNumber numberWithInt:3], nil],
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:3], [NSNumber numberWithInt:3], [NSNumber numberWithInt:3], nil],
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:4], nil],
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:2], [NSNumber numberWithInt:4], nil],
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:2], [NSNumber numberWithInt:2], [NSNumber numberWithInt:4], nil],
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:3], [NSNumber numberWithInt:4], nil],
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3], [NSNumber numberWithInt:4], nil],
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:3], [NSNumber numberWithInt:3], [NSNumber numberWithInt:4], nil],
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:4], [NSNumber numberWithInt:4], nil],
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:4], [NSNumber numberWithInt:4], nil],
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:5], nil],
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:2], [NSNumber numberWithInt:5], nil],
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:3], [NSNumber numberWithInt:5], nil],
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:3], [NSNumber numberWithInt:5], nil],
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:4], [NSNumber numberWithInt:5], nil],
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:5], [NSNumber numberWithInt:5], nil],
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:6], nil],
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:6], nil],
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:2], [NSNumber numberWithInt:6], nil],
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:3], [NSNumber numberWithInt:6], nil],
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:4], [NSNumber numberWithInt:6], nil],
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:7], nil],
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:7], nil],
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:3], [NSNumber numberWithInt:7], nil],
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:8], nil],
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:8], nil],
					[NSCountedSet setWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:9], nil],
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

@implementation BoardViewController

@synthesize spot0, spot1, spot2, spot3;
@synthesize spot4, spot5, spot6, spot7;
@synthesize spot8, spot9, spot10, spot11;
@synthesize spot12, spot13, spot14, spot15;

@synthesize instruction, nextCard, tensDoneButton;

-(id)init
{
	self = [super initWithNibName:@"BoardView" bundle:nil];
	if(self)
	{
		_cardDeck = [Card shuffledDeck];
		_summingCardSpots = [NSMutableArray array];
		_inSummingMode = NO;
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
	if(_inSummingMode)
	{
		if([_summingCardSpots containsObject:cardSpot])
		{
			cardSpot.highlighted = NO;
			[_summingCardSpots removeObject:cardSpot];
		}
		else if(cardSpot.card != nil && cardSpot.card.value <= 10)
		{
			cardSpot.highlighted = YES;
			[_summingCardSpots addObject:cardSpot];
		}
		
		int sum = 0;
		for(CardSpot* spot in _summingCardSpots)
			sum += spot.card.value;
		
		if(sum == 10)
		{
			for(CardSpot* spot in _summingCardSpots)
			{
				spot.highlighted = NO;
				spot.card = nil;
			}
			[_summingCardSpots removeAllObjects];
		}
	}
	else if(nextCard.card != nil && cardSpot.card == nil)
	{
		if(nextCard.card.value < 11 || nextCard.card.value == cardSpot.edgeValue)
		{
			cardSpot.card = nextCard.card;
			
			// If all the edge spots are occupied by their
			// appropriate face cards, the user has won
			BOOL hasWon = YES;
			BOOL allOccupied = YES;
			for(CardSpot* spot in _allCardSpots)
			{
				if(spot.card == nil)
				{
					hasWon = NO;
					allOccupied = NO;
					break;
				}
				
				if(spot.card.value != spot.edgeValue)
					hasWon = NO;
			}
			
			if(hasWon)
			{
				[[[UIAlertView alloc] initWithTitle:@"You Win!"
											message:@"You've won!"
										   delegate:self
								  cancelButtonTitle:@"Play again"
								  otherButtonTitles:@"Quit", nil] show];

				return;
			}
			
			if(allOccupied)
			{
				// If all card slots are full, verify that
				// some collection of cards can sum to 10.
				//   - If not, game over.
				//   - If so, move on.
								
				BOOL sumToTenExists = NO;
				NSCountedSet* valuesToCheck = [NSCountedSet set];
				for(int i = 0; i < _allCardSpots.count - 1; i++)
				{
					CardSpot* spot = [_allCardSpots objectAtIndex:i];
					if(spot.card != nil)
					{
						if(spot.card.value < 10)
						{
							[valuesToCheck addObject:[NSNumber numberWithInt:spot.card.value]];
						}
						else if(spot.card.value == 10)
						{
							sumToTenExists = YES;
							break;
						}
					}
				}
				
				if(!sumToTenExists)
					sumToTenExists = [valuesToCheck canMakeTen];
				
				if(sumToTenExists)
				{
					// Start clearing sums of 10
					instruction.text = @"Tap cards to sum their values to ten.  Aces count as one.";
					nextCard.hidden = YES;
					tensDoneButton.hidden = NO;
					_inSummingMode = YES;
				}
				else
				{
					// Game over!
					[[[UIAlertView alloc] initWithTitle:@"Game Over"
												message:@"You can't clear any cards."
											   delegate:self
									  cancelButtonTitle:@"Play again"
									  otherButtonTitles:@"Quit", nil] show];
				}
			}
			else
			{
				nextCard.card = _cardDeck.lastObject;
				[_cardDeck removeLastObject];
//				while(nextCard.card.value > 9)
//				{
//					nextCard.card = _cardDeck.lastObject;
//					[_cardDeck removeLastObject];
//				}

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
					[[[UIAlertView alloc] initWithTitle:@"Game Over"
											   message:@"There's nowhere to place this face card."
											  delegate:self
									 cancelButtonTitle:@"Play again"
									 otherButtonTitles:@"Quit", nil] show];
				}
			}
		}
		else
		{
			// Tried to place a face card on a
			// non-face-card slot.
			instruction.text = @"Face cards must be placed on their assigned spots along the edge.";
			dispatch_queue_t q = dispatch_queue_create("Instruction return", NULL);
			dispatch_async(q, ^(void)
						   {
							   [NSThread sleepForTimeInterval:3];
							   dispatch_async(dispatch_get_main_queue(), ^(void)
							   {
								   instruction.text = @"Tap a spot above to place the next card.";
							   });
						   });
			dispatch_release(q);
		}
	}
}

-(IBAction)tensDone:(id)sender
{
	for(CardSpot* spot in _summingCardSpots)
		spot.highlighted = NO;
	[_summingCardSpots removeAllObjects];
	
	_inSummingMode = NO;
	instruction.text = @"Tap a spot above to place the next card.";
	nextCard.hidden = NO;
	tensDoneButton.hidden = YES;
	
	nextCard.card = _cardDeck.lastObject;
	[_cardDeck removeLastObject];
	
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
		[[[UIAlertView alloc] initWithTitle:@"Game Over"
									message:@"There's nowhere to place this face card."
								   delegate:self
						  cancelButtonTitle:@"Play again"
						  otherButtonTitles:@"Quit", nil] show];
	}
}

-(IBAction)resetGame:(id)sender
{
	for(CardSpot* spot in _allCardSpots)
		spot.card = nil;
	[_summingCardSpots removeAllObjects];
	_cardDeck = [Card shuffledDeck];

	nextCard.card = _cardDeck.lastObject;
	[_cardDeck removeLastObject];

	_inSummingMode = NO;
	instruction.text = @"Tap a spot above to place the next card.";
	nextCard.hidden = NO;
	tensDoneButton.hidden = YES;
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == alertView.cancelButtonIndex)
		[self resetGame:nil];
	else
		[self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
	spot0 = spot1 = spot2 = spot3 = nil;
	spot4 = spot5 = spot6 = spot7 = nil;
	spot8 = spot9 = spot10 = spot11 = nil;
	spot12 = spot13 = spot14 = spot15 = nil;
	
	instruction = nil;
	nextCard = nil;
	tensDoneButton = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
