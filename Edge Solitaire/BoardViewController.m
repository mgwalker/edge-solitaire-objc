//
//  BoardViewController.m
//  Edge Solitaire
//
//  Created by Greg Walker on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BoardViewController.h"
#import "NSCountedSet+canMakeTen.h"

@interface BoardViewController()
-(BOOL)canPlayNextCard;
-(void)showPopup:(UIImageView*)imageToShow;
@end

@implementation BoardViewController

@synthesize spot0, spot1, spot2, spot3;
@synthesize spot4, spot5, spot6, spot7;
@synthesize spot8, spot9, spot10, spot11;
@synthesize spot12, spot13, spot14, spot15;

@synthesize instruction, nextCard, tensDoneButton, muteToggleButton;

@synthesize popupBackground, popupCannotPlace, popupCannotRemove, popupWin, playAgainButton, mainMenuButton;

-(id)init
{
	self = [super initWithNibName:@"BoardView" bundle:nil];
	if(self)
	{
		_cardDeck = [Card shuffledDeck];
		_summingCardSpots = [NSMutableArray array];
		_inSummingMode = NO;
		
		_winSound = [[AVAudioPlayer alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"Win"
																						 withExtension:@"mp3"]
														   error:NULL];
		
		_loseSound = [[AVAudioPlayer alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"GameOver"
																						  withExtension:@"mp3"]
															error:NULL];
		
		_clearSound = [[AVAudioPlayer alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"Clear"
																						   withExtension:@"mp3"]
															 error:NULL];
		
		_clickSound = [[AVAudioPlayer alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"Place"
																						   withExtension:@"mp3"]
															 error:NULL];
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

	// Start out hidden.  We don't want them to
	// fade out when they aren't supposed to be
	// there at all!
	popupBackground.hidden = YES;
	popupCannotPlace.hidden = YES;
	popupCannotRemove.hidden = YES;
	popupWin.hidden = YES;
	playAgainButton.hidden = YES;
	mainMenuButton.hidden = YES;
	
	[_winSound prepareToPlay];
	[_loseSound prepareToPlay];
	[_clearSound prepareToPlay];
	[_clickSound prepareToPlay];
	
	// Initialize to the inverse of the saved state,
	// then toggle.  Get the correct UI for free!
	_isMuted = ![[NSUserDefaults standardUserDefaults] boolForKey:@"muted"];
	[self toggleMute:nil];

	[self resetGame:nil];
}

-(void)cardSpotTouched:(CardSpot *)cardSpot
{	
	if(_inSummingMode)
	{
		BOOL click = NO;
		if([_summingCardSpots containsObject:cardSpot])
		{
			click = YES;
			cardSpot.highlighted = NO;
			[_summingCardSpots removeObject:cardSpot];
		}
		else if(cardSpot.card != nil && cardSpot.card.value <= 10)
		{
			click = YES;
			cardSpot.highlighted = YES;
			[_summingCardSpots addObject:cardSpot];
		}
		
		int sum = 0;
		for(CardSpot* spot in _summingCardSpots)
			sum += spot.card.value;
		
		if(sum == 10)
		{
			if(!_isMuted)
				[_clearSound play];
			
			for(CardSpot* spot in _summingCardSpots)
			{
				spot.highlighted = NO;
				spot.card = nil;
			}
			[_summingCardSpots removeAllObjects];
		}
		else if(click && !_isMuted)
			[_clickSound play];
	}
	else if(nextCard.card != nil && cardSpot.card == nil)
	{
		if(nextCard.card.value < 11 || nextCard.card.value == cardSpot.edgeValue)
		{
			if(!_isMuted)
				[_clickSound play];
			cardSpot.card = nextCard.card;
			
			// If all the edge spots are occupied by their
			// appropriate face cards, the user has won
			BOOL hasWon = YES;
			BOOL allOccupied = YES;
			for(CardSpot* spot in _allCardSpots)
			{
				if(spot.card == nil)
				{
					if(spot.edgeValue > 10)
						hasWon = NO;
					allOccupied = NO;
				}
				else if(spot.card.value != spot.edgeValue && spot.edgeValue > 10)
					hasWon = NO;
			}
			
			if(hasWon)
			{
				if(!_isMuted)
					[_winSound play];
				nextCard.hidden = YES;
				[self showPopup:popupWin];
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
				for(CardSpot* spot in _allCardSpots)
				{
					if(spot.card != nil)
					{
						if(spot.card.value < 10)
							[valuesToCheck addObject:[NSNumber numberWithInt:spot.card.value]];
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
					if(!_isMuted)
						[_loseSound play];
					[self showPopup:popupCannotRemove];
				}
			}
			else
			{
				nextCard.card = _cardDeck.lastObject;
				[_cardDeck removeLastObject];

				// Verify that the next card can be played.
				if(![self canPlayNextCard])
				{
					if(!_isMuted)
						[_loseSound play];
					[self showPopup:popupCannotPlace];
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
	
	if(![self canPlayNextCard])
	{
		if(!_isMuted)
			[_loseSound play];
		[self showPopup:popupCannotPlace];
	}
}

-(BOOL)canPlayNextCard
{
	BOOL can = NO;
	if(nextCard.card.value > 10)
	{
		for(CardSpot* spot in _allCardSpots)
		{
			if(spot.edgeValue == nextCard.card.value && spot.card == nil)
			{
				can = YES;
				break;
			}
		}
	}
	else
	{
		for(CardSpot* spot in _allCardSpots)
		{
			if(spot.card == nil)
			{
				can = YES;
				break;
			}
		}
	}
	return can;
}

-(IBAction)resetGame:(id)sender
{
	[self showPopup:nil];

	for(CardSpot* spot in _allCardSpots)
	{
		spot.highlighted = NO;
		spot.card = nil;
	}
	[_summingCardSpots removeAllObjects];
	_cardDeck = [Card shuffledDeck];

	nextCard.hidden = NO;
	nextCard.card = _cardDeck.lastObject;
	[_cardDeck removeLastObject];

	_inSummingMode = NO;
	instruction.text = @"Tap a spot above to place the next card.";
	nextCard.hidden = NO;
	tensDoneButton.hidden = YES;
}

-(IBAction)quitGame:(id)sender
{
	[self.navigationController popViewControllerAnimated:NO];
}

-(IBAction)toggleMute:(id)sender
{
	if(_isMuted)
		[self.muteToggleButton setBackgroundImage:[UIImage imageNamed:@"mute.png"] forState:UIControlStateNormal];
	else
		[self.muteToggleButton setBackgroundImage:[UIImage imageNamed:@"unmute.png"] forState:UIControlStateNormal];
	
	_isMuted = !_isMuted;
	[[NSUserDefaults standardUserDefaults] setBool:_isMuted forKey:@"muted"];
}

-(IBAction)quitOrRestart:(id)sender
{
	
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == alertView.cancelButtonIndex)
		[self resetGame:nil];
	else
		[self.navigationController popViewControllerAnimated:YES];
}

-(void)showPopup:(UIImageView *)imageToShow
{
	if(imageToShow)
	{
		instruction.text = @"";
		popupBackground.hidden = NO;
		popupBackground.alpha = 0;
		imageToShow.hidden = NO;
		imageToShow.alpha = 0;
		playAgainButton.hidden= NO;
		playAgainButton.alpha= 0;
		mainMenuButton.hidden = NO;
		mainMenuButton.alpha = 0;
	}
	
	[UIView animateWithDuration:0.5 animations:^(void)
	 {
		if(imageToShow)
		{
			popupBackground.alpha = 1;
			imageToShow.alpha = 1;
			playAgainButton.alpha= 1;
			mainMenuButton.alpha = 1;
		}
		else
		{
			popupBackground.alpha = 0;
			popupCannotPlace.alpha = 0;
			popupCannotRemove.alpha = 0;
			popupWin.alpha = 0;
			playAgainButton.alpha = 0;
			mainMenuButton.alpha = 0;
		}
	 } completion:^(BOOL finished)
	 {
		 if(!imageToShow)
		 {
			 popupBackground.hidden = YES;
			 popupCannotPlace.hidden = YES;
			 popupCannotRemove.hidden = YES;
			 popupWin.hidden = YES;
			 playAgainButton.hidden = YES;
			 mainMenuButton.hidden = YES;
		 }
	 }];
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
