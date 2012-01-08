//
//  CardSpot.h
//  Edge Solitaire
//
//  Created by Greg Walker on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIUniversalViewController.h"
#import "Card.h"

@interface CardSpot : UIView
{
	NSInteger _cellID;
	Card* _card;
}

@property (assign) NSInteger cellID;
@property (retain) Card* card;

@end

@interface CardSpot()

@property (retain) UIImageView* placeholder;
@property (retain) UIImageView* placeholderFace;
@property (retain) UIImageView* cardImage;

-(void)setup;
-(UIImage*)imageWithName:(NSString*)imageName;

@end