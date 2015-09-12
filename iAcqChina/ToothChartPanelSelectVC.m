//
//  ToothChartPanelSelectViewController.m
//  iAcqChina
//
//  Created by Dental Equipment on 1/25/15.
//  Copyright (c) 2015 iAcqChina. All rights reserved.
//

#import "ToothChartPanelSelectVC.h"
#import "NavigationViewController.h"
#import "ImageBroswerVC.h"

#include "global_def.h"
#import "PureLayout.h"

@interface ToothChartPanelSelectViewController ()

// left top
@property (weak, nonatomic) IBOutlet UIButton *tooth_btn_01;
@property (weak, nonatomic) IBOutlet UIButton *tooth_btn_02;
@property (weak, nonatomic) IBOutlet UIButton *tooth_btn_03;
@property (weak, nonatomic) IBOutlet UIButton *tooth_btn_04;
@property (weak, nonatomic) IBOutlet UIButton *tooth_btn_05;
@property (weak, nonatomic) IBOutlet UIButton *tooth_btn_06;
@property (weak, nonatomic) IBOutlet UIButton *tooth_btn_07;
@property (weak, nonatomic) IBOutlet UIButton *tooth_btn_08;

// right top
@property (weak, nonatomic) IBOutlet UIButton *tooth_btn_09;
@property (weak, nonatomic) IBOutlet UIButton *tooth_btn_10;
@property (weak, nonatomic) IBOutlet UIButton *tooth_btn_11;
@property (weak, nonatomic) IBOutlet UIButton *tooth_btn_12;
@property (weak, nonatomic) IBOutlet UIButton *tooth_btn_13;
@property (weak, nonatomic) IBOutlet UIButton *tooth_btn_14;
@property (weak, nonatomic) IBOutlet UIButton *tooth_btn_15;
@property (weak, nonatomic) IBOutlet UIButton *tooth_btn_16;

// left bottom
@property (weak, nonatomic) IBOutlet UIButton *tooth_btn_25;
@property (weak, nonatomic) IBOutlet UIButton *tooth_btn_26;
@property (weak, nonatomic) IBOutlet UIButton *tooth_btn_27;
@property (weak, nonatomic) IBOutlet UIButton *tooth_btn_28;
@property (weak, nonatomic) IBOutlet UIButton *tooth_btn_29;
@property (weak, nonatomic) IBOutlet UIButton *tooth_btn_30;
@property (weak, nonatomic) IBOutlet UIButton *tooth_btn_31;
@property (weak, nonatomic) IBOutlet UIButton *tooth_btn_32;

// right bottom
@property (weak, nonatomic) IBOutlet UIButton *tooth_btn_24;
@property (weak, nonatomic) IBOutlet UIButton *tooth_btn_23;
@property (weak, nonatomic) IBOutlet UIButton *tooth_btn_22;
@property (weak, nonatomic) IBOutlet UIButton *tooth_btn_21;
@property (weak, nonatomic) IBOutlet UIButton *tooth_btn_20;
@property (weak, nonatomic) IBOutlet UIButton *tooth_btn_19;
@property (weak, nonatomic) IBOutlet UIButton *tooth_btn_18;
@property (weak, nonatomic) IBOutlet UIButton *tooth_btn_17;


@property  NSInteger slected_tooth;
@end




@implementation ToothChartPanelSelectViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)click:(id)sender
{
    UIButton *u = (UIButton *)sender;
    if (u.selected == YES) {
        u.selected = NO;
    }
    else
    {
        u.selected = YES;//选择状态设置为YES,如果有其他按钮 先把其他按钮的selected设置为NO，
    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"图库";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStyleBordered target:self.navigationController action:@selector(toggleMenu)];
    
    [@[self.tooth_btn_01,
       self.tooth_btn_02,
       self.tooth_btn_03,
       self.tooth_btn_14,
       self.tooth_btn_15,
       self.tooth_btn_16,
       self.tooth_btn_32,
       self.tooth_btn_31,
       self.tooth_btn_30,
       self.tooth_btn_17,
       self.tooth_btn_18,
       self.tooth_btn_19] autoSetViewsDimension:ALDimensionHeight toSize:30.0];
    [@[self.tooth_btn_01,
       self.tooth_btn_02,
       self.tooth_btn_03,
       self.tooth_btn_14,
       self.tooth_btn_15,
       self.tooth_btn_16,
       self.tooth_btn_32,
       self.tooth_btn_31,
       self.tooth_btn_30,
       self.tooth_btn_17,
       self.tooth_btn_18,
       self.tooth_btn_19] autoSetViewsDimension:ALDimensionWidth toSize:30.0];
    
    [@[self.tooth_btn_08,
       self.tooth_btn_09,
       self.tooth_btn_24,
       self.tooth_btn_25] autoSetViewsDimension:ALDimensionHeight toSize:24.0];
    [@[self.tooth_btn_08,
       self.tooth_btn_09,
       self.tooth_btn_24,
       self.tooth_btn_25] autoSetViewsDimension:ALDimensionWidth toSize:30.0];
    
    [@[self.tooth_btn_07,
       self.tooth_btn_10,
       self.tooth_btn_26,
       self.tooth_btn_23] autoSetViewsDimension:ALDimensionHeight toSize:24.0];
    [@[self.tooth_btn_07,
       self.tooth_btn_10,
       self.tooth_btn_26,
       self.tooth_btn_23] autoSetViewsDimension:ALDimensionWidth toSize:28.0];
    
    [@[self.tooth_btn_04,
       self.tooth_btn_13,
       self.tooth_btn_29,
       self.tooth_btn_20] autoSetViewsDimension:ALDimensionHeight toSize:28.0];
    [@[self.tooth_btn_04,
       self.tooth_btn_13,
       self.tooth_btn_29,
       self.tooth_btn_20] autoSetViewsDimension:ALDimensionWidth toSize:28.0];
    
    [@[self.tooth_btn_05,
       self.tooth_btn_06,
       self.tooth_btn_11,
       self.tooth_btn_12,
       self.tooth_btn_27,
       self.tooth_btn_28,
       self.tooth_btn_22,
       self.tooth_btn_21] autoSetViewsDimension:ALDimensionHeight toSize:26.0];
    [@[self.tooth_btn_05,
       self.tooth_btn_06,
       self.tooth_btn_11,
       self.tooth_btn_12,
       self.tooth_btn_27,
       self.tooth_btn_28,
       self.tooth_btn_22,
       self.tooth_btn_21] autoSetViewsDimension:ALDimensionWidth toSize:26.0];
    
    
    // ------------------------------------------------------------------------------------------------------
    [self.tooth_btn_08 autoPinToTopLayoutGuideOfViewController:self withInset:20.0];
    [self.tooth_btn_08 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:128];
    
    [self.tooth_btn_07 autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft   ofView:self.tooth_btn_08];
    [self.tooth_btn_07 autoPinEdge:ALEdgeTop   toEdge:ALEdgeBottom ofView:self.tooth_btn_08 withOffset:-18.0];
    
    [self.tooth_btn_06 autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft   ofView:self.tooth_btn_07 withOffset:8.0];
    [self.tooth_btn_06 autoPinEdge:ALEdgeTop   toEdge:ALEdgeBottom ofView:self.tooth_btn_07 withOffset:-7.0];
    
    [self.tooth_btn_05 autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft   ofView:self.tooth_btn_06 withOffset:8.0];
    [self.tooth_btn_05 autoPinEdge:ALEdgeTop   toEdge:ALEdgeBottom ofView:self.tooth_btn_06 withOffset:-4.0];
    
    [self.tooth_btn_04 autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft   ofView:self.tooth_btn_05 withOffset:15.0];
    [self.tooth_btn_04 autoPinEdge:ALEdgeTop   toEdge:ALEdgeBottom ofView:self.tooth_btn_05 withOffset:-3.0];
    
    [self.tooth_btn_03 autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft   ofView:self.tooth_btn_04 withOffset:18.0];
    [self.tooth_btn_03 autoPinEdge:ALEdgeTop   toEdge:ALEdgeBottom ofView:self.tooth_btn_04 withOffset:-1.0];
    
    [self.tooth_btn_02 autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft   ofView:self.tooth_btn_03 withOffset:30.0];
    [self.tooth_btn_02 autoPinEdge:ALEdgeTop   toEdge:ALEdgeBottom ofView:self.tooth_btn_03 withOffset:-0.0];
    
    [self.tooth_btn_01 autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft   ofView:self.tooth_btn_02 withOffset:30.0];
    [self.tooth_btn_01 autoPinEdge:ALEdgeTop   toEdge:ALEdgeBottom ofView:self.tooth_btn_02 withOffset:-0.0];
    
    
    // ------------------------------------------------------------------------------------------------------
    [self.tooth_btn_24 autoPinToBottomLayoutGuideOfViewController:self withInset:20.0];
    [self.tooth_btn_24 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:158];
    
    [self.tooth_btn_23 autoPinEdge:ALEdgeLeft   toEdge:ALEdgeRight  ofView:self.tooth_btn_24];
    [self.tooth_btn_23 autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop    ofView:self.tooth_btn_24 withOffset:18.0];
    
    [self.tooth_btn_22 autoPinEdge:ALEdgeLeft   toEdge:ALEdgeRight  ofView:self.tooth_btn_23 withOffset:-8.0];
    [self.tooth_btn_22 autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop    ofView:self.tooth_btn_23 withOffset:7.0];
    
    [self.tooth_btn_21 autoPinEdge:ALEdgeLeft   toEdge:ALEdgeRight  ofView:self.tooth_btn_22 withOffset:-8.0];
    [self.tooth_btn_21 autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop    ofView:self.tooth_btn_22 withOffset:4.0];
    
    [self.tooth_btn_20 autoPinEdge:ALEdgeLeft   toEdge:ALEdgeRight  ofView:self.tooth_btn_21 withOffset:-15.0];
    [self.tooth_btn_20 autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop    ofView:self.tooth_btn_21 withOffset:3.0];
    
    [self.tooth_btn_19 autoPinEdge:ALEdgeLeft   toEdge:ALEdgeRight  ofView:self.tooth_btn_20 withOffset:-18.0];
    [self.tooth_btn_19 autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop    ofView:self.tooth_btn_20 withOffset:1.0];
    
    [self.tooth_btn_18 autoPinEdge:ALEdgeLeft   toEdge:ALEdgeRight  ofView:self.tooth_btn_19 withOffset:-30.0];
    [self.tooth_btn_18 autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop    ofView:self.tooth_btn_19 withOffset:0.0];
    
    [self.tooth_btn_17 autoPinEdge:ALEdgeLeft   toEdge:ALEdgeRight  ofView:self.tooth_btn_18 withOffset:-30.0];
    [self.tooth_btn_17 autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop    ofView:self.tooth_btn_18 withOffset:0.0];
    

    // ------------------------------------------------------------------------------------------------------
    [self.tooth_btn_25 autoPinToBottomLayoutGuideOfViewController:self withInset:20.0];
    [self.tooth_btn_25 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:128];
    
    [self.tooth_btn_26 autoPinEdge:ALEdgeRight  toEdge:ALEdgeLeft   ofView:self.tooth_btn_25];
    [self.tooth_btn_26 autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop    ofView:self.tooth_btn_25 withOffset:18.0];
    
    [self.tooth_btn_27 autoPinEdge:ALEdgeRight  toEdge:ALEdgeLeft   ofView:self.tooth_btn_26 withOffset:8.0];
    [self.tooth_btn_27 autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.tooth_btn_26 withOffset:7.0];
    
    [self.tooth_btn_28 autoPinEdge:ALEdgeRight  toEdge:ALEdgeLeft   ofView:self.tooth_btn_27 withOffset:8.0];
    [self.tooth_btn_28 autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.tooth_btn_27 withOffset:4.0];
    
    [self.tooth_btn_29 autoPinEdge:ALEdgeRight  toEdge:ALEdgeLeft   ofView:self.tooth_btn_28 withOffset:15.0];
    [self.tooth_btn_29 autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.tooth_btn_28 withOffset:3.0];
    
    [self.tooth_btn_30 autoPinEdge:ALEdgeRight  toEdge:ALEdgeLeft   ofView:self.tooth_btn_29 withOffset:18.0];
    [self.tooth_btn_30 autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.tooth_btn_29 withOffset:1.0];
    
    [self.tooth_btn_31 autoPinEdge:ALEdgeRight  toEdge:ALEdgeLeft   ofView:self.tooth_btn_30 withOffset:30.0];
    [self.tooth_btn_31 autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.tooth_btn_30 withOffset:0.0];
    
    [self.tooth_btn_32 autoPinEdge:ALEdgeRight  toEdge:ALEdgeLeft   ofView:self.tooth_btn_31 withOffset:30.0];
    [self.tooth_btn_32 autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.tooth_btn_31 withOffset:0.0];

    
    // ------------------------------------------------------------------------------------------------------
    [self.tooth_btn_09 autoPinToTopLayoutGuideOfViewController:self withInset:20.0];
    [self.tooth_btn_09 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:158];
    
    [self.tooth_btn_10 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight  ofView:self.tooth_btn_09];
    [self.tooth_btn_10 autoPinEdge:ALEdgeTop  toEdge:ALEdgeBottom ofView:self.tooth_btn_09 withOffset:-18.0];
    
    [self.tooth_btn_11 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight  ofView:self.tooth_btn_10 withOffset:-8.0];
    [self.tooth_btn_11 autoPinEdge:ALEdgeTop  toEdge:ALEdgeBottom ofView:self.tooth_btn_10 withOffset:-7.0];
    
    [self.tooth_btn_12 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight  ofView:self.tooth_btn_11 withOffset:-8.0];
    [self.tooth_btn_12 autoPinEdge:ALEdgeTop  toEdge:ALEdgeBottom ofView:self.tooth_btn_11 withOffset:-4.0];
    
    [self.tooth_btn_13 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight  ofView:self.tooth_btn_12 withOffset:-15.0];
    [self.tooth_btn_13 autoPinEdge:ALEdgeTop  toEdge:ALEdgeBottom ofView:self.tooth_btn_12 withOffset:-3.0];
    
    [self.tooth_btn_14 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight  ofView:self.tooth_btn_13 withOffset:-18.0];
    [self.tooth_btn_14 autoPinEdge:ALEdgeTop  toEdge:ALEdgeBottom ofView:self.tooth_btn_13 withOffset:-1.0];
    
    [self.tooth_btn_15 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight  ofView:self.tooth_btn_14 withOffset:-30.0];
    [self.tooth_btn_15 autoPinEdge:ALEdgeTop  toEdge:ALEdgeBottom ofView:self.tooth_btn_14 withOffset:0.0];
    
    [self.tooth_btn_16 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight  ofView:self.tooth_btn_15 withOffset:-30.0];
    [self.tooth_btn_16 autoPinEdge:ALEdgeTop  toEdge:ALEdgeBottom ofView:self.tooth_btn_15 withOffset:0.0];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}


- (IBAction)OnConfirm:(id)sender {
    
    _slected_tooth  = 1;
    [self.delegate pickToothFromToothPanel: _slected_tooth];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)toothClicked:(id)sender {
    
    UIButton *u = (UIButton *)sender;
    if (u.selected == YES) {
        u.selected = NO;
    }
    else
    {
        u.selected = YES;
    }
    if (nil == [u imageForState:UIControlStateSelected])
    {
        NSString* current_title = [u currentTitle];
        NSString* str = [NSString stringWithFormat:@"t%@_select", current_title];
        //NSString* str_normal = [NSString stringWithFormat:@"t%@_norm", current_title];
        [u setBackgroundImage:[UIImage imageNamed:str] forState:UIControlStateSelected];
        //[u setBackgroundImage:[UIImage imageNamed:str_normal] forState:UIControlStateNormal];
        u.adjustsImageWhenHighlighted = FALSE;
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowAllImagesForGroupByToothId"])
    {
        ViewControllerImageBrowser *viewControllerImageBrowser = segue.destinationViewController;
        viewControllerImageBrowser.curr_show_method = SHOW_FILTER_TOOTH_ID;
        viewControllerImageBrowser.curr_tooth_id = @"1";
        viewControllerImageBrowser.curr_patient_name = nil;
    }
    else
    {
        NSAssert(NO, @"forget to set identifier");
    }
}
@end
