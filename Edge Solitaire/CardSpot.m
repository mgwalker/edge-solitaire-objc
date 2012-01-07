//
//  CardSpot.m
//  Edge Solitaire
//
//  Created by Greg Walker on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CardSpot.h"

@implementation CardSpot

@synthesize cardType;

@synthesize placeholder, placeholderFace, cardImage;

-(id)init
{
	self = [super init];
	[self setup];
	return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	[self setup];
	return self;
}

-(id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	[self setup];
	return self;
}

-(void)setup
{
	self.placeholder = [[UIImageView alloc] initWithImage:[self imageWithName:@"cardspot"]]; // [UIImage imageNamed:@"cardspot_iPad"];
	[self addSubview:self.placeholder];
	
	self.backgroundColor = [UIColor clearColor];
}

-(UIImage*)imageWithName:(NSString*)imageName
{
	return [UIImage imageNamed:
			[NSString stringWithFormat:@"%@_%@", imageName, (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? @"iPad" : @"iPhone")]];
}


@end
