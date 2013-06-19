//
//  MBPopoverBackgroundView.h
//  i4nApps
//
//  Created by Grebenets Maksym on 8/02/12.
//  Copyright (c) 2012 i4nApps. All rights reserved.
//

#import <UIKit/UIPopoverBackgroundView.h>

/**
 * Sublass of `UIPopoverBackgroundView` that allows customization of iOS popover look & feel.
 * @abstract Use your own images for popover arrow and background, define your custom background image cap insets and content view edge insets.
 * 
 * Implemented per iOS Developer documentation
 * - [UIPopoverController Class Reference](https://developer.apple.com/library/ios/#documentation/UIKit/Reference/UIPopoverController_class/Reference/Reference.html#//apple_ref/occ/cl/UIPopoverController)
 * - [UIPopoverBackgroundView Class Reference](https://developer.apple.com/library/ios/#documentation/UIKit/Reference/UIPopoverBackgroundView_class/Reference/Reference.html#//apple_ref/occ/cl/UIPopoverBackgroundView)
 * - [View Controller Catalog for iOS - Popover](https://developer.apple.com/library/ios/#documentation/WindowsViews/Conceptual/ViewControllerCatalog/Chapters/Popovers.html)
 * - [iPad-Specific Controllers](https://developer.apple.com/library/ios/#documentation/WindowsViews/Conceptual/ViewControllerPGforiOSLegacy/iPadControllers/iPadControllers.html)
 */
@interface MBPopoverBackgroundView : UIPopoverBackgroundView

/**
 * Performs initialization required to use instances of `MBPopoverBackgroundView` and its subclasses.
 * An app needs to call it only once.
 */
+ (void)initialize;

/**
 * Cleanup after `MBPopoverBackgroundView`. Use when the app is terminating.
 */
+ (void)cleanup;

/**
 * Set your custom image for popover arrow.
 * @param imageName name of the arrow image
 */
+ (void)setArrowImageName:(NSString *)imageName;

/**
 * Set your custom image for popover background.
 * @abstract It's recommended to use strechable image with no gradient or other effects.
 * @param imageName name of the background image
 */
+ (void)setBackgroundImageName:(NSString *)imageName;

/**
 * Set your custom background image cap insets. Used for stretching background image.
 * @param capInsets cap insets used for stretching background image
 */
+ (void)setBackgroundImageCapInsets:(UIEdgeInsets)capInsets;

/**
 * Set your custom content view insets. Used to define insets from the edges of content view to the edges of background view.
 * @param insets insets from the edges of content view to the edges of background view
 */
+ (void)setContentViewInsets:(UIEdgeInsets)insets;


@end
