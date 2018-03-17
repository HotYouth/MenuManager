//
//  DC_MenuManager.h
//  SliderViewDemo
//
//  Created by 王忠诚 on 2017/9/27.
//  Copyright © 2017年 王忠诚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DC_MenuManager : NSObject

/** tabbar */
@property(nonatomic, strong) UITabBarController *tabBar;

+ (instancetype)shareManager;

- (void)setUpBarButton:(UIViewController *)controller;

- (void)setUpTable;

@end
