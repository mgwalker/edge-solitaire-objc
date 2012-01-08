//
//  BoardViewController.m
//  Edge Solitaire
//
//  Created by Greg Walker on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BoardViewController.h"

@interface NSMutableArray(cansum)
-(BOOL)elementsCanSum:(NSInteger)toValue;
-(BOOL)canMakeTen;
-(BOOL)canMakeTen2;
-(NSMutableArray*)canMakeTen2:(int)index;
@end

@implementation NSMutableArray(cansum)

-(BOOL)canMakeTen
{
	int numberOfCards = self.count;

	int result[11];
	for (int i = 0; i <= 10; i++)
		result[i] = numberOfCards + 1;
		
	result[0] = 0;
	for (int i = 1; i <= 10; i++)
	{
		for (int j = 0; j < numberOfCards; j++)
		{
			int val = [[self objectAtIndex:j] intValue];
			if (val <= i && result[i - val] + 1 < result[i])
			{
				if(i == 10 && result[i - val] + 1 <= numberOfCards)
					return YES;
				result[i] = result[i - val] + 1;
			}
		}
	}
		
	return result[10] <= numberOfCards;
}

-(BOOL)canMakeTen2
{
	NSMutableArray* sums = [self canMakeTen2:0];
	for(NSNumber* sum in sums)
		if(sum.intValue == 10)
			return YES;
	return NO;
}
-(NSMutableArray*)canMakeTen2:(int)index
{
	/* (1) */
    if (index >= [self count])
        return [NSMutableArray arrayWithObject:[NSNumber numberWithInt:0]];
	
    /* (2) Generate all the subsets where the `index`th element is not included */
    NSMutableArray* result = [self canMakeTen2:index + 1];
	
    /* (3) Add all the cases where the `index`th element is included */
    NSUInteger i, n = [result count];
    float element = [[self objectAtIndex:index] intValue];
    for (i = 0; i < n; i++)
	{
        float element2 = [[result objectAtIndex:i] intValue];
        [result addObject:[NSNumber numberWithFloat:element + element2]];
    }
	
    return result;
}

-(BOOL)elementsCanSum:(NSInteger)toValue
{
	BOOL canSum = NO;
	//BOOL started[10];
	
	NSLog(@"Trying to sum to %i...", toValue);
	
	for(int i = 0; i < self.count; i++)
	{
		int num = [[self objectAtIndex:i] intValue];
		//if(started[num.intValue] || num.intValue > toValue)
		//	continue;
		
		if(num > toValue)
			continue;
		
		NSLog(@" --> Starting with %i", num);
		
		if(num == toValue)
		{
			NSLog(@" --> --> Found the sum: %i", num);
			canSum = YES;
			break;
		}
		
		NSMutableArray* sub = [NSMutableArray arrayWithArray:self];
		[sub removeObjectAtIndex:i];
		
		if(sub.count > 0)
		{
			NSLog(@" --> --> There's a subarray.  Let's examine that.");
			NSLog(@" --> --> --> Take %i", num);
			canSum = [sub elementsCanSum:(toValue - num)];
			
			if(!canSum)
			{
				NSLog(@" --> --> --> Don't take %i", num);
				canSum = [sub elementsCanSum:toValue];
			}
			if(canSum)
			{
				NSLog(@"Can sum to %i", toValue);
				break;
			}
		}
		else
			NSLog(@" --> --> There's no subarray.  Alas.  Move on to the next number.");
	}
	
	return canSum;
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
			//if(cardSpot == spot5 || cardSpot == spot6 || cardSpot == spot9 || cardSpot == spot10)
			//	cardSpot.highlighted = YES;
						
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
				/* * /
				BOOL(^Q)(NSInteger cs, NSInteger k);
				Q = ^BOOL(NSInteger cs, NSInteger k)
				{
					return YES;
				};
				
				BOOL hasTen = Q(_allCardSpots.count, 10);
				//*/
				
				// If all card slots are full, verify that
				// some collection of cards can sum to 10.
				//   - If not, game over.
				//   - If so, move on.
								
				NSLog(@"All spots are occupied.  Now to check for sums of ten.");

				BOOL sumToTenExists = NO;
				NSMutableArray* valuesToCheck = [NSMutableArray array];
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
				{
					//sumToTenExists = [valuesToCheck canMakeTen]; // [valuesToCheck elementsCanSum:10];
					//sumToTenExists = [valuesToCheck elementsCanSum:10];
					sumToTenExists = [valuesToCheck canMakeTen2];
					/*BOOL starts[10];
					BOOL(^canSumFromIndex)(int startingIndex) = ^BOOL(int startingIndex)
					{
						return NO;
					};
					
					for(int i = 0; i < valuesToCheck.count; i++)
					{
						int startVal = [[valuesToCheck objectAtIndex:i] intValue];
						if(starts[startVal])
							continue;
						
						starts[startVal] = YES;
						if(canSumFromIndex(i))
						{
							sumToTenExists = YES;
							break;
						}
					}*/
				}
				
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

					NSLog(@"Game over - no sums to ten");
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
					NSLog(@"Can't play face card.  Game over!");
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
		NSLog(@"Can't play face card.  Game over!");
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
