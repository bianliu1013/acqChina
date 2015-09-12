//
//  toothSelectViewController.h
//  iAcqChina
//
//  Created by Dental Equipment on 1/22/15.
//  Copyright (c) 2015 iAcqChina. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol toothSelectViewCDelegate <NSObject>
@optional
- (void)pickTooth: (NSInteger)tooth_id;
@end



@interface toothSelectViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource>
{
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) id<toothSelectViewCDelegate> delegate;
@end
