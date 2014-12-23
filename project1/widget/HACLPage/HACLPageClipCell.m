//
//  HACLPageClipCell.m
//  HACLPage
//
//  Created by admin on 14-6-17.
//  Copyright (c) 2014年 冲浪科技. All rights reserved.
//

#import "HACLPageClipCell.h"

@implementation HACLPageClipCell
- (void)awakeFromNib
{
    // Initialization code
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    self.cellImg.layer.masksToBounds = YES;
    self.cellImg.layer.cornerRadius = 10.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
