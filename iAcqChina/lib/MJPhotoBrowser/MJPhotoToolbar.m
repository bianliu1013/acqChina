//
//  MJPhotoToolbar.m
//  FingerNews
//
//  Created by mj on 13-9-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MJPhotoToolbar.h"
#import "MJPhoto.h"
#import "MBProgressHUD+Add.h"

// peter
#import "AcqExport.h"

@interface MJPhotoToolbar()
{
    // 显示页码
    UILabel *_indexLabel;
    UIButton *_saveImageBtn;
    
    // tooth id buttons
    UIButton *_tooth_id_btn0;
    UIButton *_tooth_id_btn1;
    UIButton *_tooth_id_btn2;
    UIButton *_tooth_id_btn3;
    UIButton *_tooth_id_btn4;
    UIButton *_tooth_id_btn5;

//    NSMutableArray *_tooth_id_labels;
//    UILabel *_tooth_id_label_0;
//    UILabel *_tooth_id_label_1;
//    UILabel *_tooth_id_label_2;
//    UILabel *_tooth_id_label_3;
//    UILabel *_tooth_id_label_4;
//    UILabel *_tooth_id_label_5;
}
@end

@implementation MJPhotoToolbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    if (_photos.count > 1) {
        _indexLabel = [[UILabel alloc] init];
        _indexLabel.font = [UIFont boldSystemFontOfSize:20];
        _indexLabel.frame = self.bounds;
        _indexLabel.backgroundColor = [UIColor clearColor];
        _indexLabel.textColor = [UIColor whiteColor];
        _indexLabel.textAlignment = NSTextAlignmentCenter;
        _indexLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:_indexLabel];
    }
    
    // 保存图片按钮
    CGFloat btnWidth =  29;//self.bounds.size.height / 2;
    CGFloat btnHeight = 29;
    CGFloat label_height = 20;
    CGFloat label_width = 29;
//    _saveImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _saveImageBtn.frame = CGRectMake(20, 0, btnWidth, btnHeight);
//    //_saveImageBtn.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//    [_saveImageBtn setImage:[UIImage imageNamed:@"MJPhotoBrowser.bundle/save_icon.png"] forState:UIControlStateNormal];
//    [_saveImageBtn setImage:[UIImage imageNamed:@"MJPhotoBrowser.bundle/save_icon_highlighted.png"] forState:UIControlStateHighlighted];
//    [_saveImageBtn addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:_saveImageBtn];
    
    
    // -------------------------------------------------------
    // tooth id buttons
    int width_margin = (self.bounds.size.width - btnWidth * 6) / 7;
    int btn_x_pos = width_margin;
    int btn_y_pos = 50;
    
//    NSMutableArray *newArray = [[NSMutableArray alloc] init];
//    _tooth_id_labels = [[NSMutableArray alloc] init];
    
    int btn_count = 6;
    NSArray *label_text_array = [NSArray arrayWithObjects:@"上左",@"上右",@"下左",@"下右",@"门上",@"门下", nil];
    
    for(int i = 0; i < btn_count; i++) {
        //NSString* label = [[label_text_array objectAtIndex:i] copy];
        UILabel *label = [[UILabel alloc] init];
        label = [[UILabel alloc] init];
        label.font = [UIFont boldSystemFontOfSize:10];
        label.frame = CGRectMake(btn_x_pos, btn_y_pos + btnHeight, label_width, label_height);
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        label.text = [label_text_array objectAtIndex:i];
        
        UIButton *tooth_id_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        tooth_id_btn.tag = i;
        tooth_id_btn.frame = CGRectMake(btn_x_pos, btn_y_pos, btnWidth, btnHeight);
        [tooth_id_btn setImage:[UIImage imageNamed:@"MJPhotoBrowser.bundle/save_icon.png"] forState:UIControlStateNormal];
        [tooth_id_btn setImage:[UIImage imageNamed:@"MJPhotoBrowser.bundle/save_icon_highlighted.png"] forState:UIControlStateHighlighted];
        [tooth_id_btn addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self addSubview:tooth_id_btn];
        [self addSubview:label];
        
        btn_x_pos += width_margin + btnWidth;
    }
    
#if 0
    
    _tooth_id_label_0 = [[UILabel alloc] init];
    _tooth_id_label_0.font = [UIFont boldSystemFontOfSize:10];
    _tooth_id_label_0.frame = CGRectMake(btn_x_pos, btn_y_pos + btnHeight, label_width, label_height);
    _tooth_id_label_0.backgroundColor = [UIColor clearColor];
    _tooth_id_label_0.textColor = [UIColor whiteColor];
    _tooth_id_label_0.textAlignment = NSTextAlignmentCenter;
    _tooth_id_label_0.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _tooth_id_label_0.text = @"上左";
    
    //CGFloat btnWidth = self.bounds.size.height;
    _tooth_id_btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
    _tooth_id_btn0.frame = CGRectMake(btn_x_pos, btn_y_pos, btnWidth, btnHeight);
    //_tooth_id_btn0.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [_tooth_id_btn0 setImage:[UIImage imageNamed:@"MJPhotoBrowser.bundle/save_icon.png"] forState:UIControlStateNormal];
    [_tooth_id_btn0 setImage:[UIImage imageNamed:@"MJPhotoBrowser.bundle/save_icon_highlighted.png"] forState:UIControlStateHighlighted];
    [_tooth_id_btn0 addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_tooth_id_btn0];
    [self addSubview:_tooth_id_label_0];

    
    
    btn_x_pos += width_margin + btnWidth;
    _tooth_id_label_1 = [[UILabel alloc] init];
    _tooth_id_label_1.font = [UIFont boldSystemFontOfSize:10];
    _tooth_id_label_1.frame = CGRectMake(btn_x_pos, btn_y_pos + btnHeight, label_width, label_height);
    _tooth_id_label_1.backgroundColor = [UIColor clearColor];
    _tooth_id_label_1.textColor = [UIColor whiteColor];
    _tooth_id_label_1.textAlignment = NSTextAlignmentCenter;
    _tooth_id_label_1.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _tooth_id_label_1.text = @"上右";
    
    _tooth_id_btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _tooth_id_btn1.frame = CGRectMake(btn_x_pos, btn_y_pos, btnWidth, btnHeight);
    //_tooth_id_btn1.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [_tooth_id_btn1 setImage:[UIImage imageNamed:@"MJPhotoBrowser.bundle/save_icon.png"] forState:UIControlStateNormal];
    [_tooth_id_btn1 setImage:[UIImage imageNamed:@"MJPhotoBrowser.bundle/save_icon_highlighted.png"] forState:UIControlStateHighlighted];
    [_tooth_id_btn1 addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_tooth_id_btn1];
    [self addSubview:_tooth_id_label_1];

    
    btn_x_pos += width_margin + btnWidth;
    
    _tooth_id_label_2 = [[UILabel alloc] init];
    _tooth_id_label_2.font = [UIFont boldSystemFontOfSize:10];
    _tooth_id_label_2.frame = CGRectMake(btn_x_pos, btn_y_pos + btnHeight, label_width, label_height);
    _tooth_id_label_2.backgroundColor = [UIColor clearColor];
    _tooth_id_label_2.textColor = [UIColor whiteColor];
    _tooth_id_label_2.textAlignment = NSTextAlignmentCenter;
    _tooth_id_label_2.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _tooth_id_label_2.text = @"下左";
    
    _tooth_id_btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _tooth_id_btn2.frame = CGRectMake(btn_x_pos, btn_y_pos, btnWidth, btnHeight);
    //_tooth_id_btn2.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [_tooth_id_btn2 setImage:[UIImage imageNamed:@"MJPhotoBrowser.bundle/save_icon.png"] forState:UIControlStateNormal];
    [_tooth_id_btn2 setImage:[UIImage imageNamed:@"MJPhotoBrowser.bundle/save_icon_highlighted.png"] forState:UIControlStateHighlighted];
    [_tooth_id_btn2 addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_tooth_id_btn2];
    [self addSubview:_tooth_id_label_2];

    
    btn_x_pos += width_margin + btnWidth;

    _tooth_id_label_3 = [[UILabel alloc] init];
    _tooth_id_label_3.font = [UIFont boldSystemFontOfSize:10];
    _tooth_id_label_3.frame = CGRectMake(btn_x_pos, btn_y_pos + btnHeight, label_width, label_height);
    _tooth_id_label_3.backgroundColor = [UIColor clearColor];
    _tooth_id_label_3.textColor = [UIColor whiteColor];
    _tooth_id_label_3.textAlignment = NSTextAlignmentCenter;
    _tooth_id_label_3.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _tooth_id_label_3.text = @"下右";

    _tooth_id_btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    _tooth_id_btn3.frame = CGRectMake(btn_x_pos, btn_y_pos, btnWidth, btnHeight);
    //_tooth_id_btn3.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [_tooth_id_btn3 setImage:[UIImage imageNamed:@"MJPhotoBrowser.bundle/save_icon.png"] forState:UIControlStateNormal];
    [_tooth_id_btn3 setImage:[UIImage imageNamed:@"MJPhotoBrowser.bundle/save_icon_highlighted.png"] forState:UIControlStateHighlighted];
    [_tooth_id_btn3 addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_tooth_id_btn3];
    [self addSubview:_tooth_id_label_3];

    
    btn_x_pos += width_margin + btnWidth;

    _tooth_id_label_4 = [[UILabel alloc] init];
    _tooth_id_label_4.font = [UIFont boldSystemFontOfSize:10];
    _tooth_id_label_4.frame = CGRectMake(btn_x_pos, btn_y_pos + btnHeight, label_width, label_height);
    _tooth_id_label_4.backgroundColor = [UIColor clearColor];
    _tooth_id_label_4.textColor = [UIColor whiteColor];
    _tooth_id_label_4.textAlignment = NSTextAlignmentCenter;
    _tooth_id_label_4.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _tooth_id_label_4.text = @"门上";

    _tooth_id_btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    _tooth_id_btn4.frame = CGRectMake(btn_x_pos, btn_y_pos, btnWidth, btnHeight);
    //_tooth_id_btn4.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [_tooth_id_btn4 setImage:[UIImage imageNamed:@"MJPhotoBrowser.bundle/save_icon.png"] forState:UIControlStateNormal];
    [_tooth_id_btn4 setImage:[UIImage imageNamed:@"MJPhotoBrowser.bundle/save_icon_highlighted.png"] forState:UIControlStateHighlighted];
    [_tooth_id_btn4 addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_tooth_id_btn4];
    [self addSubview:_tooth_id_label_4];

    
    btn_x_pos += width_margin + btnWidth;

    _tooth_id_label_5 = [[UILabel alloc] init];
    _tooth_id_label_5.font = [UIFont boldSystemFontOfSize:10];
    _tooth_id_label_5.frame = CGRectMake(btn_x_pos, btn_y_pos + btnHeight, label_width, label_height);
    _tooth_id_label_5.backgroundColor = [UIColor clearColor];
    _tooth_id_label_5.textColor = [UIColor whiteColor];
    _tooth_id_label_5.textAlignment = NSTextAlignmentCenter;
    _tooth_id_label_5.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _tooth_id_label_5.text = @"门下";

    _tooth_id_btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    _tooth_id_btn5.frame = CGRectMake(btn_x_pos, btn_y_pos, btnWidth, btnHeight);
    //_tooth_id_btn5.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [_tooth_id_btn5 setImage:[UIImage imageNamed:@"MJPhotoBrowser.bundle/save_icon.png"] forState:UIControlStateNormal];
    [_tooth_id_btn5 setImage:[UIImage imageNamed:@"MJPhotoBrowser.bundle/save_icon_highlighted.png"] forState:UIControlStateHighlighted];
    [_tooth_id_btn5 addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_tooth_id_btn5];
    [self addSubview:_tooth_id_label_5];
#endif
    
    
    // peter
    _acqExportTools = [AcqExport alloc];
}

- (void)saveImage
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        MJPhoto *photo = _photos[_currentPhotoIndex];
        UIImageWriteToSavedPhotosAlbum(photo.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    });
    
    [_delegate OnSaveClicked:@"he"];
    [_acqExportTools ExportImageToDoctor:1 didwithPath:@"test"];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        //[MBProgressHUD showSuccess:@"保存失败" toView:nil];
    } else {
        MJPhoto *photo = _photos[_currentPhotoIndex];
        photo.save = YES;
        _saveImageBtn.enabled = NO;
        [MBProgressHUD showSuccess:@"成功保存到相册" toView:nil];
    }
}

- (void)setCurrentPhotoIndex:(NSUInteger)currentPhotoIndex
{
    _currentPhotoIndex = currentPhotoIndex;
    
    // 更新页码
    _indexLabel.text = [NSString stringWithFormat:@"%d / %d", _currentPhotoIndex + 1, _photos.count];
    
    MJPhoto *photo = _photos[_currentPhotoIndex];
    // 按钮
    _saveImageBtn.enabled = photo.image != nil && !photo.save;
}

@end
