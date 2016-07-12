//
//  WZZFourController.m
//  WzzScrollAndTable
//
//  Created by wzz on 16/7/11.
//  Copyright © 2016年 wzz. All rights reserved.
//

#import "WZZFourController.h"

@implementation WZZFourController

static CGFloat const offSizeY = 200;
static NSString *const identifier = @"threeCell";

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI{
    // 修改tableView的样式
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    tableView.rowHeight = 100;
    self.tableView = tableView;
    self.tableView.contentInset = UIEdgeInsetsMake(offSizeY - 25, 0, -35, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
}

//实现代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.imageView.image = [UIImage imageNamed:@"kylin_placeHolder"];
    cell.textLabel.text = @"placeHolder";
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([self.delegate respondsToSelector:@selector(wzzFourTableViewAndScroll:)]) {
        [self.delegate wzzFourTableViewAndScroll:scrollView.contentOffset.y];
    }
    
}

@end
