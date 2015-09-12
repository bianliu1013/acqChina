//
//  AcqExport.h
//  iAcqChina
//
//  Created by Dental Equipment on 12/21/14.
//  Copyright (c) 2014 iAcqChina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AcqExport : NSObject
-(void)ExportImageToDoctor:(NSInteger)imageindx didwithPath:(NSString*)imagepath;
@end
