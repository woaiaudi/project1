//
//  SLWLoginViewController.m
//  project1
//
//  Created by zyue on 14/12/8.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "SLWLoginViewController.h"
#import "SLWHome.h"

@interface SLWLoginViewController ()

@end

@implementation SLWLoginViewController

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

- (IBAction)loginAction:(id)sender {
    SLWHome * xx = [[SLWHome alloc]init];
    [self.navigationController pushViewController:xx animated:YES];
}
@end
