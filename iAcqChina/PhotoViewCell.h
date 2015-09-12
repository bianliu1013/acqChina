//
//  PhotoViewCell.h
//  iAcqChina
//
//  Created by Dental Equipment on 12/27/14.
//  Copyright (c) 2014 iAcqChina. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhotoViewCellDelegate;


@interface PhotoViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *dental_image;
@property (weak, nonatomic) IBOutlet UILabel *dental_label;

@property (weak, nonatomic) IBOutlet UIButton *close_btn;
@property (weak, nonatomic) IBOutlet UILabel *dental_date;
@property (strong, nonatomic) NSString* uuid;

@property (nonatomic, weak) id<PhotoViewCellDelegate> delegate;

@property (nonatomic, assign) NSUInteger currentPhotoIndex;
@end


@protocol PhotoViewCellDelegate <NSObject>
@optional
//- (void)onCloseClicked;
- (void)onCloseClicked:(PhotoViewCell *)photoViewCell;
@end
