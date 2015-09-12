//
//  NavigationViewController.m
//  REMenuExample
//
//  Created by Roman Efimov on 4/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//
//  Sample icons from http://icons8.com/download-free-icons-for-ios-tab-bar
//

#import "NavigationViewController.h"
#import "ImageBroswerGroupVC.h"
#import "ToothChartPanelSelectVC.h"

#import "toothSelectVC.h"
#import "UserSelectViewController.h"


@interface NavigationViewController () <REMenuDelegate>

@property (strong, readwrite, nonatomic) REMenu *menu;

@property (strong, nonatomic) ViewController_imageBroserGroupViewController* dateGroup;
@property (strong, nonatomic) ToothChartPanelSelectViewController* toothGroup;

@end

@implementation NavigationViewController

- (void) showHome
{
    _dateGroup = [self.storyboard instantiateViewControllerWithIdentifier:@"imageViewByDateGroup"];
    
    __typeof (self) __weak weakSelf = self;
    [weakSelf setViewControllers:@[_dateGroup] animated:NO];
//    NSMutableArray * viewControllers = [self.navigationController.viewControllers mutableCopy];
//    [viewControllers removeLastObject];
//    [viewControllers addObject:_homeViewController];
//    [self setViewControllers:viewControllers animated:YES];
}

- (void) showExplorer
{
    _toothGroup = [self.storyboard instantiateViewControllerWithIdentifier:@"tooth_chart_panle_select_view"];
    
    __typeof (self) __weak weakSelf = self;
    [weakSelf setViewControllers:@[_toothGroup] animated:NO];
//    NSMutableArray * viewControllers = [self.navigationController.viewControllers mutableCopy];
//    [viewControllers removeLastObject];
//    [viewControllers addObject:_explorerViewContorler];
//    [self setViewControllers:viewControllers animated:YES];
}


- (void)viewDidLoad
{
    _dateGroup = [self.storyboard instantiateViewControllerWithIdentifier:@"imageViewByDateGroup"];
    _toothGroup = [self.storyboard instantiateViewControllerWithIdentifier:@"tooth_chart_panle_select_view"];
    
    [super viewDidLoad];
    if (REUIKitIsFlatMode()) {
        //[self.navigationBar performSelector:@selector(setBarTintColor:) withObject:[UIColor colorWithRed:0/255.0 green:213/255.0 blue:161/255.0 alpha:1]];
        [self.navigationBar performSelector:@selector(setBarTintColor:) withObject:[UIColor lightGrayColor]];
        self.navigationBar.tintColor = [UIColor darkGrayColor];
    } else {
        //self.navigationBar.tintColor = [UIColor colorWithRed:0 green:179/255.0 blue:134/255.0 alpha:1];
        self.navigationBar.tintColor = [UIColor darkGrayColor];
    }

    __typeof (self) __weak weakSelf = self;
    REMenuItem *homeItem = [[REMenuItem alloc] initWithTitle:@"Date"
                                                    subtitle:@"Show date group"
                                                       image:[UIImage imageNamed:@"menu_date"]
                                            highlightedImage:nil
                                                      action:^(REMenuItem *item) {
                                                          NSLog(@"Item: %@", item);
                                                          [self showHome];
                                                      }];
    
    REMenuItem *exploreItem = [[REMenuItem alloc] initWithTitle:@"Tooth"
                                                       subtitle:@"Show Tooth group"
                                                          image:[UIImage imageNamed:@"menu_tooth"]
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             NSLog(@"Item: %@", item);
                                                             [self showExplorer];
                                                         }];
    
    
    // You can also assign a custom view for any particular item
    // Uncomment the code below and add `customViewItem` to `initWithItems` array, for example:
    // self.menu = [[REMenu alloc] initWithItems:@[homeItem, exploreItem, activityItem, profileItem, customViewItem]]
    //
    /*
    UIView *customView = [[UIView alloc] init];
    customView.backgroundColor = [UIColor blueColor];
    customView.alpha = 0.4;
    REMenuItem *customViewItem = [[REMenuItem alloc] initWithCustomView:customView action:^(REMenuItem *item) {
        NSLog(@"Tap on customView");
    }];
    */
    
    homeItem.tag = 0;
    exploreItem.tag = 1;

    
    self.menu = [[REMenu alloc] initWithItems:@[homeItem, exploreItem]];

    // Background view
    //
    //self.menu.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    //self.menu.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //self.menu.backgroundView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.600];

    //self.menu.imageAlignment = REMenuImageAlignmentRight;
    //self.menu.closeOnSelection = NO;
    //self.menu.appearsBehindNavigationBar = NO; // Affects only iOS 7
    if (!REUIKitIsFlatMode()) {
        self.menu.cornerRadius = 4;
        self.menu.shadowRadius = 4;
        self.menu.shadowColor = [UIColor blackColor];
        self.menu.shadowOffset = CGSizeMake(0, 1);
        self.menu.shadowOpacity = 1;
    }
    
    // Blurred background in iOS 7
    //
    //self.menu.liveBlur = YES;
    //self.menu.liveBlurBackgroundStyle = REMenuLiveBackgroundStyleDark;

    self.menu.separatorOffset = CGSizeMake(15.0, 0.0);
    self.menu.imageOffset = CGSizeMake(5, -1);
    self.menu.waitUntilAnimationIsComplete = NO;
    self.menu.badgeLabelConfigurationBlock = ^(UILabel *badgeLabel, REMenuItem *item) {
        badgeLabel.backgroundColor = [UIColor colorWithRed:0 green:179/255.0 blue:134/255.0 alpha:1];
        badgeLabel.layer.borderColor = [UIColor colorWithRed:0.000 green:0.648 blue:0.507 alpha:1.000].CGColor;
    };
    self.menu.delegate = self;
    
    [self.menu close];
    
    
    [self.menu setClosePreparationBlock:^{
        NSLog(@"Menu will close");
    }];
    
    [self.menu setCloseCompletionHandler:^{
        NSLog(@"Menu did close");
    }];
}


- (void)toggleMenu
{
    if (self.menu.isOpen)
        return [self.menu close];
    
    [self.menu showFromNavigationController:self];
}


#pragma mark - REMenu Delegate Methods

-(void)willOpenMenu:(REMenu *)menu
{
    NSLog(@"Delegate method: %@", NSStringFromSelector(_cmd));
}

-(void)didOpenMenu:(REMenu *)menu
{
    NSLog(@"Delegate method: %@", NSStringFromSelector(_cmd));
}

-(void)willCloseMenu:(REMenu *)menu
{
    NSLog(@"Delegate method: %@", NSStringFromSelector(_cmd));
}

-(void)didCloseMenu:(REMenu *)menu
{
    NSLog(@"Delegate method: %@", NSStringFromSelector(_cmd));
    if (self.menu.isOpen)
        return [self.menu close];

}

@end
