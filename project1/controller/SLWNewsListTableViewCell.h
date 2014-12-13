//
//  SLWNewsListTableViewCell.h
//  project1
//
//  Created by 张跃 on 14/12/13.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLWNewsListTableViewCell : UITableViewCell

+(NSString *)className;
+(CGFloat)heightForRow;
+ (void)registerNibToTableView:(UITableView *)tableView;
@property (strong, nonatomic) IBOutlet UILabel *newsTitleLabel;
@end
