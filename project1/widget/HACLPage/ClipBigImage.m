//
//  ClipBigImage.m
//  解读淮安
//
//  Created by admin on 14-6-16.
//  Copyright (c) 2014年 冲浪科技. All rights reserved.
//

#import "ClipBigImage.h"
#import <UIImageView+WebCache.h>
@interface ClipBigImage ()

@end

@implementation ClipBigImage
@synthesize bigImage;
@synthesize clipBigImageObj = _clipBigImageObj;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithBigImage:(id)bigimg
{
    self = [super init];
    if (self) {
        _clipBigImageObj = bigimg;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 单击的 Recognizer
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [self.view addGestureRecognizer:singleRecognizer];
    
    
    if ([_clipBigImageObj isKindOfClass:[UIImage class]]) {
        //
        [self.bigImage setImage:(UIImage *)_clipBigImageObj];
    }
    else if([_clipBigImageObj isKindOfClass:[NSString class]])
    {
        [self.bigImage setImageWithURL:[NSURL URLWithString:(NSString *)_clipBigImageObj] placeholderImage:[UIImage imageNamed:@"noimg"]];
    }
    else
    {
        [self.bigImage setImage:[UIImage imageNamed:@"noimg"]];
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
    //处理单击操作
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
