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
	self.placeholder = [[UIImageView alloc] initWithImage:[self imageWithName:@"cardspot"]];
	[self addSubview:self.placeholder];

	self.backgroundColor = [UIColor clearColor];
}

-(UIImage*)imageWithName:(NSString*)imageName
{
	return [UIImage imageNamed:
			[NSString stringWithFormat:@"%@_%@", imageName, (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? @"iPad" : @"iPhone")]];
}

-(void)setCellID:(NSInteger)cellID
{
	if(cellID >= 0 && cellID < 16)
	{		
		if(cellID == 0 || cellID == 3 || cellID == 12 || cellID == 15)
		{
			[self.placeholderFace removeFromSuperview];
			self.placeholderFace = [[UIImageView alloc] initWithImage:[self imageWithName:@"KingMarker"]];
			[self addSubview:self.placeholderFace];
		}
		else if(cellID == 1 || cellID == 2 || cellID == 13 || cellID == 14)
		{
			[self.placeholderFace removeFromSuperview];
			self.placeholderFace = [[UIImageView alloc] initWithImage:[self imageWithName:@"QueenMarker"]];
			[self addSubview:self.placeholderFace];
		}
		else if(cellID == 4 || cellID == 7 || cellID == 8 || cellID == 11)
		{
			[self.placeholderFace removeFromSuperview];
			self.placeholderFace = [[UIImageView alloc] initWithImage:[self imageWithName:@"JackMarker"]];
			[self addSubview:self.placeholderFace];
		}

		_cellID = cellID;
	}
}

-(NSInteger)cellID
{
	return _cellID;
}

@end
