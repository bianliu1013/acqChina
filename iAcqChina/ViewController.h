//
//  ViewController.h
//  iAcqChina
//
//  Created by Dental Equipment on 12/15/14.
//  Copyright (c) 2014 iAcqChina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>
-(IBAction)done:(UIStoryboardSegue*)segue;
-(IBAction)exitImageBrowser:(UIStoryboardSegue*)segue;
@end
