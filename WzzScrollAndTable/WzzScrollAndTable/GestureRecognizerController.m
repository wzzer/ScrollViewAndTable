//
//  GestureRecognizerController.m
//  WzzScrollAndTable
//
//  Created by wzz on 16/7/11.
//  Copyright © 2016年 wzz. All rights reserved.
//

#import "GestureRecognizerController.h"

@implementation GestureRecognizerController

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{

    if (gestureRecognizer.state != 0) {
        return YES;
    }else{
        return NO;
    }
}
@end
