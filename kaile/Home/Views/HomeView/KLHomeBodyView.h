//
//  KLHomeBodyView.h
//  kaile
//
//  Created by Monkey on 2018/3/3.
//  Copyright © 2018年 Monkey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLHomeBodyView : UICollectionView

// 联动
@property (nonatomic ,copy) void (^linkage)(NSInteger page);

// 选择页面
@property (nonatomic ,assign) NSInteger page;

@end
