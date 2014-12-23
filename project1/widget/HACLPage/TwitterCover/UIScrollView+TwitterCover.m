//
//  UIScrollView+TwitterCover.m
//  TwitterCover
//
//  Created by hangchen on 1/7/14.
//  Copyright (c) 2014 Hang Chen (https://github.com/cyndibaby905)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "UIScrollView+TwitterCover.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>


static char UIScrollViewTwitterCover;

@implementation UIScrollView (TwitterCover)

- (void)setTwitterCoverView:(CHTwitterCoverView *)twitterCoverView {
    [self willChangeValueForKey:@"twitterCoverView"];
    objc_setAssociatedObject(self, &UIScrollViewTwitterCover,
                             twitterCoverView,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"twitterCoverView"];
}

- (CHTwitterCoverView *)twitterCoverView {
    return objc_getAssociatedObject(self, &UIScrollViewTwitterCover);
}

- (void)addTwitterCoverWithImage:(id)image;
{
    [self addTwitterCoverWithImage:image withTopView:nil];
}

- (void)addTwitterCoverWithImage:(id)image withTopView:(UIView*)topView;
{
    CHTwitterCoverView *view = [[CHTwitterCoverView alloc] initWithFrame:CGRectMake(0,0, 320, CHTwitterCoverViewHeight) andContentTopView:topView];
    
    view.backgroundColor = [UIColor clearColor];
    view.image = image;
    view.scrollView = self;
    
    [self addSubview:view];
    if (topView) {
        [self addSubview:topView];
    }
    self.twitterCoverView = view;
}

- (void)removeTwitterCoverView
{
    [self.twitterCoverView removeFromSuperview];
    self.twitterCoverView = nil;
}
@end


@implementation CHTwitterCoverView
{
    UIView *topView;
}

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame andContentTopView:nil];
}

- (id)initWithFrame:(CGRect)frame andContentTopView:(UIView*)view
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        topView = view;
    }
    return self;
}

- (void)setImage:(id)image
{
    if ([image isKindOfClass:[UIImage class]]) {
        [super setImage:(UIImage *)image];
    }
    else if ([image isKindOfClass:[NSString class]])
    {
        //异步获取网络资源
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSError *error = nil;
            NSData *dataImg = [NSData dataWithContentsOfURL:[NSURL URLWithString:(NSString *)image] options:NSDataReadingMappedIfSafe error:&error];
            if ([error code] == 0)
            {
                //获取成功后，通过同步，回调主线程中的 设置图片
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [super setImage:[UIImage imageWithData:dataImg]];
                });
            }
            
        });
    }
    else
    {
        [super setImage:[UIImage imageNamed:@"noimg"]];
    }
    
}


- (void)setScrollView:(UIScrollView *)scrollView
{
    
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    _scrollView = scrollView;
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeFromSuperview
{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    [topView removeFromSuperview];
    [super removeFromSuperview];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.scrollView.contentOffset.y < 0) {

        CGFloat offset = -self.scrollView.contentOffset.y;
        topView.frame = CGRectMake(0, -offset, 320, topView.bounds.size.height);

        self.frame = CGRectMake(-offset,-offset + topView.bounds.size.height, 320+ offset * 2, CHTwitterCoverViewHeight + offset);
        NSInteger index = offset / 10;
        if (index < 0) {
            index = 0;
        }
        
    }
    else {
        topView.frame = CGRectMake(0, 0, 320, topView.bounds.size.height);

        self.frame = CGRectMake(0,topView.bounds.size.height, 320, CHTwitterCoverViewHeight);
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setNeedsLayout];
}

@end