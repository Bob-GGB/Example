//
//  KLBaseTableViewController.m
//  kaile
//
//  Created by Monkey on 2018/3/1.
//  Copyright © 2018年 Monkey. All rights reserved.
//

#import "KLBaseTableViewController.h"

@interface KLBaseTableViewController ()

@end

@implementation KLBaseTableViewController

//封装下拉以及上拉刷新
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    
    self.tableView.mj_header = self.header;
    self.tableView.mj_footer = self.footer;
    self.footer.hidden = YES;
    
   // _defaults = [NSUserDefaults standardUserDefaults];
}

- (void)endNewLoad{
    [self.header endRefreshing];
}

- (void)endOldLoad{
    [self.footer endRefreshing];
}

@end
