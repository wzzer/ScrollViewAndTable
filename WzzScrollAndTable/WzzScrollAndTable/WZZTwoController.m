//
//  WZZTwoController.m
//  WzzScrollAndTable
//
//  Created by wzz on 16/7/11.
//  Copyright © 2016年 wzz. All rights reserved.
//

#import "WZZTwoController.h"

@implementation WZZTwoController

static CGFloat const offSizeY = 200;
static NSString *const identifier = @"twoCell";

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
    cell.imageView.image = [UIImage imageNamed:@"kylin_Apple"];
    cell.textLabel.text = @"kylin";
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([self.delegate respondsToSelector:@selector(wzzTwoTableViewAndScroll:)]) {
        [self.delegate wzzTwoTableViewAndScroll:scrollView.contentOffset.y];
    }
    
}

@end
