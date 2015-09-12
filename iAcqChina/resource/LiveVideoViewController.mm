//
//  LiveVideoViewController.m
//  iAcqChina
//
//  Created by Dental Equipment on 1/2/15.
//  Copyright (c) 2015 iAcqChina. All rights reserved.
//

#import "LiveVideoViewController.h"
#import "Reachability.h"
#import "CCPlayViewController.h"
//#import "CaptureImg.h"
#import "AppDelegate.h"
#import "AcqCommManager.h"


@interface LiveVideoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *connectionOkAlert;
@property (weak, nonatomic) IBOutlet UIButton *startCaptureBtn;

@property (weak, nonatomic) IBOutlet UIImageView *connectionHelpAlertIcon;
@property (weak, nonatomic) IBOutlet UILabel *connectionHelpAlert;
@property (weak, nonatomic) IBOutlet UITextField *patientName;

@property (strong, nonatomic) ImageModel* imagemodel;
@property (strong, nonatomic) AcqCommManager* acqCommManager;
@end

@implementation LiveVideoViewController


- (BOOL) CheckConnection
{
    return YES;
}


- (void)showIntroWithCrossDissolve {
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"Hello world";
    page1.desc = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
    page1.bgImage = [UIImage imageNamed:@"1"];
    page1.titleImage = [UIImage imageNamed:@"original"];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"This is page 2";
    page2.desc = @"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore.";
    page2.bgImage = [UIImage imageNamed:@"2"];
    page2.titleImage = [UIImage imageNamed:@"supportcat"];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"This is page 3";
    page3.desc = @"Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.";
    page3.bgImage = [UIImage imageNamed:@"3"];
    page3.titleImage = [UIImage imageNamed:@"femalecodertocat"];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3]];
    
    [intro setDelegate:self];
    [intro showInView:self.view animateDuration:0.0];
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    //读取沙盒数据
//    NSUserDefaults * settings1 = [NSUserDefaults standardUserDefaults];
//    NSString *key1 = [NSString stringWithFormat:@"is_first"];
//    NSString *value = [settings1 objectForKey:key1];
//    //if (!value)  //如果没有数据
//    {
//        [self showIntroWithCrossDissolve];
//        NSUserDefaults * setting = [NSUserDefaults standardUserDefaults];
//        NSString * key = [NSString stringWithFormat:@"is_first"];
//        [setting setObject:[NSString stringWithFormat:@"false"] forKey:key];
//        [setting synchronize];
//    }
//}


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
    
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    self.imagemodel = appDelegate.imagemodel;
    
    // Do any additional setup after loading the view.
    
//    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
//    [customLab setTextColor:[UIColor whiteColor]];
//    [customLab setText:@"采集"];
//    customLab.font = [UIFont boldSystemFontOfSize:20];
//    self.navigationItem.titleView = customLab;
    //[customLab release];
    if ([self CheckConnection]) {
        _connectionOkAlert.hidden = NO;
        _connectionHelpAlert.hidden = YES;
        _connectionHelpAlertIcon.hidden = YES;
    }
    else{
        _connectionOkAlert.hidden = YES;
        _connectionHelpAlert.hidden = NO;
        _connectionHelpAlertIcon.hidden = NO;
    }
    
    _patientName.delegate=self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)AddImageToModel:(UIImage*)image
{
        ImageUnit* imageUnit = [ImageUnit alloc];
        
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat:@"yyyy-MM-dd 00:00:00"];
        imageUnit.date = [dateFormatter1 stringFromDate:[NSDate date]];
        imageUnit.url  = [NSString stringWithFormat:@"{0,%ld}",(long)index+1];
        imageUnit.tooth_id = @"1";
        imageUnit.owner = @"peter";
        imageUnit.title = [NSString stringWithFormat:@"#%@-%@"
                           , imageUnit.tooth_id
                           , imageUnit.owner];
        imageUnit.image_data = image;
        
        [_imagemodel InsertImage:imageUnit];
}


-(void)OnTriggerCaptureCmd: (NSString*)ftp_full_path
{
    dispatch_queue_t queue;
    queue = dispatch_queue_create("com.example.operation", NULL);
    dispatch_async(queue, ^{
        //        NSURL *url = [NSURL URLWithString:@"ftp://user:password@host:port/path"];
        //        NSData *data = [NSData alloc] initWithContentsOfURL:url];
        //NSString *urlString = @"ftp://123:123@127.0.0.1/images/1_test.png";
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ftp_full_path]];
        
        UIImage *image = [UIImage imageWithData:imageData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //self.imageView.image = imge;
            [self AddImageToModel:image];
        });
    });
}


-(void)blockWork{
    dispatch_queue_t queue;
    queue = dispatch_queue_create("com.example.operation", NULL);
    dispatch_async(queue, ^{
//        NSURL *url = [NSURL URLWithString:@"ftp://user:password@host:port/path"];
//        NSData *data = [NSData alloc] initWithContentsOfURL:url];
        NSString *urlString = @"ftp://123:123@127.0.0.1/images/1_test.png";
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        
        UIImage *image = [UIImage imageWithData:imageData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //self.imageView.image = imge;
            [self AddImageToModel:image];
        });
    });
}


- (IBAction)OpenCamera:(id)sender {
    if (NULL == _acqCommManager) {
        _acqCommManager = [AcqCommManager alloc];
        _acqCommManager.delegate = self;
    }
    
    if (NO == [_acqCommManager IsConnected]) {
       [_acqCommManager SetupConnection];
    }
    
#if 0
    //CAPTUREIMAGE->DownloadImageFromHP("test_1.png");
    if (NULL == _acqCommManager) {
        _acqCommManager = [AcqCommManager alloc];
        [_acqCommManager SetupConnection];
    }
    
    [_acqCommManager SendMessage:nullptr withLen:10];
    
    [self blockWork];
#endif
    
    
#if 1
    NSString *_urlIPad= @"http://live.hhek.cn/live2/live2.m3u8";
    //NSString *_urlIPad= @"rtsp://live21.gztv.com/gztv_kids";
    //NSString *_urlIPad= @"rtsp://184.72.239.149/vod/mp4:BigBuckBunny_175k.mov";
    //NSString *_urlIPad=[m_DicVideoUrl objectForKey:@"ipad"];
    
    NSLog(@"_urlIPad=%@",_urlIPad);
    
    if (!_urlIPad||0==[_urlIPad length])
    {
        return;
    }
    CCPlayViewController *_play=[[CCPlayViewController alloc]initWithVideoUrl:_urlIPad andIsDetail:NO];
    [self presentViewController:_play animated:YES completion:^{ }];
#endif

}


- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    //if (theTextField == self.textField) {
    //    [theTextField resignFirstResponder];
    //}
    [theTextField resignFirstResponder];
    return YES;
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
