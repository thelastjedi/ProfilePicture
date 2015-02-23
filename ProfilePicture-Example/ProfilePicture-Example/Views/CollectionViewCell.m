//
//  CollectionViewCell.m
//  ProfilePicture-Example
//
//  Created by Harshita on 10/02/15.
//  Copyright (c) 2015 Harshita. All rights reserved.
//
#import "CollectionViewCell.h"

#define labelsize 40
#define cellFontWithSize  UIFont fontWithName:@"HelveticaNeue-Light" size

@implementation CollectionViewCell
@synthesize profilePic;
@synthesize nameLabel;
@synthesize commentLabel;
@synthesize h_w_ratio;

- (id)initWithFrame:(CGRect)aRect
{
    self = [super initWithFrame:aRect];
    {
        self.backgroundColor = [UIColor clearColor];
        
        nameLabel = [self cellLabelForFontSize:18];
        nameLabel.frame = CGRectZero;
        [self.contentView addSubview:nameLabel];
        
        profilePic = [[ProfilePicture alloc] init];
        profilePic.imageInset  = 2;
        [self.contentView addSubview:profilePic];
        
        commentLabel = [self cellLabelForFontSize:15];
        commentLabel.frame = CGRectZero;
        [self.contentView addSubview:commentLabel];

    }
    return self;
}

-(void)layoutSubviews{

    CGRect aRect = self.bounds;

    nameLabel.frame = CGRectMake(0, 0, CGRectGetWidth(aRect), labelsize);
    
    CGRect picFrame = aRect;
    
    picFrame = CGRectInset(picFrame, labelsize, labelsize*h_w_ratio);
    picFrame.origin.y = CGRectGetHeight(nameLabel.frame);

    [profilePic setFrame:picFrame];
    
    commentLabel.frame = CGRectMake(horizontalPadding, CGRectGetMaxY(profilePic.frame), CGRectGetWidth(aRect) - 2*horizontalPadding, labelsize);
}

-(UILabel*)cellLabelForFontSize:(int)fontSize{

    UILabel * label       = [[UILabel alloc] init];
    label.numberOfLines   = 0;
    label.textAlignment   = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.font            = [cellFontWithSize:fontSize];
    label.textColor       = [UIColor colorWithRed: 248/255 green: 244/255 blue: 228/255 alpha:1];
    
    label.adjustsFontSizeToFitWidth = YES;
    return label;
}

#pragma mark - Public Method

-(void)setupCellWith:(NSDictionary*)cellData;
{
    self.nameLabel.text = cellData[@"name"];
    
    self.h_w_ratio  = [cellData[@"h_to_w_ratio"] floatValue];
    
    [self.profilePic setIsSquare: [cellData[@"square"] boolValue]];
    
    if([cellData[@"square"] boolValue])
        [self.profilePic setBackgroundColor:[UIColor colorWithRed:60.0f/255.0f
                                                            green:60.0f/255.0f
                                                             blue:90.0f/255.0f
                                                            alpha:1]];
    
    [self.profilePic loadUserImage:cellData[@"image"] forUser:cellData[@"name"]];
    [self.profilePic setInitialsFont:[cellFontWithSize:23]];
    
    self.commentLabel.text = cellData[@"comment"];
}

@end