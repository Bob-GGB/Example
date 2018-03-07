//
//  KLHomeHeaderView.m
//  kaile
//
//  Created by Monkey on 2018/3/3.
//  Copyright © 2018年 Monkey. All rights reserved.
//

#import "KLHomeHeaderView.h"

#import "KLHomeHeaderViewCell.h"

#import <Masonry.h>

@interface KLHomeHeaderView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic ,strong) UIView *lineView;

@end

@implementation KLHomeHeaderView

static NSString * ID = @"ReuseIdentifier";

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self registerClass:[KLHomeHeaderViewCell class] forCellWithReuseIdentifier:ID];
        
        self.lineView = [[UIView alloc]init];
        self.lineView.backgroundColor = [UIColor yellowColor];
        [self addSubview:_lineView];
        self.lineView.frame = CGRectMake(4, 38, 92, 2);
    
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

#pragma mark ------------------------ uicollection delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 15;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // 挑战cell
    if (self.linkage) {
        self.linkage(indexPath.item);
    }
    
    [UIView animateWithDuration:0.1 animations:^{
        
        self.lineView.frame = CGRectMake(4 + 100 * indexPath.item, 38, 92, 2);
    }];
    
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    KLHomeHeaderViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.classifyString = [NSString stringWithFormat:@"狼人杀%ld",indexPath.item];
    
    // cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255.0) / 256.0 green:arc4random_uniform(255.0) / 256.0 blue:arc4random_uniform(255.0) / 256.0 alpha:1.0];
    
    return cell;
}

- (void)setPage:(NSInteger)page{
    
    _page = page;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:page inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        
        [UIView animateWithDuration:0.1 animations:^{
           
            self.lineView.frame = CGRectMake(4 + 100 * page, 38, 92, 2);
        }];
    });
}


@end
