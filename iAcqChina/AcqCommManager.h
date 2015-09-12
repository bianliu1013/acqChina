//
//  AcqCommManager.h
//  iAcqChina
//
//  Created by Dental Equipment on 3/21/15.
//  Copyright (c) 2015 iAcqChina. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GCDAsyncSocket;


@protocol AcqCommManagerDelegate <NSObject>
@optional
- (void)OnTriggerCaptureCmd: (NSString*)ftp_full_path;
@end


@interface AcqCommManager : NSObject
{
	
}


-(BOOL)SetupConnection;

-(BOOL)SendMessage:(NSData*) data withLen:(NSInteger)len;

-(BOOL)IsConnected;

@property (nonatomic, weak) id<AcqCommManagerDelegate> delegate;

@end
