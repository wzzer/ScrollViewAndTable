//
//  WZZFourController.h
//  WzzScrollAndTable
//
//  Created by wzz on 16/7/11.
//  Copyright © 2016年 wzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WZZFourControllerDelegate <NSObject>

- (void)wzzFourTableViewAndScroll:(CGFloat)scrollY;

@end
@interface WZZFourController : UITableViewController

@property (nonatomic , weak) id<WZZFourControllerDelegate> delegate;

@end
