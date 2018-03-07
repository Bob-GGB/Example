//
//  KLHomeViewControllers.m
//  kaile
//
//  Created by Monkey on 2018/3/1.
//  Copyright © 2018年 Monkey. All rights reserved.
//

#import "KLHomeViewControllers.h"

@interface KLHomeViewControllers ()

@end

@implementation KLHomeViewControllers

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 下拉刷新、上提更多 **/
    __weak typeof(self) weakSelf = self;
    self.DropDownRefreshBlock = ^{
        [weakSelf loadNewData];
    };
    
    self.UpDropRefreshBlock = ^{
        [weakSelf loadOldData];
    };
}

#pragma mark ----------------- 加载新数据
- (void)loadNewData{
    
    self.footer.hidden = NO;
    
    // 获取数据
    //[self getDataWithUrlString:Activities_ActivitiesList andParameters:@{@"page" : @(_page)}];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self endNewLoad];
    });
}

#pragma mark ----------------- 获取老数据

- (void)loadOldData{
    
   // [self getDataWithUrlString:Activities_ActivitiesList andParameters:@{@"page" : @(_page)}];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self endOldLoad];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *reuseID = @"Home_reuseID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseID];
    }

    return cell;
}

@end
