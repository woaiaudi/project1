//
//  SLWAboutUsViewController.m
//  project1
//
//  Created by zyue on 14/12/27.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "SLWAboutUsViewController.h"
#import "HACLPage.h"
#import "TOWebViewController.h"
#import <ShareSDK/ShareSDK.h>


@interface SLWAboutUsViewController ()

@end

@implementation SLWAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        //打电话
        UIBarButtonItem *callBarButton =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"call.png"] style:UIBarButtonItemStyleDone target:self action:@selector(callAction:)];
        //callBarButton.title = @"025-66078709";
    
    
        UIBarButtonItem *messageBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"message.png"] style:UIBarButtonItemStyleDone target:self action:@selector(messageAction:)];
    
    
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:callBarButton,messageBarButton, nil];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)callAction:(UIBarButtonItem *)sender{
    [ACETelPrompt callPhoneNumber:@"025-66078709"
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
- (IBAction)openWebsiteAction:(id)sender {
    NSString *urlStr = ((UIButton *)sender).titleLabel.text;
    NSURL * actionURL = [NSURL URLWithString:urlStr];
    TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:actionURL];
    [self.navigationController pushViewController:webViewController animated:YES];
//    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:webViewController] animated:YES completion:nil];
}

- (IBAction)shareAction:(id)sender {
    //创建自定义分享列表
    NSArray *shareList = [ShareSDK getShareListWithType:
                          ShareTypeSinaWeibo,
                          ShareTypeQQ,
                          ShareTypeWeixiSession,
                          ShareTypeWeixiTimeline,nil];
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK" ofType:@"png"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
                                       defaultContent:@"测试一下"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"ShareSDK"
                                                  url:@"http://www.mob.com"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];

//    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:shareList
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                }
                            }];
}
@end
