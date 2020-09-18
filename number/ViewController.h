//
//  ViewController.h
//  number
//
//  Created by tomyhzhou on 2020/9/11.
//  Copyright © 2020 tomyhzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModificationViewController.h"
//@protocol ModificationViewControllerDelegate<NSObject>;
//
//@required
//-(void) selectedIndexPath:(NSIndexPath *)indexPathSelected changedCon:(contact *)con;
//
//@end;


@interface ViewController : UIViewController<ModificationViewControllerDelegate>
FOUNDATION_EXPORT NSString *const NOTIFICATIONFORIMAGEPATH;
//@property (nonatomic, weak) ModificationViewController *modController;

//@property (nonatomic, weak) id<ModificationViewControllerDelegate> delegate;

-(void) selectedIndexPath:(NSIndexPath *)indexPathSelected changedCon:(contact *)con;

@end

