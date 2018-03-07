//
//  KLBaseTableView.h
//  kaile
//
//  Created by Monkey on 2018/3/3.
//  Copyright © 2018年 Monkey. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WKRefreshGifHeader.h"

#import "WKRefreshBackGifFooter.h"

@interface KLBaseTableView : UITableView

@property(nonatomic,strong) WKRefreshGifHeader *header;

@property(nonatomic,strong)  WKRefreshBackGifFooter *footer;

@property(nonatomic,strong) NSUserDefaults *defaults;

//回调网络请求（新数据）
@property(nonatomic,copy) void (^DropDownRefreshBlock)(void);

//回调网络请求（旧数据）
@property(nonatomic,copy) void (^UpDropRefreshBlock)(void);

//结束下拉刷新
- (void)endNewLoad;

//结束上拉刷新
- (void)endOldLoad;

@end
