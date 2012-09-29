//
//  LandingViewController.m
//  Edge Solitaire
//
//  Created by Greg Walker on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LandingViewController.h"
#import "BoardViewController.h"

@implementation LandingViewController

@synthesize statsLabel;

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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
	NSInteger played = [Settings edgeGamesPlayed];
	NSInteger won = [Settings edgeGamesWon];
	float percentage = 100.0 * (((float)won) / ((float)played));
	
	NSNumberFormatter* nf = [[NSNumberFormatter alloc] init];
	[nf setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[nf setNumberStyle:NSNumberFormatterDecimalStyle];
	
	NSString* playedString = [nf stringFromNumber:[NSNumber numberWithInt:played]];
	NSString* wonString = [nf stringFromNumber:[NSNumber numberWithInt:won]];
	NSString* percentageString = [NSString stringWithFormat:@"%.1f%%", percentage];
	
	[statsLabel setText:[NSString stringWithFormat:@"You've won %@ games out of %@ played.  That's %@!", wonString, playedString, percentageString]];
	
	[super viewWillAppear:animated];
}

#pragma mark - Actions
-(IBAction)startGame:(id)sender
{
	BoardViewController* vc = [[BoardViewController alloc] init];
	[self.navigationController pushViewController:vc animated:NO];
}

#pragma mark - Rotation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
