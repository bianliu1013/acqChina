//
//  ViewController.m
//  iAcqChina
//
//  Created by Dental Equipment on 12/15/14.
//  Copyright (c) 2014 iAcqChina. All rights reserved.
//

// TODO List
// 1, more test: delete, udpate
// 2, update collection view when swithed back from other table page.

#import "ViewController_imageBroser.h"
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "MBProgressHUD+Add.h"
#import "PhotoViewCell.h"
#import "AppDelegate.h"
#import "UserSelectViewController.h"
#import "ViewController_imageBroserGroupViewController.h"
#import "global_def.h"


@interface ViewControllerImageBrowser ()
{
    BOOL bHide_close_btn;
}

@property (strong, nonatomic) ImageModel* imagemodel;
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@end



@implementation ViewControllerImageBrowser

-(id)init 
{ 
    NSLog(@"ViewControllerImageBrowser init\n"); 
    if (![super init]) 
        return nil; 

    _curr_show_method = SHOW_FILTER_DATE;
    _curr_patient_name = nil;
    _curr_date = nil;
    _curr_tooth_id = nil;  
    self.bHide_close_btn = YES;
    _NeedUpdateAfterCapturedImages = NO;
    return self;     
} 
 

- (NSString*) getcurr_date
{
    _curr_date = [NSString alloc];
    return _curr_date;
}


-(UIImage *) getImageFromURL:(NSString *)fileURL {
    NSLog(@"download image");
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    return result;
}


-(void)setUpCollection{
    NSMutableArray* imageUnitArray = [NSMutableArray array];
    
    if (_curr_show_method == SHOW_FILTER_DATE) {
        [_imagemodel QueryImageUnitArrayByDateYM:self.curr_date
                                 withPatientName:self.curr_patient_name
                                 withReturnArray:imageUnitArray];
    }
    else if (_curr_show_metho == SHOW_FILTER_TOOTH_ID)
    {
        [_imagemodel QueryImageUnitArrayByToothId:self.curr_tooth_id
                                 withPatientName:self.curr_patient_name
                                 withReturnArray:imageUnitArray];
    }
    else{
        [_imagemodel QueryImageUnitAll:imageUnitArray];
    }
    
    [self UpdateDataMarr:imageUnitArray];
}


- (void)viewDidLoad
{
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:1];

    [super viewDidLoad];
    
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    self.imagemodel = appDelegate.imagemodel;
    
    self.dataMArr = [NSMutableArray array];
    
    // Do any additional setup after loading the view, typically from a nib.
    CGRect frame = CGRectMake (120.0, 185.0, 80, 80);
    self.indicator = [[UIActivityIndicatorView alloc] initWithFrame:frame];
    [self.view addSubview:self.indicator];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setUpCollection];
    [self.collectionView reloadData];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


-(void) UpdateDataMarr:(NSMutableArray*)imageUnitArray
{
    if (nil == _dataMArr)
    {
        self.dataMArr = [NSMutableArray array];
    }

    [_dataMArr removeAllObjects];
    for(NSInteger index = 0; index < [imageUnitArray count]; index++){
        ImageUnit* imageUnit = imageUnitArray[index];
        UIImage *image  = imageUnit.image_data;
        NSString *title = imageUnit.title;
        NSString *date  = imageUnit.date;
        NSString *uuid  = imageUnit.uuid;
        
        NSDictionary *dic = @{@"image": image, @"title":title, @"date":date, @"uuid":uuid};
        [self.dataMArr addObject:dic];
    }
}


#pragma mark - Collection View Data Source
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataMArr.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    static NSString *collectionCellID2 = @"profileDentalImageCell";
    PhotoViewCell *cell = (PhotoViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID2 forIndexPath:indexPath];
    
    NSDictionary *dic    = self.dataMArr[indexPath.row];
    UIImage *image       = dic[@"image"];
    NSString *title      = dic[@"title"];
    NSString *date       = dic[@"date"];
    //NSString *uuid       = dic[@"uuid"];
    
    cell.dental_image.image = image;
    cell.dental_label.text  = title;
    cell.dental_date.text   = date;
    cell.currentPhotoIndex  = indexPath.row;
    cell.dental_image.tag   = indexPath.row;
    [cell.close_btn setHidden:bHide_close_btn];
    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
    singleTap.numberOfTapsRequired = 1;
    cell.dental_image .userInteractionEnabled = YES;
    [cell.dental_image  addGestureRecognizer:singleTap];
    cell.delegate = self;

    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// - (void)removeImage: (int)tagid
// {
//     for (int i = 0; i < array_closeButtons.count; i++)
//     {
//         UIImageView * imageView  = [array_closeButtons objectAtIndex:i];
//         if(tagid == imageView.tag)
//         {
//             [array_imageViews removeObjectAtIndex: i];
//             [array_closeButtons removeObjectAtIndex: i];
//             return;
//         }
//     }
// }


- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    //if (theTextField == self.textField) {
    //    [theTextField resignFirstResponder];
    //}
    
    //[theTextField resignFirstResponder];
    return YES;
}


- (void)tapImage:(UITapGestureRecognizer *)gestureRecognizer
{
    UIImageView *tableGridImage = (UIImageView*)gestureRecognizer.view;
    NSInteger index = tableGridImage.tag;

    int count = [self.dataMArr count];
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        MJPhoto *photo = [[MJPhoto alloc] init];
        //photo.url = [NSURL URLWithString:[_imagemodel imageUrl:i]];
        NSDictionary *dic    = self.dataMArr[i];
        UIImage *image       = dic[@"image"];
        photo.url = nil;
        photo.image = image;
        photo.index = i;
        photo.firstShow = NO;
        [photos addObject:photo];
    }

    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = index; // first image to show
    browser.photos = photos; // all images
    browser.delegate = self;
    [browser show];
}



- (IBAction)editImages:(id)sender {
    if (bHide_close_btn == YES) {
        // will show close btn
        [_btn_edit_image setTitle: @"完成" forState: UIControlStateNormal];
        bHide_close_btn = NO;
    }
    else{
        // will hide close btn
        [_btn_edit_image setTitle: @"编辑" forState: UIControlStateNormal];
        bHide_close_btn = YES;
    }
    
    
    //int i = 0;
    for(PhotoViewCell *cell in self.collectionView.visibleCells)
    {
        [cell.close_btn  setHidden:bHide_close_btn];
    }
}


- (void)photoBrowser:(MJPhotoBrowser *)photoBrowser didChangedToPageAtIndex:(NSUInteger)index
{
    
}


- (void)onSaveImages
{
    [MBProgressHUD showSuccess:@"Save success" toView:nil];
}


- (void)onCloseClicked:(PhotoViewCell *)photoViewCell andIndex:(NSUInteger)index
{
    NSLog(@"onCloseClicked clicked at  %i cell", index);
    [photoViewCell removeFromSuperview];
    [self.collectionView setNeedsDisplay];  // refresh

    dispatch_async(dispatch_get_main_queue(),
    ^{
        NSDictionary *dic    = self.dataMArr[index];
        //[_imagemodel RemoveImage: dic[@"title"]];
        [_imagemodel RemoveImageByUuid: dic[@"uuid"]];
         
        [self.dataMArr removeObjectAtIndex: index];
        //[self.collectionView reloadData];  // TODO test
    });
}


#pragma mark - RNFrostedSidebarDelegate

- (void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index
{
    NSLog(@"Tapped item at index %i",index);

    if (1 == index) {  // user
        
        UserSelectViewController *user_select_view=[self.storyboard instantiateViewControllerWithIdentifier:@"user_select_view"];
        //UserSelectViewController *user_select_view = [[UserSelectViewController alloc] init];
        user_select_view.delegate = self;
        
        [sidebar dismiss];
        [self presentViewController:user_select_view animated:YES completion:^{ }];
        return;
    }
    
    if (0 == index) {
        ToothChartPanelSelectViewController *tooth_select_view=[self.storyboard instantiateViewControllerWithIdentifier:@"tooth_chart_panle_select_view"];
        tooth_select_view.delegate = self;
        
        [sidebar dismiss];
        [self presentViewController:tooth_select_view animated:YES completion:^{ }];
        return;
    }
    
    
    #if 0
    //[_imagemodel imageUnitByOwner:@"max" withReturnArray:imageUnitArray];
    [_imagemodel imageUnitByToothId: @"1" withReturnArray:imageUnitArray];
    
    [self.dataMArr removeAllObjects];
    [self UpdateDataMarr:imageUnitArray];   
    [self.collectionView reloadData];
    
    self.indicator.hidden = NO; 
    [self.indicator startAnimating]; 
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ 
        [_imagemodel imageUnitByToothId: @"1" withReturnArray:imageUnitArray];
        
        [self.dataMArr removeAllObjects];
        [self UpdateDataMarr:imageUnitArray];   
        [self.collectionView reloadData];
        
        // re-load data
        dispatch_async(dispatch_get_main_queue(), ^{ 
            [self.indicator stopAnimating]; 
            self.indicator.hidden = YES; 
            [self.collectionView reloadData];
        }); 
    });  
    #endif

    [sidebar dismiss];
}


- (void)sidebar:(RNFrostedSidebar *)sidebar didEnable:(BOOL)itemEnabled itemAtIndex:(NSUInteger)index {
    if (itemEnabled) {
        [self.optionIndices addIndex:index];
    }
    else {
        [self.optionIndices removeIndex:index];
    }
}


- (IBAction)OnImageGalleryBurger:(id)sender {
    NSArray *images = @[
                        [UIImage imageNamed:@"ImageGalleryTooth"],
                        [UIImage imageNamed:@"ImageGalleryUser"],
                        [UIImage imageNamed:@"ImageGalleryDate"],
                        [UIImage imageNamed:@"ImageGallerySetting"]
                        ];
    NSArray *colors = @[
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                        [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1]
                        ];
    
    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images 
                                                         selectedIndices:self.optionIndices 
                                                            borderColors:colors];
    callout.delegate = self;
    callout.showFromRight = YES;
    [callout show];
}


#pragma mark - UserSelectViewCDelegate
- (void)pickUser:(NSString*)user_name
{
    self.indicator.hidden = NO; 
    [self.indicator startAnimating]; 
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ 
        NSMutableArray* imageUnitArray = [NSMutableArray array];
        [_imagemodel QueryImageUnitArrayByOwner:user_name
                                withReturnArray:imageUnitArray];

        [self.dataMArr removeAllObjects];
        [self UpdateDataMarr:imageUnitArray];   
        //[self.collectionView reloadData];

        // re-load data
        dispatch_async(dispatch_get_main_queue(), ^{ 
            [self.indicator stopAnimating]; 
            self.indicator.hidden = YES; 
            [self.collectionView reloadData];
        }); 
    }); 

    _curr_show_method = SHOW_FILTER_PATIENT;
}


#pragma mark - toothSelectViewCDelegate
- (void)pickTooth: (NSInteger)tooth_id
{
    NSString *stringInt = [NSString stringWithFormat:@"%d", tooth_id];
    NSMutableArray* imageUnitArray = [NSMutableArray array];
    [_imagemodel QueryImageUnitArrayByToothId:stringInt
                              withPatientName:nil
                              withReturnArray:imageUnitArray];
    
    
    [self.dataMArr removeAllObjects];
    [self UpdateDataMarr:imageUnitArray];
    [self.collectionView reloadData];

    _curr_show_method = SHOW_FILTER_TOOTH_ID;
}


#pragma mark - toothChartPanelSelectViewCDelegate
- (void)pickToothFromToothPanel: (NSInteger)tooth_id
{
    NSString *stringInt = [NSString stringWithFormat:@"%d", tooth_id];
    NSMutableArray* imageUnitArray = [NSMutableArray array];
    [_imagemodel QueryImageUnitArrayByToothId:stringInt
                              withPatientName:nil
                              withReturnArray:imageUnitArray];
    
    
    [self.dataMArr removeAllObjects];
    [self UpdateDataMarr:imageUnitArray];   
    [self.collectionView reloadData];

    _curr_show_method = SHOW_FILTER_TOOTH_ID;
}

@end
