//
//  TabBarViewController.m
//  ToDoList
//
//  Created by moutaz hegazy on 3/4/21.
//  Copyright © 2021 Mohmaed_Elkholy. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    [viewController.navigationController popToRootViewControllerAnimated:YES];
}

@end
