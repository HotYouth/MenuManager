//
//  DC_MenuManager.m
//  SliderViewDemo
//
//  Created by 王忠诚 on 2017/9/27.
//  Copyright © 2017年 王忠诚. All rights reserved.
//

#import "DC_MenuManager.h"

@interface DC_MenuManager ()<UITableViewDelegate,UITableViewDataSource>

/** controllers */
@property(nonatomic, strong) NSMutableArray *controllers;
/** menuTable */
@property(nonatomic, strong) UITableView *menuTable;
/** dismissView */
@property(nonatomic, strong) UIView *dismissView;
/** animating */
@property(nonatomic, assign) BOOL animating;
/** menuHidden */
@property(nonatomic, assign) BOOL menuHidden;
/** sections */
@property(nonatomic, strong) NSArray *sections;

@end

@implementation DC_MenuManager

+ (instancetype)shareManager {
    static DC_MenuManager *_manager = nil;
    static dispatch_once_t onceTask;
    dispatch_once(&onceTask, ^{
        _manager = [[DC_MenuManager alloc]init];
    });
    return _manager;
}

- (NSMutableArray *)controllers {
    if (_controllers) {
        return _controllers;
    }
    _controllers = [NSMutableArray arrayWithCapacity:0];
    return _controllers;
}

- (NSArray *)sections {
    if (_sections) {
        return _sections;
    }
    return @[@"1",@"2",@"3",@"4",@"5",@"6"];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setUpBarButton:(UIViewController *)controller {
    controller.view.backgroundColor = [UIColor colorWithRed:(arc4random() % 255 / 255.0) green:(arc4random() % 255 / 255.0) blue:(arc4random() % 255 / 255.0) alpha:1];
    UINavigationController *nav = controller.navigationController;
    if (nav == nil) {
        return;
    }
    nav.navigationBar.tintColor = [UIColor clearColor];
    [nav.navigationBar setTitleVerticalPositionAdjustment:0 forBarMetrics:UIBarMetricsDefault];
    [nav.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    nav.navigationBar.shadowImage = [UIImage new];
    nav.navigationBar.translucent = YES;
    nav.navigationBar.clipsToBounds = NO;
    nav.navigationBar.barTintColor = [UIColor clearColor];
    nav.navigationBar.barStyle = UIBarStyleBlack;
    [self.controllers addObject:controller];
    
    UIBarButtonItem *leftBarItemMenu = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navMenuWhite"] style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonPressed:)];
    leftBarItemMenu.tintColor = [UIColor colorWithWhite:1 alpha:1];
    controller.navigationItem.leftBarButtonItem = leftBarItemMenu;
    
    UIImageView *titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"navLogoWhite"]];
    titleView.contentMode = UIViewContentModeCenter;
    controller.navigationItem.titleView = titleView;
    if ([controller isKindOfClass:[UITableViewController class]]) {
//        ((UITableViewController *)controller).contentInsetAdjustmentBehavior
    }
    
}

- (void)setUpTable {
    BOOL flag = self.menuTable == nil && [[[UIApplication sharedApplication] delegate] window] != nil;
    if (flag == NO) {
        return;
    }
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    CGFloat width = MIN(300.0, window.bounds.size.width * 0.6);
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, width, window.frame.size.height)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.scrollEnabled = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *sideSeparator = [[UIView alloc]initWithFrame:CGRectMake(tableView.frame.size.width - 0.5, 0, 0.5, tableView.frame.size.height)];
    CGFloat grey = 209.0 / 255.0;
    sideSeparator.backgroundColor = [UIColor colorWithRed:grey green:grey blue:grey alpha:1.0];
    [tableView addSubview:sideSeparator];
    [window addSubview:tableView];
    self.menuTable = tableView;
    
    UIView *dismiss = [[UIView alloc]initWithFrame:CGRectMake(width, 0, window.frame.size.width - width, window.frame.size.height)];
    dismiss.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismisTap:)];
    [dismiss addGestureRecognizer:tap];
    [window addSubview:dismiss];
    self.dismissView = dismiss;
    [self hiddenMenuWithAnimetion:NO];
}

- (void)showMenuWithAnimetion:(BOOL)animated {
    UITableView *menu = self.menuTable;
    if (menu == nil) {
        NSLog(@"menuTable 不存在");
        return;
    }
    UIView *mainView = [[[UIApplication sharedApplication] delegate] window].rootViewController.view;
    if (mainView == nil) {
        NSLog(@"mainView 不存在");
        return;
    }
    if (animated == YES && self.animating == YES) {
        NSLog(@"动画正在进行中");
        return;
    }
    for (UIViewController *controller in self.controllers) {
        controller.navigationItem.leftBarButtonItem = nil;
    }
    self.menuHidden = NO;
    [menu reloadData];
    
    if (animated == YES) {
        self.animating = YES;
        [UIView animateWithDuration:0.5 animations:^{
            CGRect currentFrame = menu.frame;
            currentFrame.origin.x = 0;
            menu.frame = currentFrame;
            currentFrame = mainView.frame;
            currentFrame.origin.x = MIN(300, currentFrame.size.width * 0.6);
            mainView.frame = currentFrame;
        } completion:^(BOOL finished) {
            if (finished == YES) {
                self.menuHidden = NO;
                self.animating = NO;
                self.dismissView.userInteractionEnabled = YES;
            }
        }];
    }else {
        CGRect currentFrame = menu.frame;
        currentFrame.origin.x = 0;
        menu.frame = currentFrame;
        currentFrame = mainView.frame;
        currentFrame.origin.x = MIN(300, currentFrame.size.width * 0.6);
        mainView.frame = currentFrame;
        self.dismissView.userInteractionEnabled = YES;
    }
}

- (void)hiddenMenuWithAnimetion:(BOOL)animated {
    UITableView *menu = self.menuTable;
    if (menu == nil) {
        NSLog(@"menuTable 不存在");
        return;
    }
    UIView *mainView = [[[UIApplication sharedApplication] delegate] window].rootViewController.view;
    if (mainView == nil) {
        NSLog(@"mainView 不存在");
        return;
    }
    if (animated == YES && self.animating == YES) {
        NSLog(@"动画正在进行中");
        return;
    }
    for (UIViewController *controller in self.controllers) {
        UIBarButtonItem *leftBarItemMenu = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navMenuWhite"] style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonPressed:)];
        leftBarItemMenu.tintColor = [UIColor colorWithWhite:1 alpha:1];
        controller.navigationItem.leftBarButtonItem = leftBarItemMenu;
    }
    self.menuHidden = YES;
    self.dismissView.userInteractionEnabled = NO;
    if (animated == YES) {
        self.animating = YES;
        [UIView animateWithDuration:0.5 animations:^{
            CGRect currentFrame = menu.frame;
            currentFrame.origin.x = -currentFrame.size.width;
            menu.frame = currentFrame;
            currentFrame = mainView.frame;
            currentFrame.origin.x = 0;
            mainView.frame = currentFrame;
        } completion:^(BOOL finished) {
            if (finished == YES) {
                self.menuHidden = YES;
                self.animating = NO;
            }
        }];
    }else {
        CGRect currentFrame = menu.frame;
        currentFrame.origin.x = -currentFrame.size.width;
        menu.frame = currentFrame;
        currentFrame = mainView.frame;
        currentFrame.origin.x = 0;
        mainView.frame = currentFrame;
    }
}


#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sections.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }else {
        for (UIView *subView in cell.subviews) {
            if (subView.tag == 99) {
                [subView removeFromSuperview];
            }
        }
    }
    cell.textLabel.text = self.sections[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor colorWithRed:95.0 / 255.0 green:102.0 / 255.0 blue:102.0 / 255.0 alpha:1.0];
    
    UIView *seperator = [[UIView alloc]initWithFrame:CGRectMake(0, cell.frame.size.height - 0.5, cell.frame.size.width, 0.5)];
    CGFloat grey = 209.0 / 255.0;
    seperator.backgroundColor = [UIColor colorWithRed:grey green:grey blue:grey alpha:1];
    seperator.tag = 99;
    [cell addSubview:seperator];
    cell.clipsToBounds = YES;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat statusHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    if (statusHeight > 20) {
        return 90 + statusHeight;
    }else {
        return 90.0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGFloat statusHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat h = 90;
    CGFloat spacing = 0;
    if (statusHeight > 20) {
        h = statusHeight + 90;
        spacing = 20;
    }
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, h)];
    view.backgroundColor = [UIColor clearColor];
    
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menuLogo"]];
    logo.backgroundColor = [UIColor clearColor];
    logo.frame = CGRectMake(15, spacing + (view.frame.size.height - spacing - logo.intrinsicContentSize.height) / 2.0, logo.intrinsicContentSize.width, logo.intrinsicContentSize.height);
    [view addSubview:logo];
    
    UIButton *closeMenuButton = [[UIButton alloc]initWithFrame:CGRectMake(0, logo.frame.origin.y, 50, logo.frame.size.height + 10)];
    [closeMenuButton addTarget:self action:@selector(closeMenu) forControlEvents:UIControlEventTouchUpInside];
    closeMenuButton.backgroundColor = [UIColor clearColor];
    [view addSubview:closeMenuButton];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.sections.count) {
        self.tabBar.selectedIndex = indexPath.row;
        [self hiddenMenuWithAnimetion:YES];
    }
}

#pragma mark - action
- (void)menuButtonPressed:(UIBarButtonItem *)barButton {
    [self showMenuWithAnimetion:YES];
}

- (void)dismisTap:(UITapGestureRecognizer *)tap {
    [self hiddenMenuWithAnimetion:YES];
}

- (void)closeMenu {
    [self hiddenMenuWithAnimetion:YES];
}

@end
