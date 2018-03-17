//
//  DC_TabBarController.m
//  SliderViewDemo
//
//  Created by 王忠诚 on 2017/9/28.
//  Copyright © 2017年 王忠诚. All rights reserved.
//

#import "DC_TabBarController.h"
#import "DC_MenuViewController.h"
#import "ViewController.h"
#import "FirstViewController.h"
@interface DC_TabBarController ()

@end

@implementation DC_TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildViewcontroller];
    self.tabBar.hidden = YES;
}

- (void)addChildViewcontroller {
    for (int i = 0 ; i < 7; i ++) {
        FirstViewController *vc = [[FirstViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        [self addChildViewController:nav];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
