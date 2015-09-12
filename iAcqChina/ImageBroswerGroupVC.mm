//
//  ViewController_imageBroserGroupViewController.m
//  iAcqChina
//
//  Created by Dental Equipment on 2/4/15.
//  Copyright (c) 2015 iAcqChina. All rights reserved.
//


#import "ImageBroswerGroupVC.h"
#import "AppDelegate.h"
#import "PhotoGroupViewCell.h"
#import "imageModel.h"
#import "ImageBroswerVC.h"
#include <iostream>
#include <map>
#import "NavigationViewController.h"

#import "global_def.h"

@interface ViewController_imageBroserGroupViewController ()
{
    NSArray *recipeImages;
    BOOL shareEnabled;
    NSMutableArray *selectedRecipes;

    std::map<std::string, std::string> date_map;
    std::map<int, std::string> tooth_id_date_map;
}

@property (strong, nonatomic) ImageModel* imagemodel;
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@property (strong, nonatomic)NSMutableArray *imageUnitGroupArray;

//@property (nonatomic, strong) NSString* curr_patient_name;
//@property (nonatomic, strong) NSString* curr_tooth_id;
//@property (weak, nonatomic) IBOutlet PhotoGroupViewCell *collectionView;
@end



@implementation ViewController_imageBroserGroupViewController


- (NSString*) curr_date
{
    _curr_date = [NSString alloc];
    return _curr_date;
}

- (ImageModel*) imagemodel
{
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    self.imagemodel = appDelegate.imagemodel;
    return _imagemodel; 
}


-(void) updateDateMap: (NSString*)patient_name
{
    NSMutableArray* dateArray = [NSMutableArray array];
    [_imagemodel QueryDateArray:patient_name
                withReturnArray:dateArray];
    for(NSInteger index = 0; index < [dateArray count]; index++){
        NSString* date = dateArray[index];
        std::string date_ym = std::string([[date substringToIndex:DATE_Y_M_FILTER_LEN] UTF8String]);
        if(date_map.end() == date_map.find(date_ym))
        {
            date_map[date_ym] = [date UTF8String];
        }
    } 
}

-(void)setUpCollectionByDate: (NSString*)patient_name
{
    [self updateDateMap: patient_name];
    
    std::map<std::string, std::string>::iterator it;
    for (it = date_map.begin(); it != date_map.end(); it++)
    {
        ImageUnit *imageUnit = [ImageUnit alloc];
        NSString* date = [NSString stringWithCString:it->second.c_str() encoding:[NSString defaultCStringEncoding]];
        [_imagemodel QueryFirstImageUnitByDate:date
                               withPatientName:nil
                           withReturnImageUnit:imageUnit];
        imageUnit.title = [NSString stringWithCString:it->first.c_str() encoding:[NSString defaultCStringEncoding]];
        //[NSString stringWithCString:it->first.c_str() encoding:[NSString defaultCStringEncoding]];
        //NSString *date = [NSString stringWithCString:it->first.c_str() encoding:[NSString defaultCStringEncoding]];
        [_imageUnitGroupArray addObject: imageUnit];
    }
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
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选"
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:self.navigationController
                                                                            action:@selector(toggleMenu)];

    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    self.imagemodel = appDelegate.imagemodel;
    
    _imageUnitGroupArray = [NSMutableArray array];
    [self setUpCollectionByDate:nil];

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


#pragma mark - Collection View Data Source
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imageUnitGroupArray.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *collectionCellID = @"profileDentalImageGroupCell";
    PhotoGroupViewCell *cell = (PhotoGroupViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    
    ImageUnit *imageUnit    = self.imageUnitGroupArray[indexPath.row];

    cell.group_image.image = imageUnit.image_data;
    cell.group_label.text = imageUnit.title;
    
    
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
//    singleTap.numberOfTapsRequired = 1;
//    cell.group_image .userInteractionEnabled = YES;
//    [cell.group_image  addGestureRecognizer:singleTap];
//    cell.delegate = self;
    
    return cell;
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowAllImagesForGroup"])
    {
        ViewControllerImageBrowser *viewControllerImageBrowser = segue.destinationViewController;
        PhotoGroupViewCell* cell = sender;
        viewControllerImageBrowser.curr_show_method = SHOW_FILTER_DATE;
        viewControllerImageBrowser.curr_date = cell.group_label.text;
        viewControllerImageBrowser.curr_patient_name = nil;
    }
    else
    {
        NSAssert(NO, @"forget to set identifier");
    }
}


@end
