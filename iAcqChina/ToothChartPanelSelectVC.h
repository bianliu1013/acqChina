//
//  ToothChartPanelSelectViewController.h
//  iAcqChina
//
//  Created by Dental Equipment on 1/25/15.
//  Copyright (c) 2015 iAcqChina. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol toothChartPanelSelectViewCDelegate <NSObject>
@optional
- (void)pickToothFromToothPanel: (NSInteger)tooth_id;
@end



@interface ToothChartPanelSelectViewController : UIViewController

@property (nonatomic, weak) id<toothChartPanelSelectViewCDelegate> delegate;
@end
