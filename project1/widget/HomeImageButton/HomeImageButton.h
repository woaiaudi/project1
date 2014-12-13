//
//  HomeImageButton.h
//  project1
//
//  Created by zyue on 14/12/13.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^HomeImageClickBlock)(UIImageView *);//定义block

@interface HomeImageButton : UIImageView
@property(nonatomic,copy)HomeImageClickBlock homeImageClickBlock;//申明block
-(void)setOnImageClickListener:(void(^)(UIImageView * clickedImage))clickBlock;
@end
