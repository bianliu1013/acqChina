//
//  CCPlayViewController.h
//  CCTVLiveLine
//
//  Created by lifu on 14-8-1.
//  Copyright (c) 2014年 中视广信. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface CCPlayViewController : UIViewController
{
    MPMoviePlayerController *m_MoviePlayController;
    UIActivityIndicatorView	   *m_LoadingView;
    NSString *m_StrVideoUrl;
    BOOL      m_IsDetail;
    BOOL      m_IsPlay;
}

@property (nonatomic, retain) MPMoviePlayerController   *m_MoviePlayController;
@property (nonatomic, retain) UIActivityIndicatorView	*m_LoadingView;
@property (nonatomic, retain) NSString *m_StrVideoUrl;
@property (nonatomic, assign) BOOL      m_IsDetail;
@property (nonatomic, assign) BOOL                      m_IsPlay;

-(id)initWithVideoUrl:(NSString*)videoUrl andIsDetail:(BOOL)isDetail;
-(void)PlayVideo;
-(void)StopVideo;
@end
