//
//  DC_MenuViewController.m
//  SliderViewDemo
//
//  Created by 王忠诚 on 2017/9/27.
//  Copyright © 2017年 王忠诚. All rights reserved.
//

#import "DC_MenuViewController.h"
#import "DC_MenuManager.h"
#import "DC_TabBarController.h"
@interface DC_MenuViewController ()

@end

@implementation DC_MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DC_MenuManager *manager = [DC_MenuManager shareManager];
//    DC_TabBarController *tabbarController = [[DC_TabBarController alloc] init];
    manager.tabBar = self.tabBarController;
    [manager setUpBarButton:self];
    [manager setUpTable];
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
