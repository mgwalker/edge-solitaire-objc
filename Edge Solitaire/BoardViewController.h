//
//  BoardViewController.h
//  Edge Solitaire
//
//  Created by Greg Walker on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CardSpot.h"
#import <AVFoundation/AVFoundation.h>

@interface BoardViewController : UIViewController <CardSpotDelegate>
{
	// Array of Cards
	NSMutableArray* _cardDeck;
	NSArray* _allCardSpots;
	NSMutableArray* _summingCardSpots;
	BOOL _inSummingMode;
	BOOL _popupVisible;
	
	AVAudioPlayer* _winSound;
	AVAudioPlayer* _loseSound;
	AVAudioPlayer* _clickSound;
	AVAudioPlayer* _clearSound;
	
	BOOL _isMuted;
}

-(id)initWithMode:(EdgeGameMode)mode;

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

@property (retain) IBOutlet UIImageView* popupBackground;
@property (retain) IBOutlet UIImageView* popupCannotPlace;
@property (retain) IBOutlet UIImageView* popupCannotRemove;
@property (retain) IBOutlet UIImageView* popupRestart;
@property (retain) IBOutlet UIImageView* popupWin;
@property (retain) IBOutlet UIButton* playAgainButton;
@property (retain) IBOutlet UIButton* mainMenuButton;
@property (retain) IBOutlet UIButton* restartButton;
@property (retain) IBOutlet UIButton* quitButton;

@property (retain) IBOutlet UIButton* muteToggleButton;

-(IBAction)tensDone:(id)sender;
-(IBAction)resetGame:(id)sender;
-(IBAction)quitGame:(id)sender;
-(IBAction)quitOrRestart:(id)sender;
-(IBAction)toggleMute:(id)sender;

@end
