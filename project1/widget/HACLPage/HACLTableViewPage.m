//
//  HACLTableViewPage.m
//  HACLPage
//
//  Created by admin on 14-6-17.
//  Copyright (c) 2014年 冲浪科技. All rights reserved.
//

#import "HACLTableViewPage.h"
#import "UIScrollView+TwitterCover.h"
#import "HACLPageClipCell.h"
#import "HATPageCellBean.h"
#import "ClipBigImage.h"
#import <UIImageView+WebCache.h>


#define FONT_SIZE 18.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f
#define BUTTONTAG 6412
@interface HACLTableViewPage ()

@end

@implementation HACLTableViewPage
{
    UIView *topView;
}
@synthesize pagetitle = _pagetitle;
@synthesize headImg = _headImg;
@synthesize items=_items;
@synthesize clipIndexSet = _clipIndexSet;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
            [self setEdgesForExtendedLayout:UIRectEdgeNone];
        }
        if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
            [self setAutomaticallyAdjustsScrollViewInsets:NO];
        }
    }
    return self;
}
-(id)initWithTitle:(NSString *)pageTitle head:(id)headimg topView:(UIView*)view footTabbarItems:(NSMutableArray *)tabbarItems
{
    self = [super init];
    if (self) {
        self.title = pageTitle;
        _headImg = headimg;
        topView = view;
        [self.tableView addTwitterCoverWithImage:_headImg withTopView:topView];
        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, CHTwitterCoverViewHeight + topView.bounds.size.height)];
        
        //添加 底部的tabbar
        [self addFooderViewByTabbarItems:tabbarItems];

    }
    return self;
}
-(void)setOnTabBecameEnabledBlock:(void(^)(NSUInteger index,RKTabItem *tabitem,UIViewController *thisViewController))tabClickBlock
{
    _tabBlock = tabClickBlock;
}
- (id)initWithTopView:(UIView*)view
{
    self = [super init];
    if (self) {
        topView = view;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    [self.tableView removeTwitterCoverView];
    _items = nil;
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_items count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *text = [_items objectAtIndex:[indexPath row]];
    if ([_clipIndexSet containsIndex:indexPath.row]) {
        //要显示clip图片,图片大小 100*100
        return 100.0f;
    }
    else
    {
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:text
     attributes:@
     {
         NSFontAttributeName:[UIFont fontWithName:@"Heiti SC" size:FONT_SIZE]
     }];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    
    
    CGFloat height = MAX(size.height, 44.0f);
    
    return height + (CELL_CONTENT_MARGIN * 2);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_clipIndexSet containsIndex:indexPath.row]) {
        //要显示clip图片,图片大小 100*100,使用显示图片的cell
        static NSString *clipCellIdentifier = @"clipCellIdentifier";
        HACLPageClipCell * clipcell=[tv dequeueReusableCellWithIdentifier:clipCellIdentifier];
        if (clipcell == nil) {
             clipcell = [[[NSBundle mainBundle] loadNibNamed:@"HACLPageClipCell" owner:self options:nil] lastObject];
        }
        HATPageCellBean * cellbean = (HATPageCellBean *)[_items objectAtIndex:indexPath.row];
        if ([cellbean.thumbImg isKindOfClass:[UIImage class]]) {
            //
            [clipcell.cellImg setImage:(UIImage *)cellbean.thumbImg];
        }
        else if([cellbean.thumbImg isKindOfClass:[NSString class]])
        {
            [clipcell.cellImg setImageWithURL:[NSURL URLWithString:(NSString *)cellbean.thumbImg] placeholderImage:[UIImage imageNamed:@"noimg"]];
        }
        else
        {
            [clipcell.cellImg setImage:[UIImage imageNamed:@"noimg"]];
        }
        
        clipcell.contentLabel.text = cellbean.imgDesc;
        return  clipcell;
    }
    else
    {

    UITableViewCell *cell;
    UILabel *label = nil;
    static NSString * pageCellIdentifier = @"pageCellIdentifier";
    cell = [tv dequeueReusableCellWithIdentifier:pageCellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pageCellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        label = [[UILabel alloc] initWithFrame:CGRectZero];
        [label setLineBreakMode:NSLineBreakByWordWrapping];
        [label setMinimumScaleFactor:FONT_SIZE];
        [label setNumberOfLines:0];
        [label setTextColor:[UIColor grayColor]];
        [label setFont:[UIFont fontWithName:@"Heiti SC" size:FONT_SIZE]];
        [label setTag:1];
        
//        [[label layer] setBorderWidth:2.0f];边框
        
        [[cell contentView] addSubview:label];
        
    }
    NSString *text = [_items objectAtIndex:[indexPath row]];
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    NSAttributedString *attributedText = [[NSAttributedString alloc]initWithString:text attributes:@{
                                                                                                     NSFontAttributeName:[UIFont fontWithName:@"Heiti SC" size:FONT_SIZE]
                                                                                                     }];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    
    if (!label)
        label = (UILabel*)[cell viewWithTag:1];
    
    [label setText:text];
    [label setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), MAX(size.height, 44.0f))];
    
    return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if ([_clipIndexSet containsIndex:indexPath.row]) {
         HATPageCellBean * cellbean = (HATPageCellBean *)[_items objectAtIndex:indexPath.row];
         ClipBigImage *bigImgPage = [[ClipBigImage alloc]initWithBigImage:cellbean.bigImg];
         [self presentViewController:bigImgPage animated:YES completion:nil];
     }
}
#pragma mark-如果设置了 底部的 tabbar 在这里实现
-(void)addFooderViewByTabbarItems:(NSMutableArray *)tabbarItems
{
    if (tabbarItems != nil && tabbarItems.count>0) {
        RKTabView *topicDetailFooderTabbar = [[RKTabView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        [topicDetailFooderTabbar setBackgroundColor:[UIColor clearColor]];
        topicDetailFooderTabbar.darkensBackgroundForEnabledTabs = NO;//点击时没有效果
        topicDetailFooderTabbar.horizontalInsets = HorizontalEdgeInsetsMake(10, 10);//左边和右边预留的 宽度
        topicDetailFooderTabbar.titlesFontColor = [UIColor blackColor];
        topicDetailFooderTabbar.titlesFont = [UIFont fontWithName:@"Heiti SC" size:15.0];
        topicDetailFooderTabbar.tabItems = tabbarItems;
        
        topicDetailFooderTabbar.delegate = self;
        self.tableView.tableFooterView = topicDetailFooderTabbar;
        
    }
}
- (void)tabView:(RKTabView *)tabView tabBecameEnabledAtIndex:(int)index tab:(RKTabItem *)tabItem
{
    tabItem.tabState = TabStateDisabled;//设置按钮状态为 可点击按钮
    _tabBlock(index,tabItem,self);
    NSLog(@"dianji::::%i",index);
}
@end
