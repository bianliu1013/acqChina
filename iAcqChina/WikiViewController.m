//
//  TOViewController.m
//  TOWebViewControllerExample
//
//  Created by Tim Oliver on 6/05/13.
//  Copyright (c) 2013 Tim Oliver. All rights reserved.
//

#import "WikiViewController.h"
#import "TOWebViewController.h"

#ifndef NSFoundationVersionNumber_iOS_6_1
    #define NSFoundationVersionNumber_iOS_6_1  993.00
#endif

/* Detect if we're running iOS 7.0 or higher */
#define MINIMAL_UI (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)

@interface WikiViewController ()

@end

@implementation WikiViewController

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.tableView];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.tableView.frame = ({
            CGRect frame = self.tableView.frame;
            frame.size.width = CGRectGetWidth(frame) * 0.65f;
            frame.origin.x = CGRectGetMidX(self.view.frame) - (CGRectGetWidth(frame) *0.5f);
            frame;
        });
    }
}

- (void)viewDidLoad
{
    //self.title = @"TOWebViewController";
    
    if (MINIMAL_UI) {
        self.tableView.backgroundView = [UIView new];
        self.view.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.0f];
        self.tableView.backgroundView.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.0f];
    }
    else {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            self.tableView.backgroundView = [UIView new];
            self.tableView.backgroundView.backgroundColor = [UIColor clearColor];
        }
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    }
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
}

#pragma mark - Table View Protocols -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableCellIdentifier = @"TableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableCellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"牙齿小知识";
    }
    else {
        cell.textLabel.text = @"爱牙社区";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSURL *url = nil;
    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//        url = [NSURL URLWithString:@"www.apple.com/ipad"];
//    else if ([[[UIDevice currentDevice] model] rangeOfString:@"iPod"].location != NSNotFound)
//        url = [NSURL URLWithString:@"www.apple.com/ipod-touch"];
//    else
//        url = [NSURL URLWithString:@"www.apple.com/iphone"];
    url = [NSURL URLWithString:@"http://localhost/"];
    
    TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:url];
    
    if (indexPath.row == 0) {
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:webViewController] animated:YES completion:nil];
    }
    else {
        [self.navigationController pushViewController:webViewController animated:YES];
    }
}

@end