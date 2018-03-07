//
//  KLHomeBodyView.m
//  kaile
//
//  Created by Monkey on 2018/3/3.
//  Copyright © 2018年 Monkey. All rights reserved.
//

#import "KLHomeBodyView.h"

#import "KLHomeHeaderViewCell.h"

@interface KLHomeBodyView () <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation KLHomeBodyView

static NSString * ID = @"ReuseIdentifier";

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self registerClass:[KLHomeHeaderViewCell class] forCellWithReuseIdentifier:ID];
        
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}


#pragma mark ------------------------ uicollection delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 15;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    KLHomeHeaderViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.classifyString = [NSString stringWithFormat:@"狼人杀%ld",indexPath.item];
    
    return cell;
}


//- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    NSLog(@"===== %ld ======",indexPath.item);
//}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    NSLog(@"==== %lf ===", targetContentOffset->x / [UIScreen mainScreen].bounds.size.width);
    
    NSInteger page = targetContentOffset->x / [UIScreen mainScreen].bounds.size.width;
    
    if (self.linkage) {
        self.linkage(page);
    }
}

- (void)setPage:(NSInteger)page{
    
    _page = page;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:page inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];

    });
}


@end
