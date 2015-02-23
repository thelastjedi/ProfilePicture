//
//  ViewController.m
//  ProfilePicture-Example
//
//  Created by Harshita on 07/02/15.
//  Copyright (c) 2015. All rights reserved.
//

#import "ViewController.h"
#import "ProfilePicture.h"
#import "CollectionViewCell.h"

#define cellSize (([[UIScreen mainScreen] bounds].size.height < 480.0) ? 180 : 150)

#define CGSquareSize(squareSide) CGSizeMake(squareSide, squareSide)

static NSString * const reuseIdentifier  = @"ProfileCell";

@interface ViewController ()  <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong)  UICollectionView* collectionView;
@end


@implementation ViewController

#pragma mark

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.2 green:0.7 blue:0.75 alpha:1]];
    
    [self.view addSubview:self.collectionView];
    
    // Register cell for UICollectionView
    [self.collectionView registerClass:[CollectionViewCell class]
            forCellWithReuseIdentifier:reuseIdentifier];
    
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.dataCollection count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataCollection[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary* data = self.dataCollection[indexPath.section][indexPath.item];
    
    CollectionViewCell *cell = (CollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell setupCellWith:data];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGFloat topPadding = (section < 2) ? 10 : 60;
    return UIEdgeInsetsMake(topPadding, horizontalPadding, 10, horizontalPadding);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSquareSize(cellSize);
}

#pragma mark

-(UICollectionView*)collectionView{
    if(!_collectionView){
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame
                                             collectionViewLayout:layout];

        _collectionView.delegate   = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}

-(NSArray*)dataCollection{
    return @[
             //CS
             @[
                 @{
                     @"name"         : @"Ada Lovelace",
                     @"image"        : @"https://cloud.githubusercontent.com/assets/1327490/6332095/5d228d98-bba9-11e4-8d65-41e3186ede64.jpg",
                     @"comment"      : @"Image downloaded from remote server",
                     @"h_to_w_ratio" : @(1),
                     @"square"       : @(NO),
                     },
                 @{
                     @"name"         : @"Charles Babbage",
                     @"image"        : @"",
                     @"comment"      : @"No Image",
                     @"h_to_w_ratio" : @(1),
                     @"square"       : @(NO),
                     },
                 ],
             //Phy
             @[
                 @{
                     @"name"         : @"Marie Curie",
                     @"image"        : @"",
                     @"comment"      : @"No Image",
                     @"h_to_w_ratio" : @(0.1),
                     @"square"       : @(NO),
                     },
                 @{
                     @"name"         : @"Albert Einstein",
                     @"image"        : @"Albert.jpg",
                     @"comment"      : @"Image loaded from Asset Catalog",
                     @"h_to_w_ratio" : @(0.1),
                     @"square"       : @(NO),
                     },
                 ],
             //Empty data set
             @[
                 @{
                     @"name"         : @"",
                     @"image"        : @"",
                     @"comment"      : @"Empty name and image",
                     @"h_to_w_ratio" : @(1),
                     @"square"       : @(NO),
                     },
                 @{
                     @"name"         : @"",
                     @"image"        : @"",
                     @"comment"      : @"Empty name and image\nisSquare: YES",
                     @"h_to_w_ratio" : @(1),
                     @"square"       : @(YES),
                     },
                 ],
             //
             ];
}

@end