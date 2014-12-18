//
//  SLWCompanyListTableViewCell.h
//  project1
//
//  Created by zyue on 14/12/18.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLWCompanyListTableViewCell : UITableViewCell
+(NSString *)className;
+(CGFloat)heightForRow;
+ (void)registerNibToTableView:(UITableView *)tableView;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@end
