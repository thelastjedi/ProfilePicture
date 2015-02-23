//
//  ProfilePicture.m
//
//  Version: 1.0
//
//  Created by Harshita.
//  Copyright (c) 2015. All rights reserved.
//

#define defaultTitle       @""
#define defaultBackground  [UIColor colorWithRed:60.0f/255.0f green:60.0f/255.0f blue:60.0f/255.0f alpha:1.0]
#define defaultTitleColor  [UIColor whiteColor]

#import "ProfilePicture.h"

@interface ProfilePicture()
{
    CGFloat  pCornerRadius;
}
@property (nonatomic, retain) UIImageView * imageView;
@property (nonatomic, retain) UILabel     * initialLabel;
@property (nonatomic, retain) UIFont      * initialFont;
@end

@implementation ProfilePicture

#pragma mark - Initialisation

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if ( self ){
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    if(!CGRectEqualToRect(frame, CGRectZero)){
        [self applyCornerRadius];
        [self adjustLabelFont];
    }
}

#pragma mark

-(void)commonInit
{
    [self setBackgroundColor: defaultBackground];
    [self addThumbnailInitials];
    [self addThumbnailImage];
}

- (void)addThumbnailInitials
{
    self.initialLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.initialLabel.backgroundColor =  [UIColor clearColor];
    self.initialLabel.textAlignment   =  NSTextAlignmentCenter;
    self.initialLabel.textColor       =  defaultTitleColor;
    self.initialLabel.font            =  [UIFont fontWithName:@"HelveticaNeue-Light"
                                                         size:0];
    
    [self addSubview:self.initialLabel];
}

- (void)addThumbnailImage
{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.imageView.backgroundColor  = [UIColor clearColor];
    self.imageView.contentMode      = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds    = YES;
    
    [self addSubview:self.imageView];
}

#pragma mark

-(void)layoutSubviews
{
    CGRect frame = CGRectInset(self.bounds, self.imageInset, self.imageInset);

    [self.initialLabel  setFrame:frame];
    [self.imageView     setFrame:frame];
}


#pragma mark - Public Method


-(void)loadUserImage:(id)image forUser:(NSString*)username
{
    //Set Initials
    self.initialLabel.text = [self getInitialsFrom:username];

    //Set Image
    if([self checkIfValid:image])
    {
        self.imageView.hidden = YES;
        return;
    }
    
    self.imageView.hidden = NO;
    
    if([image isKindOfClass:[UIImage class]])
    {
        [self.imageView setImage:image];
    }
    else if([image isKindOfClass:[NSString class]])
    {
        NSURL* url = [NSURL URLWithString:image];
        if (![self checkIfValid:url.host])
        {
            //Using SDWebImage to download images
            [self.imageView sd_setImageWithURL:url
                            placeholderImage:nil
                            completed:nil];
        }
        else
        {
            UIImage * profileImage = [UIImage imageNamed:image];
            if(profileImage)
            {
                [self.imageView setImage:profileImage];
            }
        }
    }
    else
    {
        self.imageView.hidden = YES;
    }
}


#pragma mark - Customisable properties

-(void)setInitialsColor:(UIColor *)initialsColor
{
    if (_initialsColor != initialsColor) {
        _initialsColor = initialsColor;
        self.initialLabel.textColor = initialsColor;
        [self setNeedsDisplay];
    }
}

-(void)setInitialsFont:(UIFont *)initialsFont
{
    if (_initialsFont != initialsFont) {
        _initialsFont = initialsFont;
        self.initialLabel.font = initialsFont;
        [self setNeedsDisplay];
    }
}

-(void)setIsSquare:(BOOL)isSquare
{
    if (_isSquare == isSquare)
        return;

    _isSquare = isSquare;

    CGFloat selfCornerRadius = 0;
    CGFloat imageViewCornerRadius = 0;
    
    if(!isSquare){
        selfCornerRadius = CGRectGetWidth(self.frame)/2;
        imageViewCornerRadius = CGRectGetWidth(self.imageView.frame)/2;
    }
    
    self.layer.cornerRadius = selfCornerRadius;
    self.imageView.layer.cornerRadius = imageViewCornerRadius;
}

-(CGFloat)imageInset
{
    return (_imageInset) ? _imageInset : 0;
}

#pragma mark - 
#pragma mark Private Methods

-(void)applyCornerRadius
{
    if(self.isSquare) return;
    
    pCornerRadius = MIN(CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds))/2;
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius  = pCornerRadius;
    
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius  = pCornerRadius;
}

-(void)adjustLabelFont{
    if(_initialsFont)
        return;
        
    CGFloat fontSize = MIN(CGRectGetHeight(self.frame), CGRectGetWidth(self.frame))/3;
    self.initialLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light"
                                             size:fontSize];
}

-(NSString*) getInitialsFrom: (NSString*) expandedString{
    
    NSMutableString *initials = [[NSMutableString alloc]initWithString:@""];
    
    expandedString = [expandedString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([expandedString length] == 0) {
        return defaultTitle;
    }
    
    NSArray * stringComponents = [expandedString componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    for (NSString * stringComponent in stringComponents)
    {
        if(![self checkIfValid:stringComponent])
            [initials appendString:[stringComponent substringToIndex:1]];
    }
    
    if([self checkIfValid:initials])
        return defaultTitle;
    
    return [initials uppercaseString];
}

- (BOOL)checkIfValid:(id)object
{
    return [object isEqual:[NSNull null]]
        || object == nil
        || [[NSString stringWithFormat:@"%@", object] isEqualToString:@"<null>"]
        || [[NSString stringWithFormat:@"%@", object] isEqualToString:@"(null)"]
        || [[NSString stringWithFormat:@"%@", object] isEqualToString:@""];
}

@end