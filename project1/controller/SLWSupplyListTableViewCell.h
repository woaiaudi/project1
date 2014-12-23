//
//  SLWSupplyListTableViewCell.h
//  project1
//
//  Created by zyue on 14/12/14.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLWSupplyListTableViewCell : UITableViewCell
+(NSString *)className;
+(CGFloat)heightForRow;
+ (void)registerNibToTableView:(UITableView *)tableView;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *jiage;
@property (strong, nonatomic) IBOutlet UILabel *area;
@property (strong, nonatomic) IBOutlet UILabel *fenglei;


@end
