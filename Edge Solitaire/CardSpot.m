//
//  CardSpot.m
//  Edge Solitaire
//
//  Created by Greg Walker on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "CardSpot.h"

@interface CardSpot()

@property (retain) UIImageView* placeholder;
@property (retain) UIImageView* placeholderFace;
@property (retain) UIImageView* cardImage;

-(void)setup;
-(UIImage*)imageWithName:(NSString*)imageName;

@end

@implementation CardSpot

//@synthesize delegate;
//@synthesize placeholder, placeholderFace, cardImage;
//@synthesize edgeValue = _edgeValue;

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
	
	_requiredCardValue = 0;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.delegate cardSpotTouched:self];
}

-(void)setRequiredValue:(CardValue)cardValue
{
	// We only support face cards for required values.
	if(cardValue == CardValueJack || cardValue == CardValueQueen || cardValue == CardValueKing)
	{
		[self.placeholderFace removeFromSuperview];
		self.placeholderFace = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
		
		switch(cardValue)
		{
			case CardValueJack:
				self.placeholderFace.image = [self imageWithName:@"JackMarker"];
				break;
				
			case CardValueQueen:
				self.placeholderFace.image = [self imageWithName:@"QueenMarker"];
				break;
				
			case CardValueKing:
				self.placeholderFace.image = [self imageWithName:@"KingMarker"];
				break;
				
			default:
				break;
		}
		
		[self addSubview:self.placeholderFace];
		
		_requiredCardValue = cardValue;
	}
}

-(void)setRequiredValue:(CardValue)cardValue withRequiredSuit:(CardSuit)suit
{
	[self setRequiredValue:cardValue];
	_requiredCardSuit = suit;
}

-(CardValue)requiredCardValue
{
	return _requiredCardValue;
}

-(CardSuit)requiredCardSuit
{
	return _requiredCardSuit;
}

-(void)setCard:(Card *)card
{
	[self.cardImage removeFromSuperview];
	if(card != nil)
	{
		NSString *cardName = [NSString stringWithFormat:@"%@%i", card.suitFirstCharacter, card.value];
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
			self.layer.borderWidth = 7;
			self.layer.borderColor = [UIColor redColor].CGColor;
			self.layer.shadowRadius = 20;
			self.layer.shadowOpacity = 0.7;
			self.layer.shadowColor = [UIColor redColor].CGColor;
			self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
		}
		else
		{
			self.layer.borderWidth = 0;
			self.layer.shadowColor = [UIColor clearColor].CGColor;
		}
		
		_highlighted = highlighted;
		[self setNeedsDisplay];
	}
}

-(BOOL)highlighted { return _highlighted; }

-(UIImage*)imageWithName:(NSString*)imageName
{
	// This should be eliminated.  Rename all the images to use the ~device
	// nomenclature and let the OS handle it.  E.g., "JackMarker~ipad" and
	// "JackMarker~iphone".
	return [UIImage imageNamed:
			[NSString stringWithFormat:@"%@_%@", imageName, (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? @"iPad" : @"iPhone")]];
}

@end
