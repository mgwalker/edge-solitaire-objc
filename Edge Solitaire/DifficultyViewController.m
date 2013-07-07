//
//  DifficultyViewController.m
//  Edge Solitaire
//
//  Created by Greg on 7/6/13.
//
//

#import <QuartzCore/QuartzCore.h>
#import "DifficultyViewController.h"

@interface DifficultyViewController ()
{
	void(^_callback)(EdgeGameMode);
}

@property (retain) IBOutlet UILabel *header;

@property (retain) IBOutlet UIView *mode1;
@property (retain) IBOutlet UIView *mode2;
@property (retain) IBOutlet UIView *mode3;

@property (retain) IBOutlet UILabel *mode1header;
@property (retain) IBOutlet UILabel *mode2header;
@property (retain) IBOutlet UILabel *mode3header;

@property (retain) IBOutlet UILabel *mode1description;
@property (retain) IBOutlet UILabel *mode2description;
@property (retain) IBOutlet UILabel *mode3description;

@end

@implementation DifficultyViewController

-(id)initWithCallback:(void (^)(EdgeGameMode))callback
{
	self = [super initWithNibName:@"DifficultyView" bundle:nil];
	if(self)
	{
		_callback = [callback copy];
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	NSString *fontName = @"Futurama_Bold_Font";
	self.header.font = [UIFont fontWithName:fontName size:self.header.font.pointSize];
	
	self.mode1.layer.cornerRadius = 10;
	self.mode1.layer.masksToBounds = YES;
	self.mode2.layer.cornerRadius = 10;
	self.mode2.layer.masksToBounds = YES;
	self.mode3.layer.cornerRadius = 10;
	self.mode3.layer.masksToBounds = YES;
	
	self.mode1header.font = [UIFont fontWithName:fontName size:self.mode1header.font.pointSize];
	self.mode2header.font = [UIFont fontWithName:fontName size:self.mode2header.font.pointSize];
	self.mode3header.font = [UIFont fontWithName:fontName size:self.mode3header.font.pointSize];
	
	[self.mode1description sizeToFit];
	[self.mode2description sizeToFit];
	[self.mode3description sizeToFit];
	
	[self.mode1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedGameMode:)]];
	[self.mode2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedGameMode:)]];
	[self.mode3 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedGameMode:)]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tappedGameMode:(UIGestureRecognizer*)recognizer
{
	UIView *tapped = recognizer.view;
	EdgeGameMode mode = EdgeGameModeNormal;
	
	if(tapped == self.mode1)
		mode = EdgeGameModeEasy;
	else if(tapped == self.mode2)
		mode = EdgeGameModeNormal;
	else if(tapped == self.mode3)
		mode = EdgeGameModeHard;
	
	if(_callback)
		_callback(mode);
}

@end
