//
//  LandingViewController.m
//  Edge Solitaire
//
//  Created by Greg Walker on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LandingViewController.h"
#import "DifficultyViewController.h"
#import "BoardViewController.h"

@implementation LandingViewController

-(id)init
{
	self = [super initWithNibName:@"LandingView" bundle:nil];
	if(self)
	{
	}
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [self init];
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"green_felt.jpg"]];
	self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.statsLabel = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
	NSInteger played = [Settings edgeGamesPlayed];
	NSInteger won = [Settings edgeGamesWon];
	float percentage = 100.0 * (((float)won) / ((float)played));
	
	NSNumberFormatter* nf = [[NSNumberFormatter alloc] init];
	[nf setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[nf setNumberStyle:NSNumberFormatterDecimalStyle];
	
	NSString* playedString = [nf stringFromNumber:[NSNumber numberWithInteger:played]];
	NSString* wonString = [nf stringFromNumber:[NSNumber numberWithInteger:won]];
	NSString* percentageString = [NSString stringWithFormat:@"%.1f%%", percentage];
	
	if(played > 0)
		[self.statsLabel setText:[NSString stringWithFormat:@"You've won %@ games out of %@ played.  That's %@!", wonString, playedString, percentageString]];
	else
		[self.statsLabel setText:@""];
	
	[super viewWillAppear:animated];
}

#pragma mark - Actions
-(IBAction)startGame:(id)sender
{
	LandingViewController *me = self;
	
	DifficultyViewController *diff = [[DifficultyViewController alloc] initWithCallback:^(EdgeGameMode mode)
									 {
										 BoardViewController* vc = [[BoardViewController alloc] initWithMode:mode];
										 [me.navigationController pushViewController:vc animated:NO];
										 [me dismissViewControllerAnimated:NO completion:nil];
									 }];
	diff.modalPresentationStyle = UIModalPresentationFormSheet;
	[self presentViewController:diff animated:YES completion:nil];
}

#pragma mark - Rotation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
