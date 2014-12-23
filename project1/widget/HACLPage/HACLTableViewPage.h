//
//  HACLTableViewPage.h
//  HACLPage
//
//  Created by admin on 14-6-17.
//  Copyright (c) 2014年 冲浪科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKTabView.h"

typedef void (^OnTabBecameEnabledBlock)(NSUInteger index,RKTabItem *tabitem,UIViewController *thisViewController);//底部tabbar 点击事件block
@interface HACLTableViewPage : UITableViewController<RKTabViewDelegate>

@property(nonatomic,retain)NSString *pagetitle;
@property(nonatomic,retain) id headImg;


@property (nonatomic,retain) NSMutableArray *items;
@property (nonatomic,retain) NSMutableIndexSet *clipIndexSet;

- (id)initWithTopView:(UIView*)view;
-(id)initWithTitle:(NSString *)pageTitle head:(id)headimg topView:(UIView*)view footTabbarItems:(NSMutableArray *)tabbarItems;



@property(nonatomic,copy)OnTabBecameEnabledBlock tabBlock;
-(void)setOnTabBecameEnabledBlock:(void(^)(NSUInteger index,RKTabItem *tabitem,UIViewController *thisViewController))tabClickBlock;
@end
