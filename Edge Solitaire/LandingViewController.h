//
//  LandingViewController.h
//  Edge Solitaire
//
//  Created by Greg Walker on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIUniversalViewController.h"
#import "GradientButton.h"

@interface LandingViewController : UIUniversalViewController
{
	
}

@property (retain) IBOutlet GradientButton* startGameButton;
@property (retain) IBOutlet GradientButton* tutorialButton;

-(IBAction)startGame:(id)sender;
-(IBAction)tutorial:(id)sender;

@end
