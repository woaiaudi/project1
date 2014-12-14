//
//  SLWSupplyListViewController.m
//  project1
//
//  Created by zyue on 14/12/14.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "SLWSupplyListViewController.h"

@interface SLWSupplyListViewController ()
{
    NIDropDown * dropDown;
}
@end

@implementation SLWSupplyListViewController

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

- (IBAction)yongtuButtonAction:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    //不能超过11个汉字
    arr = [NSArray arrayWithObjects:@"好问问很长很长很长很长", @"Hello 1", @"Hello 2", @"Hello 3", @"Hello 4", @"Hello 5", @"Hello 6", @"Hello 7", @"Hello 8", @"Hello 9",nil];
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

- (IBAction)diquButtonAction:(id)sender {
    UIButton * btnSender = (UIButton *)sender;
    //[btnSender setBackgroundImage:[UIImage imageNamed:@"arrow_down.png"] forState:UIControlStateNormal];
    [btnSender setTitle:@"xxsd" forState:UIControlStateNormal];
}

- (IBAction)guigeButtonAction:(id)sender {
}
- (void) niDropDownDelegateMethod: (NIDropDown *) sender byClickedButton:(UIButton *)button selectedIndex:(NSIndexPath *)index
{

    dropDown = nil;
    NSLog(@"点击了按钮【%d】后，选中了S[%d],R[%d]",button.tag,index.section,index.row);
}
@end
