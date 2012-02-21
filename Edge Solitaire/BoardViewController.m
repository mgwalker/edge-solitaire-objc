//
//  BoardViewController.m
//  Edge Solitaire
//
//  Created by Greg Walker on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BoardViewController.h"
#import "NSCountedSet+canMakeTen.h"

typedef enum
{
	EdgeSoundTypeWinning,
	EdgeSoundTypeLosing,
	EdgeSoundTypeClearing,
	EdgeSoundTypeClicking
} EdgeSoundType;

@interface BoardViewController()
-(BOOL)canPlayNextCard;
-(void)showPopup:(UIImageView*)imageToShow;
-(void)playSound:(EdgeSoundType)soundType;
@end

@implementation BoardViewController

@synthesize spot0, spot1, spot2, spot3;
@synthesize spot4, spot5, spot6, spot7;
@synthesize spot8, spot9, spot10, spot11;
@synthesize spot12, spot13, spot14, spot15;

@synthesize instruction, nextCard, tensDoneButton, muteToggleButton;

@synthesize popupBackground, popupCannotPlace, popupCannotRemove, popupRestart, popupWin;
@synthesize playAgainButton, mainMenuButton, restartButton, quitButton;

-(id)init
{
	self = [super initWithNibName:@"BoardView" bundle:nil];
	if(self)
	{
		_cardDeck = [Card shuffledDeck];
		_summingCardSpots = [NSMutableArray array];
		_inSummingMode = NO;
		_popupVisible = NO;
		
		// Allow audio from other apps to mix in.
		[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];
		
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
	self.spot0.cellID = 0;
	self.spot0.delegate = self;
	self.spot1.cellID = 1;
	self.spot1.delegate = self;
	self.spot2.cellID = 2;
	self.spot2.delegate = self;
	self.spot3.cellID = 3;
	self.spot3.delegate = self;
	
	self.spot4.cellID = 4;
	self.spot4.delegate = self;
	self.spot5.cellID = 5;
	self.spot5.delegate = self;
	self.spot6.cellID = 6;
	self.spot6.delegate = self;
	self.spot7.cellID = 7;
	self.spot7.delegate = self;

	self.spot8.cellID = 8;
	self.spot8.delegate = self;
	self.spot9.cellID = 9;
	self.spot9.delegate = self;
	self.spot10.cellID = 10;
	self.spot10.delegate = self;
	self.spot11.cellID = 11;
	self.spot11.delegate = self;

	self.spot12.cellID = 12;
	self.spot12.delegate = self;
	self.spot13.cellID = 13;
	self.spot13.delegate = self;
	self.spot14.cellID = 14;
	self.spot14.delegate = self;
	self.spot15.cellID = 15;
	self.spot15.delegate = self;
	
	_allCardSpots = [NSArray arrayWithObjects:
					 self.spot0, self.spot1, self.spot2, self.spot3,
					 self.spot4, self.spot5, self.spot6, self.spot7,
					 self.spot8, self.spot9, self.spot10, self.spot11,
					 self.spot12, self.spot13, self.spot14, self.spot15, nil];

	// Start out hidden.  We don't want them to
	// fade out when they aren't supposed to be
	// there at all!
	self.popupBackground.hidden = YES;
	self.popupCannotPlace.hidden = YES;
	self.popupCannotRemove.hidden = YES;
	self.popupRestart.hidden = YES;
	self.popupWin.hidden = YES;
	self.playAgainButton.hidden = YES;
	self.mainMenuButton.hidden = YES;
	self.restartButton.hidden = YES;
	self.quitButton.hidden = YES;
	
	[_winSound prepareToPlay];
	[_loseSound prepareToPlay];
	[_clearSound prepareToPlay];
	[_clickSound prepareToPlay];
	
	// Initialize to the inverse of the saved state,
	// then toggle.  Get the correct UI for free!
	_isMuted = ![Settings isMuted];
	[self toggleMute:nil];

	[self resetGame:nil];
}

-(void)cardSpotTouched:(CardSpot *)cardSpot
{
	if(_popupVisible)
		return;
	
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
			[self playSound:EdgeSoundTypeClearing];
			
			for(CardSpot* spot in _summingCardSpots)
			{
				spot.highlighted = NO;
				spot.card = nil;
			}
			[_summingCardSpots removeAllObjects];
		}
		else if(click)
			[self playSound:EdgeSoundTypeClicking];
	}
	else if(self.nextCard.card != nil && cardSpot.card == nil)
	{
		if(self.nextCard.card.value < 11 || self.nextCard.card.value == cardSpot.edgeValue)
		{
			instruction.text = @"Tap a spot above to place the next card.";
			[self playSound:EdgeSoundTypeClicking];
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
				[self playSound:EdgeSoundTypeWinning];
				self.nextCard.hidden = YES;
				[self showPopup:popupWin];
				[Settings incrementEdgeGamesPlayed];
				[Settings incrementEdgeGamesWon];
				return;
			}
			
			if(allOccupied)
			{
				// If all card slots are full, verify that
				// some collection of cards can sum to 10.
				//   - If not, game over.
				//   - If so, move on.
				
				self.nextCard.hidden = YES;
								
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
					self.instruction.text = @"Tap cards to sum their values to ten.  Aces count as one.";
					self.tensDoneButton.hidden = NO;
					_inSummingMode = YES;
				}
				else
				{
					// Game over!
					[self playSound:EdgeSoundTypeLosing];
					[self showPopup:popupCannotRemove];
					[Settings incrementEdgeGamesPlayed];
				}
			}
			else
			{
				self.nextCard.card = _cardDeck.lastObject;
				[_cardDeck removeLastObject];

				// Verify that the next card can be played.
				if(![self canPlayNextCard])
				{
					[self playSound:EdgeSoundTypeLosing];
					[self showPopup:popupCannotPlace];
					[Settings incrementEdgeGamesPlayed];
				}
			}
		}
		else
		{
			// Tried to place a face card on a
			// non-face-card slot.
			self.instruction.text = @"Face cards must be placed on their assigned spots along the edge.";
		}
	}
}

-(IBAction)tensDone:(id)sender
{
	for(CardSpot* spot in _summingCardSpots)
		spot.highlighted = NO;
	[_summingCardSpots removeAllObjects];
	
	_inSummingMode = NO;
	self.instruction.text = @"Tap a spot above to place the next card.";
	self.nextCard.hidden = NO;
	self.tensDoneButton.hidden = YES;
	
	self.nextCard.card = _cardDeck.lastObject;
	[_cardDeck removeLastObject];
	
	if(![self canPlayNextCard])
	{
		[self playSound:EdgeSoundTypeLosing];
		[self showPopup:popupCannotPlace];
		[Settings incrementEdgeGamesPlayed];
	}
}

-(BOOL)canPlayNextCard
{
	BOOL can = NO;
	if(self.nextCard.card.value > 10)
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

	self.nextCard.hidden = NO;
	self.nextCard.card = _cardDeck.lastObject;
	[_cardDeck removeLastObject];

	_inSummingMode = NO;
	self.instruction.text = @"Tap a spot above to place the next card.";
	self.nextCard.hidden = NO;
	self.tensDoneButton.hidden = YES;
}

-(IBAction)quitGame:(id)sender
{
	[self.navigationController popViewControllerAnimated:NO];
}

-(IBAction)toggleMute:(id)sender
{
	if(_isMuted)
		[self.muteToggleButton setImage:[UIImage imageNamed:@"unmute.png"] forState:UIControlStateNormal];
	else
		[self.muteToggleButton setImage:[UIImage imageNamed:@"mute.png"] forState:UIControlStateNormal];
	
	_isMuted = !_isMuted;
	[Settings setIsMuted:_isMuted];
}

-(IBAction)quitOrRestart:(id)sender
{
	if(!_popupVisible)
		[self showPopup:self.popupRestart];
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
		self.instruction.text = @"";
		self.popupBackground.hidden = NO;
		self.popupBackground.alpha = 0;
		imageToShow.hidden = NO;
		imageToShow.alpha = 0;
		self.playAgainButton.hidden= NO;
		self.playAgainButton.alpha= 0;
		self.mainMenuButton.hidden = NO;
		self.mainMenuButton.alpha = 0;
		self.restartButton.hidden = NO;
		self.restartButton.alpha = 0;
		self.quitButton.hidden = NO;
		self.quitButton.alpha = 0;
		_popupVisible = YES;
	}
	else
		_popupVisible = NO;
	
	[UIView animateWithDuration:0.5 animations:^(void)
	 {
		if(imageToShow)
		{
			self.popupBackground.alpha = 1;
			imageToShow.alpha = 1;
			if(imageToShow == self.popupRestart)
			{
				self.restartButton.alpha = 1;
				self.quitButton.alpha = 1;
			}
			else
			{
				self.playAgainButton.alpha= 1;
				self.mainMenuButton.alpha = 1;
			}
		}
		else
		{
			self.popupBackground.alpha = 0;
			self.popupCannotPlace.alpha = 0;
			self.popupCannotRemove.alpha = 0;
			self.popupRestart.alpha = 0;
			self.popupWin.alpha = 0;
			self.playAgainButton.alpha = 0;
			self.mainMenuButton.alpha = 0;
			self.restartButton.alpha = 0;
			self.quitButton.alpha = 0;
		}
	 } completion:^(BOOL finished)
	 {
		 if(!imageToShow)
		 {
			 self.popupBackground.hidden = YES;
			 self.popupCannotPlace.hidden = YES;
			 self.popupCannotRemove.hidden = YES;
			 self.popupRestart.hidden = YES;
			 self.popupWin.hidden = YES;
			 self.playAgainButton.hidden = YES;
			 self.mainMenuButton.hidden = YES;
			 self.restartButton.hidden = YES;
			 self.quitButton.hidden = YES;
		 }
	 }];
}

-(void)playSound:(EdgeSoundType)soundType
{	
	if(!_isMuted)
	{
		switch(soundType)
		{
			case EdgeSoundTypeWinning:
				_winSound.currentTime = 0;
				if(!_winSound.playing)
					[_winSound play];
				break;
				
			case EdgeSoundTypeLosing:
				_loseSound.currentTime = 0;
				if(!_loseSound.playing)
					[_loseSound play];
				break;
				
			case EdgeSoundTypeClearing:
				_clearSound.currentTime = 0;
				if(!_clearSound.playing)
					[_clearSound play];
				break;
				
			case EdgeSoundTypeClicking:
				_clickSound.currentTime = 0;
				if(!_clickSound.playing)
					[_clickSound play];
				break;
		}
	}
}

- (void)viewDidUnload
{	
	self.spot0 = self.spot1 = self.spot2 = self.spot3 = nil;	
	self.spot4 = self.spot5 = self.spot6 = self.spot7 = nil;
	self.spot8 = self.spot9 = self.spot10 = self.spot11 = nil;	
	self.spot12 = self.spot13 = self.spot14 = self.spot15 = nil;
	
	self.instruction = nil;
	self.nextCard = nil;
	self.tensDoneButton = nil;
	
	self.popupBackground = nil;
	self.popupCannotPlace = nil;
	self.popupCannotRemove = nil;
	self.popupRestart = nil;
	self.popupWin = nil;
	self.playAgainButton = nil;
	self.mainMenuButton = nil;
	self.restartButton = nil;
	self.quitButton = nil;
	
	self.muteToggleButton = nil;
	
	[super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
