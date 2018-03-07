//
//  KLHomeView.m
//  kaile
//
//  Created by Monkey on 2018/3/3.
//  Copyright © 2018年 Monkey. All rights reserved.
//

#import "KLHomeView.h"

#import "KLHomeHeaderView.h"

#import "KLHomeBodyView.h"

#import <Masonry.h>

@implementation KLHomeView{
    
    KLHomeHeaderView *homeHeader;
    KLHomeBodyView *homeBody;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        
        // 添加子控件
        [self addAllSubView];
        
        // 联动
        [self linkage];
        
    }
    return self;
}

// 添加子控件
- (void) addAllSubView{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout .minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize =CGSizeMake(100, 40);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    homeHeader = [[KLHomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
    [self addSubview:homeHeader];
    
    UICollectionViewFlowLayout *flowLayout1 = [[UICollectionViewFlowLayout alloc]init];
    flowLayout1.minimumLineSpacing = 0;
    flowLayout1.minimumInteritemSpacing = 0;
    flowLayout1.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64 - 49 - 40);
    flowLayout1.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    homeBody = [[KLHomeBodyView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout1];
    homeBody.pagingEnabled = YES;
    [self addSubview:homeBody];
}

// 联动
- (void)linkage{
    
    __weak typeof(homeHeader) weakSelf = homeHeader;
    
    homeBody.linkage = ^(NSInteger page) {
        weakSelf.page = page;
    };
    
    __weak typeof(homeBody) weakSelfs = homeBody;
    
    homeHeader.linkage = ^(NSInteger page) {
        weakSelfs.page = page;
    };
}

#pragma mark ------------------------ 页面布局

- (void) layoutSubviews{
    [super layoutSubviews];

    [homeHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(64);
        make.left.equalTo(self).with.offset(0);
        make.right.equalTo(self).with.offset(0);
        make.height.greaterThanOrEqualTo(@40);
    }];
    
    [homeBody mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(104);
        make.left.equalTo(self).with.offset(0);
        make.right.equalTo(self).with.offset(0);
        make.height.greaterThanOrEqualTo(@(self.frame.size.height - 64 - 49 - 40));
    }];
}


@end
