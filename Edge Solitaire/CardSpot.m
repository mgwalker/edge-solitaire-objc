//
//  CardSpot.m
//  Edge Solitaire
//
//  Created by Greg Walker on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CardSpot.h"

@implementation CardSpot

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
	self.placeholder = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
	self.placeholder.image = [self imageWithName:@"cardspot"];
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
			self.placeholderFace = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
			self.placeholderFace.image = [self imageWithName:@"KingMarker"];
			[self addSubview:self.placeholderFace];
		}
		else if(cellID == 1 || cellID == 2 || cellID == 13 || cellID == 14)
		{
			[self.placeholderFace removeFromSuperview];
			self.placeholderFace = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
			self.placeholderFace.image = [self imageWithName:@"QueenMarker"];
			[self addSubview:self.placeholderFace];
		}
		else if(cellID == 4 || cellID == 7 || cellID == 8 || cellID == 11)
		{
			[self.placeholderFace removeFromSuperview];
			self.placeholderFace = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
			self.placeholderFace.image = [self imageWithName:@"JackMarker"];
			[self addSubview:self.placeholderFace];
		}

		_cellID = cellID;
	}
}

-(NSInteger)cellID
{
	return _cellID;
}

-(void)setCard:(Card *)card
{
	[self.cardImage removeFromSuperview];
	if(card != nil)
	{
		NSString* cardName = @"";
		switch(card.suit)
		{
			case CardSuitClub:
				cardName = @"C";
				break;
				
			case CardSuitDiamond:
				cardName = @"D";
				break;
				
			case CardSuitHeart:
				cardName = @"H";
				break;
				
			case CardSuitSpade:
			default:
				cardName = @"S";
				break;
		}
		
		cardName = [NSString stringWithFormat:@"%@%i", cardName, card.value];
		self.cardImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
		self.cardImage.image = [self imageWithName:cardName];
		[self addSubview:self.cardImage];
	}
	_card = card;
}

-(Card*)card
{
	return _card;
}

@end
