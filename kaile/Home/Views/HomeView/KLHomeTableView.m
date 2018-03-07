//
//  KLHomeTableView.m
//  kaile
//
//  Created by Monkey on 2018/3/3.
//  Copyright © 2018年 Monkey. All rights reserved.
//

#import "KLHomeTableView.h"

@implementation KLHomeTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        /** 下拉刷新、上提更多 **/
        __weak typeof(self) weakSelf = self;
        self.DropDownRefreshBlock = ^{
            [weakSelf loadNewData];
        };
        
        self.UpDropRefreshBlock = ^{
            [weakSelf loadOldData];
        };
    }
    return self;
}

#pragma mark ----------------- 加载新数据
- (void)loadNewData{
    
    self.footer.hidden = NO;
    
    // 获取数据
    //[self getDataWithUrlString:Activities_ActivitiesList andParameters:@{@"page" : @(_page)}];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self endNewLoad];
    });
}

#pragma mark ----------------- 获取老数据

- (void)loadOldData{
    
    // [self getDataWithUrlString:Activities_ActivitiesList andParameters:@{@"page" : @(_page)}];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self endOldLoad];
    });
}

@end
