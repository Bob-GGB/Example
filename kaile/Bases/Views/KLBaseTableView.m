//
//  KLBaseTableView.m
//  kaile
//
//  Created by Monkey on 2018/3/3.
//  Copyright © 2018年 Monkey. All rights reserved.
//

#import "KLBaseTableView.h"

@implementation KLBaseTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        __weak __typeof(self) weakSelf = self;
        WKRefreshGifHeader *header = [WKRefreshGifHeader headerWithRefreshingBlock:^{
            if (weakSelf.DropDownRefreshBlock){
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
                    weakSelf.DropDownRefreshBlock();
                });
            }
        }];
        
        self.header = header;
        
        WKRefreshBackGifFooter *footer = [WKRefreshBackGifFooter footerWithRefreshingBlock:^{
            if (weakSelf.UpDropRefreshBlock){
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
                    weakSelf.UpDropRefreshBlock();
                });
            }
        }];
        
        self.footer = footer;
        
        self.mj_header = self.header;
        self.mj_footer = self.footer;
        self.footer.hidden = YES;
        
    }
    return self;
}

- (void)endNewLoad{
    [self.header endRefreshing];
}

- (void)endOldLoad{
    [self.footer endRefreshing];
}


@end
