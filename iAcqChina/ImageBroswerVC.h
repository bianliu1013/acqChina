//
//  ViewController.h
//  iAcqChina
//
//  Created by Dental Equipment on 12/15/14.
//  Copyright (c) 2014 iAcqChina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJPhotoBrowser.h"
#import "PhotoViewCell.h"
#import "ImageModel.h"
#import "RNFrostedSidebar.h"
#import "UserSelectViewController.h"
#import "toothSelectVC.h"
#import "ToothChartPanelSelectVC.h"


@interface ViewControllerImageBrowser : UIViewController <UITextFieldDelegate, MJPhotoBrowserDelegate,
UICollectionViewDataSource, UICollectionViewDelegate, PhotoViewCellDelegate, RNFrostedSidebarDelegate, UserSelectViewCDelegate, toothSelectViewCDelegate, toothChartPanelSelectViewCDelegate>
{
}



@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *btn_edit_image;

@property (nonatomic, assign) BOOL NeedUpdateAfterCapturedImages;

@property (nonatomic, strong) NSString* curr_patient_name;
@property (nonatomic, strong) NSString* curr_tooth_id;
@property (nonatomic, strong) NSString* curr_date;
@property NSInteger curr_show_method;  // 0 - all, 1 - patient, 2 - tooth id, 3 - date
@end
