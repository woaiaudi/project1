//
//  ClipBigImage.h
//  解读淮安
//
//  Created by admin on 14-6-16.
//  Copyright (c) 2014年 冲浪科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClipBigImage : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *bigImage;
@property(nonatomic,retain)id clipBigImageObj;
-(id)initWithBigImage:(id)bigimg;
@end
