//
//  ViewController.m
//  iAcqChina
//
//  Created by Dental Equipment on 12/15/14.
//  Copyright (c) 2014 iAcqChina. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField_ip;
@property (strong, nonatomic) IBOutlet UIView *_uiview;

@end

@implementation ViewController

@synthesize _uiview;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
   // UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"bgImg.png"]];
   //                     [_uiview setBackGroundColor:bgColor];
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
    [theTextField resignFirstResponder];
    return YES;
}

-(IBAction)done:(UIStoryboardSegue *)segue
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)exitImageBrowser:(UIStoryboardSegue *)segue
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
