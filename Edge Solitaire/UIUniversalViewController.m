//
//  UIUniversalViewController.m
//  Edge Solitaire
//
//  Created by Greg Walker on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIUniversalViewController.h"

@implementation UIUniversalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	NSString* viewName = nil;
	if(nibNameOrNil)
		viewName = [NSString stringWithFormat:@"%@_%@", nibNameOrNil, (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? @"iPad" : @"iPhone")];
	
    self = [super initWithNibName:viewName bundle:nibBundleOrNil];
    return self;
}
@end
