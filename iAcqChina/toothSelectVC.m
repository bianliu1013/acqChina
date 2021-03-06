//
//  toothSelectViewController.m
//  iAcqChina
//
//  Created by Dental Equipment on 1/22/15.
//  Copyright (c) 2015 iAcqChina. All rights reserved.
//

#import "toothSelectVC.h"
#import "ImageModel.h"
#import "AppDelegate.h"

#import "NavigationViewController.h"


@interface toothSelectViewController ()
{
   NSMutableArray *listOfToothId;
}

@property (strong, nonatomic) ImageModel* imagemodel;
@property  NSInteger slected_tooth;
@end

@implementation toothSelectViewController




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:self.navigationController action:@selector(toggleMenu)];
    
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    self.imagemodel = appDelegate.imagemodel;
    
    listOfToothId = [[NSMutableArray alloc] init];
    //TODO [self.imagemodel queryUserNameArray:listOfUsers];
    [listOfToothId addObject:@"1"];
    [listOfToothId addObject:@"2"];
    
    self.tableView.allowsSelection = YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [listOfToothId count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [listOfToothId objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    return cell;
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




- (IBAction)cancelAndExit:(id)sender {
    //[self.delegate cancelAndExit];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString* tooth_string = [listOfToothId objectAtIndex:[indexPath row]];
    _slected_tooth = [tooth_string intValue];
}


- (IBAction)OnConfirm:(id)sender {
    [self.delegate pickTooth: _slected_tooth];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

@end
