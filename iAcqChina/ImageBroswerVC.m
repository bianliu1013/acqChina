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

#import "ImageBroswerVC.h"
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "MBProgressHUD+Add.h"
#import "PhotoViewCell.h"
#import "AppDelegate.h"
#import "UserSelectViewController.h"
#import "ImageBroswerGroupVC.h"
#import "global_def.h"


@interface ViewControllerImageBrowser ()
{
    BOOL bHide_close_btn;
}


@property (strong, nonatomic) ImageModel* imagemodel;
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@property (strong, nonatomic) NSMutableArray *imageUnitArray;
@property (weak, nonatomic) IBOutlet UILabel *groupTitle;

//@property (nonatomic, strong) NSString* curr_patient_name;
//@property (nonatomic, strong) NSString* curr_tooth_id;
//@property NSInteger curr_show_method;  // 0 - all, 1 - patient, 2 - tooth id
@end



@implementation ViewControllerImageBrowser



-(UIImage *) getImageFromURL:(NSString *)fileURL {
    NSLog(@"download image");
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    return result;
}


-(void)setUpCollection{
    if (nil == _imageUnitArray) {
        _imageUnitArray = [NSMutableArray array];
    }
    
    if (_curr_show_method == SHOW_FILTER_DATE) {
        [_imagemodel QueryImageUnitArrayByDateYM:_curr_date
                                 withPatientName:_curr_patient_name
                                 withReturnArray:_imageUnitArray];
    }
    else if(_curr_show_method == SHOW_FILTER_TOOTH_ID){
        [_imagemodel QueryImageUnitArrayByToothId:_curr_tooth_id
                                 withPatientName:_curr_patient_name
                                 withReturnArray:_imageUnitArray];
    }
    else{
        [_imagemodel QueryImageUnitAll:_imageUnitArray];
    }
}


-(void)updateGroupTitle{
    if (_curr_show_method == SHOW_FILTER_DATE) {
        NSString *name = [NSString stringWithFormat:@"日期: %@", _curr_date];
        [_groupTitle setText:name];
    }
    else if(_curr_show_method == SHOW_FILTER_TOOTH_ID){
        NSString *name = [NSString stringWithFormat:@"牙齿: #%@", _curr_tooth_id];
        [_groupTitle setText:name];
    }
}


- (void)viewDidLoad
{
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:1];

    [super viewDidLoad];

    [self.navigationController.navigationBar setTintColor:[UIColor darkGrayColor]];
    
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    self.imagemodel = appDelegate.imagemodel;
    
    self.imageUnitArray = [NSMutableArray array];


    bHide_close_btn = YES;
    
    // Do any additional setup after loading the view, typically from a nib.
    CGRect frame = CGRectMake (120.0, 185.0, 80, 80);
    self.indicator = [[UIActivityIndicatorView alloc] initWithFrame:frame];
    [self.view addSubview:self.indicator];
    

    _NeedUpdateAfterCapturedImages = NO;
    //_curr_show_method  = SHOW_FILTER_ALL;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateGroupTitle];
    [self setUpCollection];
    [self.collectionView reloadData];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}



#pragma mark - Collection View Data Source
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageUnitArray.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    static NSString *collectionCellID2 = @"profileDentalImageCell";
    PhotoViewCell *cell = (PhotoViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID2 forIndexPath:indexPath];
    
    ImageUnit* imageUnit = [_imageUnitArray objectAtIndex:indexPath.row];
    
    cell.dental_image.image = imageUnit.image_data;
    cell.dental_label.text  = imageUnit.title;
    cell.dental_date.text   = imageUnit.date;
    cell.currentPhotoIndex  = indexPath.row;
    cell.dental_image.tag   = indexPath.row;
    cell.uuid               = imageUnit.uuid;
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



- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    //if (theTextField == self.textField) {
    //    [theTextField resignFirstResponder];
    //}
    
    //[theTextField resignFirstResponder];
    return YES;
}


- (void)tapImage:(UITapGestureRecognizer *)gestureRecognizer
{
    
#if 1
    UIImageView *tableGridImage = (UIImageView*)gestureRecognizer.view;
    NSInteger index = tableGridImage.tag;

    int count = [self.imageUnitArray count];
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        MJPhoto *photo      = [[MJPhoto alloc] init];
        ImageUnit* imageUnit = [_imageUnitArray objectAtIndex:i];
        photo.image         = imageUnit.image_data;
        photo.url           = nil;
        photo.index         = i;
        photo.firstShow     = NO;
        [photos addObject:photo];
    }

    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = index; // first image to show
    browser.photos = photos; // all images
    browser.delegate = self;
    [browser show];
    
    
#else  // for test
    int count = 9;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        //NSString *url = [_urls[i] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        MJPhoto *photo = [[MJPhoto alloc] init];
        NSString *name = [NSString stringWithFormat:@"%d_test.png", i + 1];
        UIImage *image = [UIImage imageNamed:name];
        photo.url = nil;
        photo.image = image;
        photo.index = i;
        photo.firstShow = NO;
        [photos addObject:photo];
        //photo.url = [NSURL URLWithString:url]; // 图片路径
        //photo.srcImageView = self.view.subviews[i]; // 来源于哪个UIImageView
        
        //[photos addObject:photo];
    }
    
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex =  1;//tap.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
#endif
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


- (void)onCloseClicked:(PhotoViewCell *)photoViewCell
{
    [photoViewCell removeFromSuperview];
    NSString* uuid = photoViewCell.uuid;
    [self.collectionView setNeedsDisplay];  // refresh

    dispatch_queue_t queue = dispatch_queue_create("com.example.operation2", NULL);
    dispatch_async(queue, ^{
        [_imagemodel RemoveImageByUuid:uuid];

        dispatch_async(dispatch_get_main_queue(), ^{
            for (int index = 0; index < self.imageUnitArray.count; index++) {
                ImageUnit* imageUNit = [self.imageUnitArray objectAtIndex:index];
                if (YES == [photoViewCell.uuid isEqualToString:imageUNit.uuid]) {
                    [self.imageUnitArray removeObjectAtIndex:index];
                }
            }
            [self.imageUnitArray removeObject:photoViewCell];
            [self.collectionView reloadData];
            [self.collectionView setNeedsDisplay];
        });
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
    
 
    [self.collectionView reloadData];
    
    self.indicator.hidden = NO; 
    [self.indicator startAnimating]; 
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ 
        [_imagemodel imageUnitByToothId: @"1" withReturnArray:imageUnitArray];
        
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
    
    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images selectedIndices:self.optionIndices borderColors:colors];
    //    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images];
    callout.delegate = self;
    //    callout.showFromRight = YES;
    [callout show];
}


#pragma mark - UserSelectViewCDelegate
- (void)pickUser:(NSString*)user_name
{
#if 0
    NSMutableArray* imageUnitArray = [NSMutableArray array];
    [_imagemodel imageUnitByOwner:user_name withReturnArray:imageUnitArray];

    [self.collectionView reloadData];
#else
    self.indicator.hidden = NO; 
    [self.indicator startAnimating]; 
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ 
        NSMutableArray* imageUnitArray = [NSMutableArray array];
        [_imagemodel QueryImageUnitArrayByOwner:user_name
                                withReturnArray:imageUnitArray];

        [self.imageUnitArray removeAllObjects];
        
        // re-load data
        dispatch_async(dispatch_get_main_queue(), ^{ 
            [self.indicator stopAnimating]; 
            self.indicator.hidden = YES; 
            [self.collectionView reloadData];
        }); 
    }); 
#endif

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
    
    
    [self.imageUnitArray removeAllObjects];
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
    
    
    [self.imageUnitArray removeAllObjects];
    [self.collectionView reloadData];

    _curr_show_method = SHOW_FILTER_TOOTH_ID;
}

- (void)cancelAndExit
{
    
}



@end
