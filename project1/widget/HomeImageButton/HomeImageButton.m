//
//  HomeImageButton.m
//  project1
//
//  Created by 张跃 on 14/12/13.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "HomeImageButton.h"

@implementation HomeImageButton
@synthesize homeImageClickBlock;
-(void)awakeFromNib {
    [super awakeFromNib];
    [self setUserInteractionEnabled:YES];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCategory:)]];
}

-(void)setOnImageClickListener:(void(^)(UIImageView * clickedImage))clickBlock
{
    homeImageClickBlock = clickBlock;
}

-(void)clickCategory:(UITapGestureRecognizer *)gestureRecognizer
{
    NSLog(@"HomeImageButton _ homeImageClickBlock _ viewClicked[%@]",NSStringFromClass([gestureRecognizer.view class]));
    
    if ([gestureRecognizer.view isKindOfClass:[UIImageView class]])
    {
        homeImageClickBlock((UIImageView *)gestureRecognizer.view);
    }else{
        //NSLog(@"viewClicked[%@] not UIImageView",NSStringFromClass([gestureRecognizer.view class]));
    }
}
@end
