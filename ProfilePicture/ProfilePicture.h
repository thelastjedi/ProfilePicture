//
//  ProfilePicture.h
//
//  Version: 1.0
//
//  Created by Harshita.
//  Copyright (c) 2015. All rights reserved.
//

#import "UIImageView+WebCache.h"
#import <UIKit/UIKit.h>

@interface ProfilePicture : UIView



/**
 *  Load profile picture with details of the user
 *
 *  @param image  UIImage/Image URL string/Image name
 *  @param user   Name of the user
 */
-(void)loadUserImage:(id)image forUser:(NSString*)username;





/**
 *  Optional
 */


/**
 * Customise the initials
 */
@property (nonatomic, strong) UIFont  * initialsFont;
@property (nonatomic, strong) UIColor * initialsColor;


/**
 * Set image inset to create a border around the profile picture
 * Use backgroundColor property to set the border color
 * Default value is 0
 */
@property (nonatomic, assign) CGFloat   imageInset;


/**
 * Set YES to make the profile picture square
 * Default value is NO
 */
@property (nonatomic, assign) BOOL      isSquare;


@end