//
//  ViewController_imageBroserGroupViewController.h
//  iAcqChina
//
//  Created by Dental Equipment on 2/4/15.
//  Copyright (c) 2015 iAcqChina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoGroupViewCell.h"
#import "RNFrostedSidebar.h"
#import "ToothChartPanelSelectVC.h"

@interface ViewController_imageBroserGroupViewController : UICollectionViewController<UICollectionViewDataSource
, UICollectionViewDelegate, RNFrostedSidebarDelegate, toothChartPanelSelectViewCDelegate>

@property (nonatomic, strong) NSString* curr_patient_name;
@property (nonatomic, strong) NSString* curr_tooth_id;
@property (nonatomic, strong) NSString* curr_date;
@property NSInteger curr_show_method;  // 0 - all, 1 - patient, 2 - tooth id, 3 - date
@end
