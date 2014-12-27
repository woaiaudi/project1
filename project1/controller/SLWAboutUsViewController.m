//
//  SLWAboutUsViewController.m
//  project1
//
//  Created by zyue on 14/12/27.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "SLWAboutUsViewController.h"
#import "HACLPage.h"


@interface SLWAboutUsViewController ()

@end

@implementation SLWAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        //打电话
        UIBarButtonItem *callBarButton =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"call.png"] style:UIBarButtonItemStyleDone target:self action:@selector(callAction:)];
        callBarButton.title = @"025-66078709";
    
    
        UIBarButtonItem *messageBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"message.png"] style:UIBarButtonItemStyleDone target:self action:@selector(messageAction:)];
    
    
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:callBarButton,messageBarButton, nil];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)callAction:(UIBarButtonItem *)sender{
    [ACETelPrompt callPhoneNumber:sender.title
                             call:^(NSTimeInterval duration) {
                                 NSLog(@"User made a call of %.1f seconds", duration);
                                 
                             } cancel:^{
                                 NSLog(@"User cancelled the call");
                             }];
}
-(void)messageAction:(UIBarButtonItem *)sender{
    self.stAlertView = [[STAlertView alloc] initWithTitle:@"留言"
                                                          message:@"你的任何意见，都将是我们前行路上宝贵的指引"
                                                    textFieldHint:@"留下些什么..."
                                                   textFieldValue:nil
                                                cancelButtonTitle:@"取消"
                                                 otherButtonTitle:@"确定"
                                
                                                cancelButtonBlock:^{
                                                    NSLog(@"Please, give me some feedback!");
                                                } otherButtonBlock:^(NSString * result){
                                                    NSLog(@" You have said %@, but I can't store it :( . If you want, you can send it to me at hello@nestor.cat or via twitter @NestorMalet!", result);
                                                }];
    
    //You can make any customization to the native UIAlertView
    self.stAlertView.alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    //    [[self.stAlertView.alertView textFieldAtIndex:1] setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    
    [self.stAlertView show];
    
}
@end
