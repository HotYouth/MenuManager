//
//  ViewController.m
//  SliderViewDemo
//
//  Created by 王忠诚 on 2017/9/27.
//  Copyright © 2017年 王忠诚. All rights reserved.
//

#import "ViewController.h"
#import "DC_MenuManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    DC_MenuManager *manager = [DC_MenuManager shareManager];
    manager.tabBar = self.tabBarController;
    [manager setUpBarButton:self];
    [manager setUpTable];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
