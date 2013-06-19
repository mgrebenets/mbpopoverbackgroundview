# MBPopoverBackgroundView


Custom `UIPopoverController` background view for iOS.
Implements custom subclass of `UIPopoverBackgroundView` as described in iOS Developer documentation

* [UIPopoverController Class Reference](https://developer.apple.com/library/ios/#documentation/UIKit/Reference/UIPopoverController_class/Reference/Reference.html#//apple_ref/occ/cl/UIPopoverController) 
* [UIPopoverBackgroundView Class Reference](https://developer.apple.com/library/ios/#documentation/UIKit/Reference/UIPopoverBackgroundView_class/Reference/Reference.html#//apple_ref/occ/cl/UIPopoverBackgroundView)
* [View Controller Catalog for iOS - Popover](https://developer.apple.com/library/ios/#documentation/WindowsViews/Conceptual/ViewControllerCatalog/Chapters/Popovers.html)
* [iPad-Specific Controllers](https://developer.apple.com/library/ios/#documentation/WindowsViews/Conceptual/ViewControllerPGforiOSLegacy/iPadControllers/iPadControllers.html)


## Examples

Call `initialize` method of `MBPopoverViewBackground` class to perform required initialization for this class and all of it's subclasses. Call this method once when the app starts.

Set your custom arrow and background images by calling `setArrowImageName:` and `setBackgroundImageName:`.

Set your custom cap insets for stretching background image with `setBackgroundImageCapInsets:`.

Define insets from the edges of content view to the edges of background view using `setContentViewInsets:` method.

	// Blue popover
	@interface MBPopoverBackgroundViewBlue : MBPopoverBackgroundView
	@end

	// When the app launches
	- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
	{

	    // Initialize
	    [MBPopoverBackgroundView initialize];

	    // Red popover with arrow
	    [MBPopoverBackgroundView setArrowImageName:@"popover-arrow-red.png"];
	    [MBPopoverBackgroundView setBackgroundImageName:@"popover-background-red.png"];
	    [MBPopoverBackgroundView setBackgroundImageCapInsets:UIEdgeInsetsMake(12, 12, 12, 12)];
	    [MBPopoverBackgroundView setContentViewInsets:UIEdgeInsetsMake(10, 10, 10, 10)]; 

	    // Blue popover with custom call-out instead of arrow
	    [MBPopoverBackgroundViewBlue setArrowImageName:@"popover-callout-dotted-blue.png"];
	    [MBPopoverBackgroundViewBlue setBackgroundImageName:@"popover-background-blue.png"];
	    [MBPopoverBackgroundViewBlue setBackgroundImageCapInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
	    [MBPopoverBackgroundViewBlue setContentViewInsets:UIEdgeInsetsMake(20, 20, 20, 20)];

	    // ***
	}

	// When creating popover in the app
	{
	    UIPopoverController *popoverCtl = ...;
	    popoverCtl.popoverBackgroundViewClass = [MBPopoverBackgroundView class];	// red
	    popoverCtl.popoverBackgroundViewClass = [MBPopoverBackgroundViewBlue class];	// or blue
	    // ***
	}

## Screenshots
![Red Popover](screenshots/red_popover.jpg)

## Video
[Video demonstration on YouTube](http://www.youtube.com/watch?feature=player_embedded&v=Kf_CavsYAD0)
