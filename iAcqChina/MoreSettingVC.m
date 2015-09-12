//
// Copyright 2011 ESCOZ Inc  - http://escoz.com
//
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
// file except in compliance with the License. You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software distributed under
// the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
// ANY KIND, either express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

#import "MoreSettingVC.h"
#import "LoginInfo.h"
#import "SampleDataBuilder.h"


@implementation MoreSettingViewController



//- (void) viewWillLoad
//{
//    //QRootElement *root = [SampleDataBuilder create];
//    //[self initWithRoot:root];
//    //[self displayViewControllerForRoot: root];
//}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //QRootElement *root = [SampleDataBuilder create];
    //[self displayViewControllerForRoot: root];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
	    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	} else {
	    return YES;
	}
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
