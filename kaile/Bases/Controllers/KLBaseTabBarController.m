//
//  KLBaseTabBarController.m
//  kaile
//
//  Created by Monkey on 2018/3/1.
//  Copyright © 2018年 Monkey. All rights reserved.
//

#import "KLBaseTabBarController.h"

#import "KLBaseNavigationController.h"

// #import "KLHomeViewControllers.h"

#import "KLIMViewController.h"

#import "KLLBViewController.h"

#import "KLHomeVC.h"
#import "TransitionAnimation.h"
#import "TransitionController.h"

@interface KLBaseTabBarController ()<UITabBarControllerDelegate>
@property(nonatomic,strong)UIPanGestureRecognizer *panGestureRecognizer;
@end

@implementation KLBaseTabBarController

// 设置字体颜色
+(void)initialize {
    
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor]} forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]} forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加子控件
    [self addAllSubViewControllers];
    self.delegate = self;
    self.selectedIndex = 0;
    // 添加pan手势
    [self.view addGestureRecognizer:self.panGestureRecognizer];
}

// 添加子控件
- (void)addAllSubViewControllers{
    
    // 首页
    KLBaseNavigationController *homeController = [self subViewControllerWithClass:[KLHomeVC class] andTitle:@"首页"];
    
    // IM
    KLBaseNavigationController *imController = [self subViewControllerWithClass:[KLIMViewController class] andTitle:@"聊天"];
    
    // LB
    KLBaseNavigationController *lbController = [self subViewControllerWithClass:[KLLBViewController class] andTitle:@"直播"];
    
    self.viewControllers = @[homeController,imController,lbController];
    
    // 添加图片
    [self setItemImageWithString:@"home_icon" andIndex:0];
    [self setItemImageWithString:@"massages_icon" andIndex:1];
    [self setItemImageWithString:@"order_icon" andIndex:2];
}

// 初始化子控制器
- (KLBaseNavigationController *) subViewControllerWithClass:(Class)class andTitle:(NSString *)title{
    
    UIViewController *vc  = [[class alloc]init];
    vc.title = title;
    
    KLBaseNavigationController *nav = [[KLBaseNavigationController alloc]initWithRootViewController:vc];
    //设置导航栏标题颜色
    [nav.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor redColor]}];
    

    return nav;
}

//设置item图片
- (void) setItemImageWithString:(NSString *)imageName andIndex:(NSUInteger)index{
    
    UITabBarItem *item = [self.tabBar.items objectAtIndex:index];
    
    [item setImage:[[UIImage imageNamed:[imageName stringByAppendingString:@"_normal"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [item setSelectedImage:[[UIImage imageNamed:[imageName stringByAppendingString:@"_highlight"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}



#pragma mark ========== 设置tabBar滑动==========
- (UIPanGestureRecognizer *)panGestureRecognizer{
    if (_panGestureRecognizer == nil){
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
    }
    return _panGestureRecognizer;
}

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)pan{
    if (self.transitionCoordinator) {
        return;
    }
    
    if (pan.state == UIGestureRecognizerStateBegan || pan.state == UIGestureRecognizerStateChanged){
        [self beginInteractiveTransitionIfPossible:pan];
    }
}

- (void)beginInteractiveTransitionIfPossible:(UIPanGestureRecognizer *)sender{
    CGPoint translation = [sender translationInView:self.view];
    if (translation.x > 0.f && self.selectedIndex > 0) {
        self.selectedIndex --;
    }
    else if (translation.x < 0.f && self.selectedIndex + 1 < self.viewControllers.count) {
        self.selectedIndex ++;
    }
    else {
        if (!CGPointEqualToPoint(translation, CGPointZero)) {
            sender.enabled = NO;
            sender.enabled = YES;
        }
    }
    
    [self.transitionCoordinator animateAlongsideTransitionInView:self.view animation:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        if ([context isCancelled] && sender.state == UIGestureRecognizerStateChanged){
            [self beginInteractiveTransitionIfPossible:sender];
        }
    }];
}

- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    // 打开注释 可以屏蔽点击item时的动画效果
    //    if (self.panGestureRecognizer.state == UIGestureRecognizerStateBegan || self.panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
    NSArray *viewControllers = tabBarController.viewControllers;
    if ([viewControllers indexOfObject:toVC] > [viewControllers indexOfObject:fromVC]) {
        return [[TransitionAnimation alloc] initWithTargetEdge:UIRectEdgeLeft];
    }
    else {
        return [[TransitionAnimation alloc] initWithTargetEdge:UIRectEdgeRight];
    }
    //    }
    //    else{
    //        return nil;
    //    }
}

- (id<UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    if (self.panGestureRecognizer.state == UIGestureRecognizerStateBegan || self.panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        return [[TransitionController alloc] initWithGestureRecognizer:self.panGestureRecognizer];
    }
    else {
        return nil;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
