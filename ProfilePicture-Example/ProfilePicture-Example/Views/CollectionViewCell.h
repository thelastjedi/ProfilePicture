//
//  CollectionViewCell.h
//  ProfilePicture-Example
//
//  Created by Harshita on 10/02/15.
//  Copyright (c) 2015 Harshita. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ProfilePicture.h"

#define horizontalPadding 3

@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) ProfilePicture * profilePic;

@property (nonatomic, strong) UILabel   *   nameLabel;
@property (nonatomic, strong) UILabel   *   commentLabel;

/**
 *  Just to experiment with different frame sizes
**/
@property (nonatomic, assign) CGFloat       h_w_ratio;

-(void)setupCellWith:(NSDictionary*)cellData;

@end
