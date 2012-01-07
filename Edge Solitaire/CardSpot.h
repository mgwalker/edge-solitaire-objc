//
//  CardSpot.h
//  Edge Solitaire
//
//  Created by Greg Walker on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIUniversalViewController.h"

@interface CardSpot : UIView

@property (assign) NSString* cardType;

@end

@interface CardSpot()

@property (retain) UIImageView* placeholder;
@property (retain) UIImageView* placeholderFace;
@property (retain) UIImageView* cardImage;

-(void)setup;
-(UIImage*)imageWithName:(NSString*)imageName;

@end