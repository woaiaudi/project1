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


@end
