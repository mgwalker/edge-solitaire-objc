//
//  CardSpot.m
//  Edge Solitaire
//
//  Created by Greg Walker on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "CardSpot.h"

@implementation CardSpot

@synthesize delegate;
@synthesize placeholder, placeholderFace, cardImage;
@synthesize edgeValue = _edgeValue;

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
	
	self.exclusiveTouch = YES;
	self.userInteractionEnabled = YES;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[delegate cardSpotTouched:self];
}

-(void)setCellID:(NSInteger)cellID
{
	if(cellID >= 0 && cellID < 16)
	{
		_edgeValue = 0;
		if(cellID == 0 || cellID == 3 || cellID == 12 || cellID == 15)
		{
			_edgeValue = 13;
			[self.placeholderFace removeFromSuperview];
			self.placeholderFace = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
			self.placeholderFace.image = [self imageWithName:@"KingMarker"];
			[self addSubview:self.placeholderFace];
		}
		else if(cellID == 1 || cellID == 2 || cellID == 13 || cellID == 14)
		{
			_edgeValue = 12;
			[self.placeholderFace removeFromSuperview];
			self.placeholderFace = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
			self.placeholderFace.image = [self imageWithName:@"QueenMarker"];
			[self addSubview:self.placeholderFace];
		}
		else if(cellID == 4 || cellID == 7 || cellID == 8 || cellID == 11)
		{
			_edgeValue = 11;
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

-(void)setHighlighted:(BOOL)highlighted
{
	if(highlighted != _highlighted)
	{
		self.layer.masksToBounds = NO;
		self.layer.shadowOffset = CGSizeMake(0, 0);
		if(highlighted)
		{
			self.layer.shadowRadius = 20;
			self.layer.shadowOpacity = 0.7;
			self.layer.shadowColor = [UIColor colorWithRed:1.0 green:0.5 blue:0 alpha:1].CGColor;
			self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
		}
		else
			self.layer.shadowColor = [UIColor clearColor].CGColor;
		
		_highlighted = highlighted;
		[self setNeedsDisplay];
	}
}

-(BOOL)highlighted { return _highlighted; }

-(UIImage*)imageWithName:(NSString*)imageName
{
	return [UIImage imageNamed:
			[NSString stringWithFormat:@"%@_%@", imageName, (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? @"iPad" : @"iPhone")]];
}

@end
