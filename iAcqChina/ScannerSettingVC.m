//
//  ViewController.m
//  iAcqChina
//
//  Created by Dental Equipment on 12/15/14.
//  Copyright (c) 2014 iAcqChina. All rights reserved.
//

#import "ScannerSettingVC.h"

#import "quickdialog.h"

#import "SampleDataBuilder.h"
#import "MoreSettingVC.h"


@interface ViewControllerScannerSetting ()
//@property (weak, nonatomic) IBOutlet UITextField *textField_ip;

@end

@implementation ViewControllerScannerSetting


-(id) initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        QRootElement *_root = [[QRootElement alloc] init];
        _root.grouped = YES;
    
        self.root = _root;
        self.root.title = @"设置";
        
//        /* Put your init code here or in viewDidLoad */
//        QSection *section = [[QSection alloc] init];
//        QLabelElement *label = [[QLabelElement alloc] initWithTitle:@"Hello" Value:@"world!"];
//        [section addElement:label];
//        [self.root addSection:section];
        
        QSection *usageElements = [[QSection alloc] initWithTitle:@"如何使用内窥镜"];
        [usageElements addElement:[self createUsage]];
        [self.root addSection:usageElements];
        
        QSection *otherElements = [[QSection alloc] init];
            [otherElements addElement:[self createAbout]];
            [otherElements addElement:[self createFeedback]];
            [otherElements addElement:[self createStore]];
            [otherElements addElement:[self createUpdate]];
        [self.root addSection:otherElements];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    QSection *section = [[QSection alloc] init];
//    QLabelElement *label = [[QLabelElement alloc] initWithTitle:@"Hello" Value:@"world!"];
//    [section addElement:label];
//    
//    self.root.title = @"设置";
//    [self.root addSection:section];
//    
//    QSection *usageElements = [[QSection alloc] initWithTitle:@"如何使用内窥镜"];
//    [usageElements addElement:[self createUsage]];
//    [self.root addSection:usageElements];
    
    //QSection *otherElements = [[QSection alloc] init];
//    [otherElements addElement:[self createAbout]];
//    [otherElements addElement:[self createFeedback]];
//    [otherElements addElement:[self createStore]];
//    [otherElements addElement:[self createUpdate]];
//    
    
    //[root addSection:sectionSamples];
    //[root addSection:sectionElements];
    
    //[self.root addSection:otherElements];
}

- (QRootElement *)createUsage {
    QRootElement *root = [[QRootElement alloc] init];
    root.title = @"如何使用";
    
    root.grouped = YES;
    QSection *s1 = [[QSection alloc] initWithTitle:@"完成一下步骤就可以使用内窥镜"];
    //[s1 addElement:[[QLabelElement alloc] initWithTitle:@"With no value" Value:nil]];
    //[s1 addElement:[[QLabelElement alloc] initWithTitle:@"With a value" Value:@"Value"]];
    
    
    QBadgeElement *badge1 = [[QBadgeElement alloc] initWithTitle:@"长按内窥镜电源键" Value:@"1"];
    QBadgeElement *badge2 = [[QBadgeElement alloc] initWithTitle:@"等待内窥镜连接灯显示蓝色" Value:@"2"];
    QBadgeElement *badge3 = [[QBadgeElement alloc] initWithTitle:@"打开系统 设置" Value:@"3"];
    QBadgeElement *badge4 = [[QBadgeElement alloc] initWithTitle:@"无线局域网" Value:@"4"];
    QBadgeElement *badge5 = [[QBadgeElement alloc] initWithTitle:@"选择wifi网络：内窥镜" Value:@"5"];
    
    [s1 addElement:badge1];
    [s1 addElement:badge2];
    [s1 addElement:badge3];
    [s1 addElement:badge4];
    [s1 addElement:badge5];
    
    [root addSection:s1];
    return root;
}


- (QRootElement *)createStore {
    QRootElement *root = [[QRootElement alloc] init];
    root.title = @"去评分";
    
    root.grouped = YES;
    QSection *s1 = [[QSection alloc] initWithTitle:@"完成一下步骤就可以使用内窥镜"];
    //[s1 addElement:[[QLabelElement alloc] initWithTitle:@"With no value" Value:nil]];
    //[s1 addElement:[[QLabelElement alloc] initWithTitle:@"With a value" Value:@"Value"]];
    
    
    
    QBadgeElement *badge1 = [[QBadgeElement alloc] initWithTitle:@"长按内窥镜电源键" Value:@"1"];
    QBadgeElement *badge2 = [[QBadgeElement alloc] initWithTitle:@"等待内窥镜连接灯显示蓝色" Value:@"2"];
    QBadgeElement *badge3 = [[QBadgeElement alloc] initWithTitle:@"打开系统 设置" Value:@"3"];
    QBadgeElement *badge4 = [[QBadgeElement alloc] initWithTitle:@"无线局域网" Value:@"4"];
    QBadgeElement *badge5 = [[QBadgeElement alloc] initWithTitle:@"选择wifi网络：内窥镜" Value:@"5"];
    
    [s1 addElement:badge1];
    [s1 addElement:badge2];
    [s1 addElement:badge3];
    [s1 addElement:badge4];
    [s1 addElement:badge5];
    
    [root addSection:s1];
    return root;
}

- (QRootElement *)createFeedback {
    QRootElement *root = [[QRootElement alloc] init];
    root.title = @"用户反馈";
    
    root.grouped = YES;
    QSection *s1 = [[QSection alloc] initWithTitle:@"完成一下步骤就可以使用内窥镜"];
    //[s1 addElement:[[QLabelElement alloc] initWithTitle:@"With no value" Value:nil]];
    //[s1 addElement:[[QLabelElement alloc] initWithTitle:@"With a value" Value:@"Value"]];
    
    
    
    QBadgeElement *badge1 = [[QBadgeElement alloc] initWithTitle:@"长按内窥镜电源键" Value:@"1"];
    QBadgeElement *badge2 = [[QBadgeElement alloc] initWithTitle:@"等待内窥镜连接灯显示蓝色" Value:@"2"];
    QBadgeElement *badge3 = [[QBadgeElement alloc] initWithTitle:@"打开系统 设置" Value:@"3"];
    QBadgeElement *badge4 = [[QBadgeElement alloc] initWithTitle:@"无线局域网" Value:@"4"];
    QBadgeElement *badge5 = [[QBadgeElement alloc] initWithTitle:@"选择wifi网络：内窥镜" Value:@"5"];
    
    [s1 addElement:badge1];
    [s1 addElement:badge2];
    [s1 addElement:badge3];
    [s1 addElement:badge4];
    [s1 addElement:badge5];
    
    [root addSection:s1];
    return root;
}


- (QRootElement *)createUpdate {
    QRootElement *root = [[QRootElement alloc] init];
    root.title = @"软件更新";
    
    root.grouped = YES;
    QSection *s1 = [[QSection alloc] initWithTitle:@"完成一下步骤就可以使用内窥镜"];
    //[s1 addElement:[[QLabelElement alloc] initWithTitle:@"With no value" Value:nil]];
    //[s1 addElement:[[QLabelElement alloc] initWithTitle:@"With a value" Value:@"Value"]];
    
    
    
    QBadgeElement *badge1 = [[QBadgeElement alloc] initWithTitle:@"长按内窥镜电源键" Value:@"1"];
    QBadgeElement *badge2 = [[QBadgeElement alloc] initWithTitle:@"等待内窥镜连接灯显示蓝色" Value:@"2"];
    QBadgeElement *badge3 = [[QBadgeElement alloc] initWithTitle:@"打开系统 设置" Value:@"3"];
    QBadgeElement *badge4 = [[QBadgeElement alloc] initWithTitle:@"无线局域网" Value:@"4"];
    QBadgeElement *badge5 = [[QBadgeElement alloc] initWithTitle:@"选择wifi网络：内窥镜" Value:@"5"];
    
    [s1 addElement:badge1];
    [s1 addElement:badge2];
    [s1 addElement:badge3];
    [s1 addElement:badge4];
    [s1 addElement:badge5];
    
    [root addSection:s1];
    return root;
}


- (QRootElement *)createAbout {
    QRootElement *root = [[QRootElement alloc] init];
    root.title = @"关于";
    
    root.grouped = YES;
    QSection *s1 = [[QSection alloc] initWithTitle:@"完成一下步骤就可以使用内窥镜"];
    //[s1 addElement:[[QLabelElement alloc] initWithTitle:@"With no value" Value:nil]];
    //[s1 addElement:[[QLabelElement alloc] initWithTitle:@"With a value" Value:@"Value"]];
    
    
    QBadgeElement *badge1 = [[QBadgeElement alloc] initWithTitle:@"长按内窥镜电源键" Value:@"1"];
    QBadgeElement *badge2 = [[QBadgeElement alloc] initWithTitle:@"等待内窥镜连接灯显示蓝色" Value:@"2"];
    QBadgeElement *badge3 = [[QBadgeElement alloc] initWithTitle:@"打开系统 设置" Value:@"3"];
    QBadgeElement *badge4 = [[QBadgeElement alloc] initWithTitle:@"无线局域网" Value:@"4"];
    QBadgeElement *badge5 = [[QBadgeElement alloc] initWithTitle:@"选择wifi网络：内窥镜" Value:@"5"];
    
    [s1 addElement:badge1];
    [s1 addElement:badge2];
    [s1 addElement:badge3];
    [s1 addElement:badge4];
    [s1 addElement:badge5];
    
    [root addSection:s1];
    return root;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)connectToCamera:(id)sender {
    UIAlertView *helloWorldAlert = [[UIAlertView alloc]
                                    initWithTitle:@"My Dear,Jing" message:@"I Love You" delegate:nil cancelButtonTitle:@"I Love you ,too." otherButtonTitles:nil];
    [helloWorldAlert show];
}


- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    //if (theTextField == self.textField) {
    //    [theTextField resignFirstResponder];
    //}
    
    //[theTextField resignFirstResponder];
    return YES;
}


- (IBAction)moreAction:(id)sender {
    QRootElement *root = [SampleDataBuilder create];
    MoreSettingViewController *quickformController = (MoreSettingViewController *) [[MoreSettingViewController alloc] initWithRoot:root];
    
    [self.navigationController pushViewController:quickformController animated:NO];
    
    //[self.navigationController pushViewController:secondView animated:YES];
    
    quickformController.title = @"更多设置";
}


- (IBAction)systemSetting:(id)sender {
}



-(void)handleChangeEntryExample:(QButtonElement *) button {
    QEntryElement *entry  = (QEntryElement *) [self.root elementWithKey:@"entryElement"];
    entry.textValue = @"Hello";
    [self.quickDialogTableView reloadCellForElements:entry, nil];
    
}

-(void)exampleAction:(QElement *)element{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hey!" message:@"This is the exampleAction method in the ExampleViewController" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}


@end
