//
//  PhotoViewCell.h
//  iAcqChina
//
//  Created by Dental Equipment on 12/27/14.
//  Copyright (c) 2014 iAcqChina. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhotoGroupViewCellDelegate;


@interface PhotoGroupViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *group_image;
@property (weak, nonatomic) IBOutlet UILabel *group_label;


@property (nonatomic, weak) id<PhotoGroupViewCellDelegate> delegate;

//@property (nonatomic, assign) NSUInteger currentPhotoIndex;
@end


@protocol PhotoGroupViewCellDelegate <NSObject>
@optional
//- (void)onCloseClicked;
- (void)onCloseClicked:(PhotoGroupViewCell *)photoGroupViewCell andIndex:(NSUInteger)index;
@end
