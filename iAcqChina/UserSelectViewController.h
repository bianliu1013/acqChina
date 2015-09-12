//
//  UserSelectViewController.h
//  iAcqChina
//
//  Created by Dental Equipment on 1/21/15.
//  Copyright (c) 2015 iAcqChina. All rights reserved.
//

#import <UIKit/UIKit.h>




@protocol UserSelectViewCDelegate <NSObject>
@optional
// 切换到某一页图片
- (void)pickUser:(NSString*)user_name;
- (void)cancelAndExit;
@end

@interface UserSelectViewController : UIViewController
                                      <UITableViewDelegate, UITableViewDataSource>
{
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) id<UserSelectViewCDelegate> delegate;
@end
