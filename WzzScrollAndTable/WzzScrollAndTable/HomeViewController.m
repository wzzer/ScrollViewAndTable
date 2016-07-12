//
//  HomeViewController.m
//  WzzScrollAndTable
//
//  Created by wzz on 16/7/11.
//  Copyright © 2016年 wzz. All rights reserved.
//

#import "HomeViewController.h"
#import "GestureRecognizerController.h"
#import "WZZFourController.h"
#import "WZZThreeController.h"
#import "WZZTwoController.h"
#import "WZZOneController.h"
#import "UIView+WzzSize.h"
#import <Masonry/Masonry.h>


@interface HomeViewController ()<UIScrollViewDelegate,WZZFourControllerDelegate,WZZOneControllerDelegate,WZZThreeControllerDelegate,WZZTwoControllerDelegate>

/**标题数组*/
@property(nonatomic,strong)NSArray *dataArray;

/**头部视图*/
@property(nonatomic,weak)UIView *headerView;

/**头部tupian视图*/
@property(nonatomic,weak)UIImageView *imgview;

/**标题view*/
@property(nonatomic,weak)UIScrollView *titleView;

/**内容的view*/
@property(nonatomic,weak)GestureRecognizerController *contentView;

/**选中的按钮*/
@property(nonatomic,strong)UIButton *currentSelectedBtn;
/**下划线*/
@property(nonatomic,weak)UIView *selectedUnderLine;

@property (nonatomic , weak) WZZFourController * fourConVc;
@property (nonatomic , weak) WZZThreeController * threeConVc;
@property (nonatomic , weak) WZZTwoController * twoConVc;
@property (nonatomic , weak) WZZOneController * oneConVc;

@end

//屏幕宽度
#define kScreenW [UIScreen mainScreen].bounds.size.width

//屏幕高度
#define kScreenH [UIScreen mainScreen].bounds.size.height

static CGFloat const NavH = 64;
static CGFloat const HeaderH = 150;
static CGFloat const TitleViewH = 50;
static CGFloat const UnderLineH = 3;
static CGFloat const OffsetY = -200;

@implementation HomeViewController

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@"科技",@"热点",@"娱乐",@"体育"];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"Demo";
    
    // 添加子控制器
    [self setupChildViewController];
    // 布局子控制排列样式
    [self setupChildViews];
    
    // 添加标题栏内容
    [self setupTitleView];
    
    [self addChildViewInContentView:0];
    
    // 添加标题栏下划线
    [self setupUnderLine];
}


- (void)setupChildViews{
    // 头部视图
    UIView *headerView = [[UIView alloc]init];
    _headerView = headerView;
    UIImageView *imageView = [[UIImageView alloc]init];
    _imgview = imageView;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = [UIImage imageNamed:@"hyy.jpg"];
    headerView.clipsToBounds = YES;
    [headerView addSubview:imageView];
    
    // 标题栏
    UIScrollView *titleView =[[UIScrollView alloc]init];
    _titleView = titleView;
    
    // 内容的view
    GestureRecognizerController *contentView = [[GestureRecognizerController alloc]init];
    _contentView = contentView;
    contentView.pagingEnabled = YES;
    contentView.bounces = NO;
    contentView.delegate = self;
    contentView.contentSize = CGSizeMake(self.dataArray.count * kScreenW , 0);
    
    [self.view addSubview:contentView];
    [self.view addSubview:titleView];
    [self.view addSubview:headerView];
    
}

- (void)setupChildViewController{
    WZZOneController *oneVc = [[WZZOneController alloc]init];
    _oneConVc = oneVc;
    oneVc.delegate = self;
    [self addChildViewController:oneVc];
    
    WZZTwoController *twoVc = [[WZZTwoController alloc]init];
    _twoConVc = twoVc;
    twoVc.delegate = self;
    [self addChildViewController:twoVc];
    
    WZZThreeController *threeVc = [[WZZThreeController alloc]init];
    _threeConVc = threeVc;
    threeVc.delegate = self;
    [self addChildViewController:threeVc];
    
    WZZFourController *fourVc = [[WZZFourController alloc]init];
    _fourConVc = fourVc;
    fourVc.delegate = self;
    [self addChildViewController:fourVc];
    
}

- (void)setupTitleView{
    NSInteger count = self.dataArray.count;
    for (NSInteger i = 0; i < count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitle:_dataArray[i] forState:UIControlStateNormal];
        [btn setTitle:_dataArray[i] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor colorWithRed:83/255.0 green:211/255.0 blue:254/255.0 alpha:1.0] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat btnW = kScreenW / _dataArray.count;
        CGFloat btnH = TitleViewH;
        CGFloat btnX = i * btnW;
        CGFloat btnY = 0;
        btn.tag = i;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH - UnderLineH);
        
        [self.titleView addSubview:btn];
        
        if (i == 0) {
            [self titleBtnClick:btn];
        }
    }
    
}
- (void)setupUnderLine{
    
    UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    selectButton = self.titleView.subviews.firstObject;
    UIView *underline = [[UIView alloc] init];
    CGFloat underlineH = 3;
    CGFloat underlineW =  kScreenW / [self dataArray].count;
    CGFloat underlineX = 0;
    CGFloat underlineY = TitleViewH - UnderLineH;
    underline.frame = CGRectMake(underlineX, underlineY, underlineW, underlineH);
    //设置下划线的颜色,根随按钮选中的颜色一致
    underline.backgroundColor = [selectButton titleColorForState:UIControlStateSelected];
    [self.titleView addSubview:underline];
    self.selectedUnderLine = underline;
    
    [selectButton.titleLabel sizeToFit];
    selectButton.selected = YES;
    self.currentSelectedBtn = selectButton;
    
    self.selectedUnderLine.KWidth = selectButton.titleLabel.KWidth + 10;
    self.selectedUnderLine.KCenterX = selectButton.KCenterX;
    
}


#pragma mark- 点击事件
- (void)titleBtnClick:(UIButton *)button{
    
    self.currentSelectedBtn.selected = NO;
    button.selected = YES;
    self.currentSelectedBtn = button;
    
    NSInteger index = button.tag;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.selectedUnderLine.KWidth = button.titleLabel.KWidth + 10;
        self.selectedUnderLine.KCenterX = button.KCenterX;
    }completion:nil];
    
    self.contentView.contentOffset = CGPointMake(index * kScreenW, 0);
    
    [self addChildViewInContentView:index];
    
    _oneConVc.tableView.scrollEnabled = YES;
    _twoConVc.tableView.scrollEnabled = YES;
    _threeConVc.tableView.scrollEnabled = YES;
    _fourConVc.tableView.scrollEnabled = YES;
    
}

// 添加相应的控制器的view到内容视图中
- (void)addChildViewInContentView:(NSInteger)index{
    
    UIViewController *childView = self.childViewControllers[index];
    [self.contentView addSubview:childView.view];
    childView.view.frame = CGRectMake(index * kScreenW, OffsetY, kScreenW, kScreenH + 85);
}

//布局
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NavH);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(HeaderH));
    }];
    
    
    [_imgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_headerView);
    }];
    
    
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(TitleViewH));
    }];
    
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleView.mas_bottom);
        make.width.equalTo(@(kScreenW));
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(kScreenH - NavH));
    }];
    
    
}

- (void)wzzOneTableViewAndScroll:(CGFloat)scrollY{
     [self wzzScrollToChangeHeaderViewHeight:scrollY];
}
- (void)wzzTwoTableViewAndScroll:(CGFloat)scrollY{
     [self wzzScrollToChangeHeaderViewHeight:scrollY];
}
- (void)wzzThreeTableViewAndScroll:(CGFloat)scrollY{
     [self wzzScrollToChangeHeaderViewHeight:scrollY];
}
- (void)wzzFourTableViewAndScroll:(CGFloat)scrollY{
     [self wzzScrollToChangeHeaderViewHeight:scrollY];
}

// 动态计算滚动的Y值
- (void)wzzScrollToChangeHeaderViewHeight:(CGFloat)scrollY{
    
//    CGFloat offsetY = scrollY - OffsetY;
//
//    CGFloat height = HeaderH - offsetY;
//    
//    if (height > HeaderH) {
//        height = HeaderH;
//    }
//    
//    if (height < 0) {
//        height = 0;
//    }
    
    [self.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NavH);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(HeaderH));
    }];
    
    [self.titleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(TitleViewH));
    }];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == self.contentView) {
        _oneConVc.tableView.scrollEnabled = NO;
        _twoConVc.tableView.scrollEnabled = NO;
        _threeConVc.tableView.scrollEnabled = NO;
        _fourConVc.tableView.scrollEnabled = NO;
        
    }

}

// 滚动切换控制器
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    if (scrollView == self.contentView) {
        _oneConVc.tableView.scrollEnabled = YES;
        _twoConVc.tableView.scrollEnabled = YES;
        _threeConVc.tableView.scrollEnabled = YES;
        _fourConVc.tableView.scrollEnabled = YES;
        
    }
    NSInteger index = scrollView.contentOffset.x / kScreenW;
    
    NSMutableArray *buttonArray = [NSMutableArray array];
    
    for (NSInteger i = 0; i < self.titleView.subviews.count; i ++) {
        UIView *button = self.titleView.subviews[i];
        
        if (button.class == [UIButton buttonWithType:UIButtonTypeCustom].class) {
            [buttonArray addObject:button];
        }
    }
    
    UIButton *button = buttonArray[index];
    
    [self titleBtnClick:button];
}

@end
