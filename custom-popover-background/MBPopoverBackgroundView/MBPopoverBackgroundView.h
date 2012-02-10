//
//  MBPopoverBackgroundView.h
//  monkeybars
//
//  Created by Grebenets Maksym on 8/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIPopoverBackgroundView.h>

@interface MBPopoverBackgroundView : UIPopoverBackgroundView

// popover background customization
+ (void)initialize;
+ (void)cleanup;
+ (void)setArrowImageName:(NSString *)imageName;
+ (void)setBackgroundImageName:(NSString *)imageName;
+ (void)setBackgroundImageCapInsets:(UIEdgeInsets)capInsets;
+ (void)setContentViewInsets:(UIEdgeInsets)insets;


@end
