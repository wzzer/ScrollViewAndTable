//
//  WZZOneController.h
//  WzzScrollAndTable
//
//  Created by wzz on 16/7/11.
//  Copyright © 2016年 wzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WZZOneControllerDelegate <NSObject>

- (void)wzzOneTableViewAndScroll:(CGFloat)scrollY;

@end


@interface WZZOneController : UITableViewController

@property (nonatomic , weak) id<WZZOneControllerDelegate>  delegate;

@end
