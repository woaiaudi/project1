//
//  SLWSearchViewController.m
//  project1
//
//  Created by zyue on 14/12/18.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "SLWSearchViewController.h"

@interface SLWSearchViewController ()
{
    NIDropDown * dropDown;
    TSLocateView *locateView;
}

@end

@implementation SLWSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)searchTypeButtonAction:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    //不能超过11个汉字
    arr = [NSArray arrayWithObjects:@"全部",@"企业", @"原料",@"再生料",@"助剂",@"制品",@"模具",nil];
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :nil :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        dropDown = nil;
    }
}
#pragma mark - 下拉点击回调事件
- (void) niDropDownDelegateMethod: (NIDropDown *) sender byClickedButton:(UIButton *)button selectedIndex:(NSIndexPath *)index
{
    
    dropDown = nil;
    NSLog(@"点击了按钮【%d】后，选中了S[%d],R[%d]",button.tag,index.section,index.row);
}

#pragma mark-地区选择
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    TSLocateView *locateView = (TSLocateView *)actionSheet;
    TSLocation *location = locateView.locate;
    NSLog(@"city:%@ lat:%f lon:%f", location.city, location.latitude, location.longitude);
    //You can uses location to your application.
    if(buttonIndex == 0) {
        NSLog(@"Cancel");
    }else {
        NSLog(@"Select");
        [_cityButton setTitle:location.city forState:UIControlStateNormal];
    }
}
- (IBAction)cityAction:(id)sender {
    if (!locateView) {
        locateView = [[TSLocateView alloc] initWithTitle:@"选择城市" delegate:self];
    }
    [locateView showInView:self.view];
    
}
@end
