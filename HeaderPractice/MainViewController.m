//
//  MainViewController.m
//  HeaderPractice
//
//  Created by WeiHan on 2021/8/26.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel *label = [UILabel new];

    label.frame = self.view.bounds;
    label.numberOfLines = 0;
    label.text = @"This project is aimed to test the header's best practices.";
    label.textAlignment = NSTextAlignmentCenter;

    [self.view addSubview:label];
}

@end
