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

-(id)init
{
	self = [super initWithNibName:@"BoardView" bundle:nil];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	spot0.cellID = 0;
	spot1.cellID = 1;
	spot2.cellID = 2;
	spot3.cellID = 3;
	
	spot4.cellID = 4;
	spot5.cellID = 5;
	spot6.cellID = 6;
	spot7.cellID = 7;

	spot8.cellID = 8;
	spot9.cellID = 9;
	spot10.cellID = 10;
	spot11.cellID = 11;

	spot12.cellID = 12;
	spot13.cellID = 13;
	spot14.cellID = 14;
	spot15.cellID = 15;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
	spot0 = spot1 = spot2 = spot3 = nil;
	spot4 = spot5 = spot6 = spot7 = nil;
	spot8 = spot9 = spot10 = spot11 = nil;
	spot12 = spot13 = spot14 = spot15 = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
