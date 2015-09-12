//
//  CCPlayViewController.m
//  CCTVLiveLine
//
//  Created by lifu on 14-8-1.
//  Copyright (c) 2014年 中视广信. All rights reserved.
//

#import "CCPlayViewController.h"

#import <Availability.h>

#ifndef __IPHONE_3_0
#warning "This project uses features only available in iOS SDK 3.0 and later."
#endif

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IOS7 ([[[UIDevice currentDevice] systemVersion]floatValue] >= 7.0)


#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#endif



@interface CCPlayViewController ()

@end

@implementation CCPlayViewController

@synthesize m_MoviePlayController;
@synthesize m_LoadingView;
@synthesize m_StrVideoUrl;
@synthesize m_IsDetail;
@synthesize m_IsPlay;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*
  * 播放方法
  */
-(id)initWithVideoUrl:(NSString *)videoUrl andIsDetail:(BOOL)isDetail
{
    if (self=[super init])
    {
        self.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        self.m_StrVideoUrl=videoUrl;
        m_IsDetail=isDetail;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self startLoading];
    [self PlayVideo];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
	[UIApplication sharedApplication].statusBarHidden = NO;
    
	if (interfaceOrientation == UIInterfaceOrientationPortrait)
	{
        interfaceOrientation = UIInterfaceOrientationPortrait;
		m_MoviePlayController.view.frame = CGRectMake(0.0, -20.0, 320.0, 480.0+(iPhone5?88:0));
	}
    else if( interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        interfaceOrientation = UIInterfaceOrientationPortraitUpsideDown;
        m_MoviePlayController.view.frame = CGRectMake(0.0, -20.0, 320.0, 480.0+(iPhone5?88:0));
    }
	else if (interfaceOrientation == UIInterfaceOrientationLandscapeRight )
	{
        interfaceOrientation = UIInterfaceOrientationLandscapeRight;
		m_MoviePlayController.view.frame = CGRectMake(0.0, -20.0, 480.0+(iPhone5?88:0), 320.0);
	}
    else if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
    {
        interfaceOrientation = UIInterfaceOrientationLandscapeLeft;
        m_MoviePlayController.view.frame = CGRectMake(0.0, -20.0, 480.0+(iPhone5?88:0), 320.0);
    }
    if (0 == m_IsPlay)
    {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
     }else
    {
      return interfaceOrientation;
     }
}

-(BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    m_MoviePlayController.view.frame = CGRectMake(0.0,IOS7 ?0 : -20.0,self.view.bounds.size.width, self.view.bounds.size.height);
    
    m_LoadingView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    
    return UIInterfaceOrientationMaskAll;
}


/*
 * 播放视频
 */
-(void)PlayVideo
{
    BOOL  bRet=YES;
    
    do {
        
        if (!m_StrVideoUrl||0==[m_StrVideoUrl length])
        {
            bRet=NO;
            return;
        }
        NSURL *_url=[NSURL URLWithString:m_StrVideoUrl];
        
        MPMoviePlayerController *_moviePlayer=[[MPMoviePlayerController alloc]initWithContentURL:_url];
        self.m_MoviePlayController=_moviePlayer;
        [self.m_MoviePlayController prepareToPlay];
        
        m_MoviePlayController.view.frame=CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        m_MoviePlayController.controlStyle = MPMovieControlStyleFullscreen;
        [self.view addSubview:self.m_MoviePlayController.view];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePreloadDidFinish:)
                                                    name:MPMoviePlayerLoadStateDidChangeNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(movieFinishedCallBack:)
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(movieExitFullScreen:)
                                                     name:MPMoviePlayerDidExitFullscreenNotification
                                                   object:nil];
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
		backButton.tag = 1000;
		backButton.frame = CGRectMake(20.0, 20.0, 55.0, 30.0);
        if (m_IsDetail)
        {
            backButton.frame = CGRectMake(10.0, 10.0, 55.0, 30.0);
        }
       [backButton setImage:[UIImage imageNamed:@"button_back.png"] forState:UIControlStateNormal];
       [backButton addTarget:self action:@selector(tapBack:) forControlEvents:UIControlEventTouchUpInside];
       [self.view addSubview:backButton];

    } while (NO);
    
    if (!bRet)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"NOTICE"
                                                            message:@"Loading video failed, please try again."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];

        [self performSelector:@selector(StopVideo) withObject:nil afterDelay:1];
    }
}

-(void)apBack:(id)sender
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    [self StopVideo];
	
    if (m_IsDetail)
    {
        [self.view removeFromSuperview];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }

}

-(void)StopVideo
{
    if (m_MoviePlayController)
    {
        [m_MoviePlayController stop];
        [m_MoviePlayController.view removeFromSuperview];
        m_MoviePlayController.initialPlaybackTime = -1;
        self.m_MoviePlayController=nil;
    }
}

#pragma mark Private Class Function

- (void)moviePreloadDidFinish:(NSNotification*)notification
{
    if (MPMovieLoadStateUnknown!=m_MoviePlayController.loadState)
    {
         [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerLoadStateDidChangeNotification  object:nil];
        m_LoadingView.frame = CGRectMake(self.view.bounds.size.width/2,self.view.bounds.size.height/2, 20.0, 20.0);
          m_MoviePlayController.view.frame = CGRectMake(0.0, 0.0,self.view.bounds.size.width, self.view.bounds.size.height);
        [self.view addSubview:m_MoviePlayController.view];
    }
    
//    if (m_MoviePlayController)
//    {
//        [m_MoviePlayController play];
//        [self StopVideo];
//        [self stopLoading];
//        m_IsPlay = 1;
//    }
}

- (void)stopLoading
{
	UIApplication *app = [UIApplication sharedApplication];
	app.networkActivityIndicatorVisible = NO;
    
    UIButton *backButton = (UIButton *)[self.view viewWithTag:1000];
	[backButton removeFromSuperview];
	
	UIImageView *loadingBg = (UIImageView *)[self.view viewWithTag:200];
	[loadingBg removeFromSuperview];
	
	[m_LoadingView stopAnimating];
	[m_LoadingView removeFromSuperview];
}

- (void)movieFinishedCallBack:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name: MPMoviePlayerPlaybackStateDidChangeNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:m_MoviePlayController];
    
      [m_MoviePlayController.view removeFromSuperview];
    
    if (m_IsDetail)
    {
        m_MoviePlayController.view.frame = CGRectMake(0.0, -20.0, 320.0, 480.0+(iPhone5?88:0));
    }
    [self StopVideo];
    
    if (m_IsDetail)
    {
        [self.view removeFromSuperview];
    }else
    {
        [self dismissViewControllerAnimated:YES completion:^{ }];
    }
}

- (void)movieExitFullScreen:(NSNotification *)notification
{
    //AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //app.m_HomeNav.navigationBar.frame = CGRectMake(0.0, 20.0, 320.0, 44.0);
}

- (void)tapBack:(id)sender
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    [self StopVideo];
	
    if (m_IsDetail)
    {
        [self.view removeFromSuperview];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}


- (void)startLoading
{
	UIApplication *app = [UIApplication sharedApplication];
	app.networkActivityIndicatorVisible = YES;
	
	UIImageView *loadingBg = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)];
    loadingBg.image = [UIImage imageNamed:@"loading_a.png"];
    
    if (m_IsDetail)
    {
        loadingBg.frame = CGRectMake(0.0, 0.0, 288.0, 175.0);
        loadingBg.image = [UIImage imageNamed:@"loading_h.png"];
    }
    
	loadingBg.tag = 200;
	[self.view addSubview:loadingBg];
	
	m_LoadingView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    m_LoadingView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    if (m_IsDetail)
    {
        
        m_LoadingView.frame = CGRectMake(288.0, 150.0, 20.0, 20.0);
        //m_LoadingView.frame = CGRectMake(140.0, 80.0, 20.0, 20.0);
        m_LoadingView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    }
    else
    {
        m_LoadingView.frame = CGRectMake(140.0, 160.0, 20.0, 20.0);
        //m_LoadingView.center = CGPointMake(self.view.bounds.size.width/1, self.view.bounds.size.height/1);
    }
    
    
	m_LoadingView.hidesWhenStopped = YES;
	[self.view addSubview:m_LoadingView];
	[m_LoadingView startAnimating];
}



@end
