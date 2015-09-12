//
//  PhotoViewCell.m
//  iAcqChina
//
//  Created by Dental Equipment on 12/27/14.
//  Copyright (c) 2014 iAcqChina. All rights reserved.
//

#import "PhotoViewCell.h"

@implementation PhotoViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (IBAction)onCloseClicked:(id)sender {
    [self.delegate onCloseClicked:self];
    //- (void)onCloseClicked:(PhotoViewCell *)photoViewCell andIndex:(NSUInteger)index;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
