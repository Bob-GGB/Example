//
//  KLHomeHeaderViewCell.m
//  kaile
//
//  Created by Monkey on 2018/3/3.
//  Copyright © 2018年 Monkey. All rights reserved.
//

#import "KLHomeHeaderViewCell.h"

@implementation KLHomeHeaderViewCell{
    
    // 添加标题
    UILabel *titleLab;
    // 添加背景
//    UIImageView *backImgView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加子控件
        [self addAllSubView];
    }
    return self;
}

#pragma mark ----------------- 添加子控件

- (void) addAllSubView{
//    [self addSubview:backImgView];
    
    titleLab = [[UILabel alloc]init];
    titleLab.textColor = [UIColor blackColor];
    titleLab.textAlignment =  NSTextAlignmentCenter;
    titleLab.textColor = [UIColor whiteColor];
    titleLab.font = [UIFont systemFontOfSize:13.0f];
    
    [self addSubview:titleLab];
}

#pragma mark ----------------- 赋值

-(void)setClassifyString:(NSString *)classifyString{
    
    _classifyString  = classifyString;
    titleLab.text = classifyString;
}

#pragma mark ----------------- 布局

- (void)layoutSubviews{
    [super layoutSubviews];
    
//    backImgView.frame = self.bounds;
    titleLab.frame = self.bounds;
    
}

@end
