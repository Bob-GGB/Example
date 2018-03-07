//
//  KLHomeVC.m
//  kaile
//
//  Created by Monkey on 2018/3/3.
//  Copyright © 2018年 Monkey. All rights reserved.
//

#import "KLHomeVC.h"
#import "KLHomeView.h"

@interface KLHomeVC ()

@end

@implementation KLHomeVC

- (void)loadView{
    [super loadView];
    
    self.view = [[KLHomeView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
