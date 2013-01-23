//
//  CardSpot.h
//  Edge Solitaire
//
//  Created by Greg Walker on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@protocol CardSpotDelegate;

typedef enum
{
	EdgeGameModeEasy,
	EdgeGameModeNormal,
	EdgeGameModeHard
} EdgeGameMode;

@interface CardSpot : UIView
{
	NSInteger _cellID;
	NSInteger _edgeValue;
	Card* _card;
	BOOL _highlighted;
}

-(void)setCellID:(NSInteger)cellID forGameMode:(EdgeGameMode)mode;

@property (retain) id<CardSpotDelegate> delegate;
@property (readonly) NSInteger edgeValue;
@property (retain) Card* card;
@property (assign) BOOL highlighted;

@end

@interface CardSpot()

@property (retain) UIImageView* placeholder;
@property (retain) UIImageView* placeholderFace;
@property (retain) UIImageView* cardImage;

-(void)setup;
-(UIImage*)imageWithName:(NSString*)imageName;

@end

@protocol CardSpotDelegate
-(void)cardSpotTouched:(CardSpot*)cardSpot;
@end