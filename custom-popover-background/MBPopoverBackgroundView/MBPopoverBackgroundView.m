//
//  MBPopoverBackgroundView.m
//  i4nApps
//
//  Created by Grebenets Maksym on 8/02/12.
//  Copyright (c) 2012 i4nApps. All rights reserved.
//

#import "MBPopoverBackgroundView.h"

@interface MBPopoverBackgroundView ()

// custom values storage
+ (id)customValueForKey:(NSString *)key;
+ (void)setCustomValue:(id)value forKey:(NSString *)key;
    
// custom values getters
+ (NSString *)arrowImageName;
+ (NSString *)backgroundImageName;
+ (UIEdgeInsets)backgroundImageCapInsets;

// arrow direction and offest - required for UIPopoverBackgroundView subclassing
@property (nonatomic, readwrite) UIPopoverArrowDirection arrowDirection;
@property (nonatomic, readwrite) CGFloat arrowOffset;

// configuration
- (void)configure;
- (void)addObservers;
- (void)removeObservers;

// background and arrow image views
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *arrowImageView;
@end


@implementation MBPopoverBackgroundView

// MUST have these two, or it'll crash!
@synthesize arrowDirection = _arrowDirection;
@synthesize arrowOffset = _arrowOffset;

#pragma mark - Class Initialize and Cleanup

// static
__strong static NSMutableDictionary *CustomValuesDic = nil;

// initialize
+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CustomValuesDic = [NSMutableDictionary dictionaryWithCapacity:4];
    });
}

// cleanup
+ (void)cleanup {
    CustomValuesDic = nil;
}


#pragma mark - Storage for Class Custom Values
/*
 * Current implementation uses static dictionary for storage
 * These methods may be customized to use any other storage, e.g. user defaults, file system, etc
 */

// get
+ (id)customValueForKey:(NSString *)key {
    // Note: override/modify this method to use different storage
    return [CustomValuesDic valueForKey:key];
}

// set
+ (void)setCustomValue:(id)value forKey:(NSString *)key {
    // Note: override/modify this method to use different storage
    CustomValuesDic[key] = value;
}

#pragma mark - Arrow and Background Image Customization
// Helper methods - make user defaults key using class name
+ (NSString *)arrowImageNameKey {
    // use class name to make key for arrow image name in user defaults
    return [NSString stringWithFormat:@"%@::ArrowImageName", NSStringFromClass(self.class)];
}

+ (NSString *)backgroundImageNameKey {
    // use class name to make key for background image name in user defaults    
    return [NSString stringWithFormat:@"%@::BackgroundImageName", NSStringFromClass(self.class)];
}

// getters
+ (NSString *)arrowImageName {
    return [self.class customValueForKey:self.class.arrowImageNameKey];
}

+ (NSString *)backgroundImageName {
    return [self.class customValueForKey:self.class.backgroundImageNameKey];
}

// setters
+ (void)setArrowImageName:(NSString *)imageName {
    [self.class setCustomValue:imageName forKey:self.class.arrowImageNameKey];
}

+ (void)setBackgroundImageName:(NSString *)imageName {
    [self.class setCustomValue:imageName forKey:self.class.backgroundImageNameKey];
}

#pragma mark - Background Image Cap Insets
/* 
 * Background image cap insets used for background image stretching
 */

// helper to make user defaults key
+ (NSString *)backgroundImageCapInsetsKey {
    // use class name to make user defaults key for bg image cap insets
    return [NSString stringWithFormat:@"%@::BackgroundImageCapInsets", NSStringFromClass(self.class)];    
}

+ (void)setBackgroundImageCapInsets:(UIEdgeInsets)capInsets {
    // save bg image cap insets to user defaults
    [self.class setCustomValue:[NSValue valueWithUIEdgeInsets:capInsets]  forKey:self.class.backgroundImageCapInsetsKey];
}

+ (UIEdgeInsets)backgroundImageCapInsets {
    return [[self.class customValueForKey:self.class.backgroundImageCapInsetsKey] UIEdgeInsetsValue];
}

#pragma mark - Content View Insets Customization
+ (NSString *)contentViewInsetsKey {
    return [NSString stringWithFormat:@"%@::ContentViewInsetsKey", NSStringFromClass(self.class)];    
}

// setter
+ (void)setContentViewInsets:(UIEdgeInsets)insets {
    // set insets for this class to user defaults    
    [self.class setCustomValue:[NSValue valueWithUIEdgeInsets:insets]  forKey:self.class.contentViewInsetsKey];    
}

#pragma mark - Methods of UIPopoverBackgroundView
// arrow base
+ (CGFloat)arrowBase {
    // return base of custom arrow for this class - just use image size
    return [UIImage imageNamed:self.class.arrowImageName].size.width;
}

// arrow height
+ (CGFloat)arrowHeight {
    // return height of custrom arrow for this class - just use image size
    return [UIImage imageNamed:self.class.arrowImageName].size.height;
}

// content view insets
+ (UIEdgeInsets)contentViewInsets {
    // get insets for this class from user defaults
    return [[self.class customValueForKey:self.class.contentViewInsetsKey] UIEdgeInsetsValue];
}

#pragma mark - View Lifecycle

// configure view during initialization
- (void)configure {
    
    [self addObservers];
    
    UIEdgeInsets bgCapInsets = self.class.backgroundImageCapInsets;
    UIImage *bgImage = [[UIImage imageNamed:self.class.backgroundImageName] resizableImageWithCapInsets:bgCapInsets];
    self.backgroundImageView = [[UIImageView alloc] initWithImage:bgImage];
    
    UIImage *arrowImage = [UIImage imageNamed:self.class.arrowImageName];
    self.arrowImageView = [[UIImageView alloc] initWithImage:arrowImage];
    
    [self addSubview:_backgroundImageView];
    [self addSubview:_arrowImageView];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    [self configure];
    return self;
}

- (id)init {
    self = [super init];
    if (!self) return nil;
    [self configure];
    return self;
}

- (void)dealloc {
    [self removeObservers];    
}

#pragma mark - KVO
- (void)addObservers {
    [self addObserver:self forKeyPath:@"arrowDirection" options:0 context:nil];
    [self addObserver:self forKeyPath:@"arrowOffset" options:0 context:nil];    
}

- (void)removeObservers {
    [self removeObserver:self forKeyPath:@"arrowDirection"];
    [self removeObserver:self forKeyPath:@"arrowOffset"];    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context 
{
    if ([keyPath isEqualToString:@"arrowDirection"]) {
        [self setNeedsLayout];  // trigger subviews layout
    }
    
    if ([keyPath isEqualToString:@"arrowOffset"]) {
        [self setNeedsLayout];  // trigger subviews layout
    }
}

#pragma mark - Subviews Layout
// layout subviews - triggered by setNeedsLayout
- (void)layoutSubviews {
    // layout background and arrow images, properly strectching them

    // background image
    CGRect bgRect = self.bounds;
    // use arrow direction to find out which side to "cut"
    // first, account for arrow height or width
    BOOL cutWidth = (self.arrowDirection == UIPopoverArrowDirectionLeft || self.arrowDirection == UIPopoverArrowDirectionRight);
    bgRect.size.width -= cutWidth * [self.class arrowHeight];
    BOOL cutHeight = (self.arrowDirection == UIPopoverArrowDirectionUp || self.arrowDirection == UIPopoverArrowDirectionDown);
    bgRect.size.height -= cutHeight * [self.class arrowHeight];

    // next, adjust the origin, needed only if arrow points down or left
    if (self.arrowDirection == UIPopoverArrowDirectionUp) {
        bgRect.origin.y += [self.class arrowHeight];    
    } else if (self.arrowDirection == UIPopoverArrowDirectionLeft) {
        bgRect.origin.x += [self.class arrowHeight];
    }
    
    // finally set the new rect
    _backgroundImageView.frame = bgRect;

    // ???: set new image with capInsets if needed
    // so far it looks good when keyboard appears and resizes popover
    // the cap insets seem to apply when image is resized
    
    // next - arrow image, use direction and arrow offset to position it properly
    // also apply proper transformation to flip and rotate arrow when needed
    // note: first apply transformation, then calculate arrow frame origin
    CGRect arrowRect = CGRectZero;
    UIEdgeInsets bgCapInsets = [self.class backgroundImageCapInsets];
    switch (self.arrowDirection) {
        case UIPopoverArrowDirectionUp:
            _arrowImageView.transform = CGAffineTransformMakeScale(1, 1);   // original transformation (identity matrix)            
            // get the frame (not bounds! because bounds ignore transformations)
            arrowRect = _arrowImageView.frame;  // get frame after (!) transformation
            arrowRect.origin.x = self.bounds.size.width / 2 + self.arrowOffset - arrowRect.size.width / 2;
            arrowRect.origin.y = 0;
            // popovers are usually not scaled down by x, so no need to account for that now
            break;
        case UIPopoverArrowDirectionDown:
            _arrowImageView.transform = CGAffineTransformMakeScale(1, -1);  // flip vertically 
            // get the frame (not bounds! because bounds ignore transformations)
            arrowRect = _arrowImageView.frame;  // get frame after (!) transformation
            arrowRect.origin.x = self.bounds.size.width / 2 + self.arrowOffset - arrowRect.size.width / 2;            
            arrowRect.origin.y = self.bounds.size.height - arrowRect.size.height;                           
            // popovers are usually not scaled down by x, so no need to account for that now            
            break;
        case UIPopoverArrowDirectionLeft:
            _arrowImageView.transform = CGAffineTransformMakeRotation(-M_PI_2); // rotate counter clock-wise
            // get the frame (not bounds! because bounds ignore transformations)
            arrowRect = _arrowImageView.frame;  // get frame after (!) transformation
            arrowRect.origin.x = 0;      
            arrowRect.origin.y = self.bounds.size.height / 2 + self.arrowOffset - arrowRect.size.height / 2;    
            // final adjustment - check that the arrow is not left below popover (happens when keyboard is shown)
            // and account for background image cap insets to make it look good for rounded corners
            arrowRect.origin.y = fminf(self.bounds.size.height - arrowRect.size.height - bgCapInsets.bottom, arrowRect.origin.y);
            // also, make sure it's not and fits right background cap instes
            arrowRect.origin.y = fmaxf(bgCapInsets.top, arrowRect.origin.y);
            break;
        case UIPopoverArrowDirectionRight:
            _arrowImageView.transform = CGAffineTransformMakeRotation(M_PI_2);  // rotate clock-wise
            // get the frame (not bounds! because bounds ignore transformations)
            arrowRect = _arrowImageView.frame;  // get frame after (!) transformation
            arrowRect.origin.x = self.bounds.size.width - arrowRect.size.width;      
            arrowRect.origin.y = self.bounds.size.height / 2 + self.arrowOffset - arrowRect.size.height / 2;   
            // final adjustment - check that the arrow is not left below popover (happens when keyboard is shown)            
            arrowRect.origin.y = fminf(self.bounds.size.height - arrowRect.size.height  - bgCapInsets.bottom, arrowRect.origin.y);
            // also, make sure it's not above popover and fits right background cap instes
            arrowRect.origin.y = fmaxf(bgCapInsets.top, arrowRect.origin.y);            
            break;
            
        default:
            break;
    }
    
    // apply the frame to arrow image view
    _arrowImageView.frame = arrowRect;
}

@end
