//
//  DifficultyViewController.h
//  Edge Solitaire
//
//  Created by Greg on 7/6/13.
//
//

#import <UIKit/UIKit.h>
#import "CardSpot.h"

@interface DifficultyViewController : UIViewController

-(id)initWithCallback:(void(^)(EdgeGameMode))callback;

@end
