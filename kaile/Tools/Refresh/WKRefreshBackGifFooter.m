//
//  WKRefreshBackGifFooter.m
//  kaile
//
//  Created by Monkey on 2018/3/1.
//  Copyright © 2018年 Monkey. All rights reserved.
//

#import "WKRefreshBackGifFooter.h"

@implementation WKRefreshBackGifFooter

- (void)prepare{
    [super prepare];
    
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 0; i<= 30; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_refresh_%zd", i]];
        [idleImages addObject:image];
    }
    
    // 设置普通状态的动画图片
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 0; i<= 1; i++) {
        UIImage *image = [UIImage imageNamed:@"icon_refresh_0"];
        [refreshingImages addObject:image];
    }
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:idleImages forState:MJRefreshStateRefreshing];
}

@end
