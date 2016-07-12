//
//  WZZThreeController.h
//  WzzScrollAndTable
//
//  Created by wzz on 16/7/11.
//  Copyright © 2016年 wzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WZZThreeControllerDelegate <NSObject>

- (void)wzzThreeTableViewAndScroll:(CGFloat)scrollY;

@end
@interface WZZThreeController : UITableViewController

@property (nonatomic , weak) id<WZZThreeControllerDelegate> delegate;
@end
