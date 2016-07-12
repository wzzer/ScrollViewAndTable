//
//  WZZTwoController.h
//  WzzScrollAndTable
//
//  Created by wzz on 16/7/11.
//  Copyright © 2016年 wzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WZZTwoControllerDelegate <NSObject>

- (void)wzzTwoTableViewAndScroll:(CGFloat)scrollY;

@end

@interface WZZTwoController : UITableViewController

@property (nonatomic , weak) id<WZZTwoControllerDelegate> delegate;

@end
