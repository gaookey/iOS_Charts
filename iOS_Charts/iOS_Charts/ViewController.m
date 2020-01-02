//
//  ViewController.m
//  iOS_Charts
//
//  Created by gwl on 2019/12/31.
//  Copyright © 2019 gwl. All rights reserved.
//

#import "ViewController.h"
#import "GWLBarChartView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBarChartView];
}
#pragma mark - 圆柱
- (void)setupBarChartView {
    GWLBarChartView *barChartView = [[GWLBarChartView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) datas:@[@"11",@"42",@"23",@"42",@"15",@"46.000",@"30",@"8",@"39",@"19",@"31",@"12"] titles:@[@"12",@"2",@"3",@"4",@"5",@"6.000",@"7",@"8",@"9",@"10",@"11",@"12"] ];
    //      GWLBarChartView *barChartView = [[GWLBarChartView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) datas:@[@"11",@"42"] titles:@[@"12",@"2"] ];
    
    //        GWLBarChartView *barChartView = [[GWLBarChartView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) multiLayerData:@[@[@"12", @"32", @"23"], @[@"32",@"12",  @"23"]] colors:@[[UIColor orangeColor], [UIColor grayColor], [UIColor cyanColor]] stackLabels:@[@"2", @"5", @"8"] titles:@[@"4", @"6"]];
    //    GWLBarChartView *barChartView = [[GWLBarChartView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) multiLayerData:@[@[@"12", @"32", @"23"], @[@"32",@"12",  @"23"], @[@"12", @"23",@"32"],@[@"12", @"32", @"23"],@[@"12", @"32", @"23"], @[@"32",@"12",  @"23"], @[@"12", @"23",@"32"],@[@"12", @"32", @"23"],@[@"12", @"32", @"23"], @[@"32",@"12",  @"23"], @[@"12", @"23",@"32"],@[@"12", @"32", @"23"]] colors:@[[UIColor orangeColor], [UIColor grayColor], [UIColor cyanColor]] stackLabels:@[@"2", @"5", @"8"] titles:@[@"4", @"6", @"7",@"4",@"4", @"6", @"7",@"4",@"4", @"6", @"7",@"4"]];
    
    [self.view addSubview:barChartView];
    barChartView.chartValueSelected = ^(NSInteger index) {
        NSLog(@"%s 第%d行 \n %ld\n\n",__func__,__LINE__, (long)index);
    };
}

@end
