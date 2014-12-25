//
//  SLWBBSListTableViewCell.m
//  project1
//
//  Created by zyue on 14/12/25.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "SLWBBSListTableViewCell.h"

@implementation SLWBBSListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
+(NSString *)className
{
    return NSStringFromClass([self class]);
}
+(CGFloat)heightForRow
{
    return 60;
}
+ (void)registerNibToTableView:(UITableView *)tableView
{
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([self class])];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
