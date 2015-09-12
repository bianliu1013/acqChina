//
//  UserSelectViewController.m
//  iAcqChina
//
//  Created by Dental Equipment on 1/21/15.
//  Copyright (c) 2015 iAcqChina. All rights reserved.
//

#import "UserSelectViewController.h"
#import "ImageModel.h"
#import "AppDelegate.h"
#import "NavigationViewController.h"

@interface UserSelectViewController ()
{
    NSMutableArray *listOfUsers;
}

@property (strong, nonatomic) ImageModel* imagemodel;
@property (strong, nonatomic) NSString* slected_user;
@end


@implementation UserSelectViewController

- (NSString*) slected_user
{
    if (nil == _slected_user) {
        _slected_user = [[NSString alloc] init];
    }
    return _slected_user;
}


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
    
    listOfUsers = [[NSMutableArray alloc] init];
    [self.imagemodel QueryUserNameArray:listOfUsers];
    
    self.tableView.allowsSelection = YES;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [listOfUsers count];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [listOfUsers objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    return cell;
}



- (IBAction)cancelAndExit:(id)sender {
    //[self.delegate cancelAndExit];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _slected_user = [listOfUsers objectAtIndex:[indexPath row]];
}


- (IBAction)OnConfirm:(id)sender {
    [self.delegate pickUser: _slected_user];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void) viewWillAppear:(BOOL)animated
{
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

@end
