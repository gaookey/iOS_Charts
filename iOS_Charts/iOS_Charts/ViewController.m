//
//  ViewController.m
//  iOS_Charts
//
//  Created by gwl on 2019/12/31.
//  Copyright © 2019 gwl. All rights reserved.
//

#import "ViewController.h"

#import "GWLCombinedChartViewController.h"
#import "GWLBubbleChartViewController.h"
#import "GWLPieChartViewController.h"
#import "GWLRadarChartViewController.h"
#import "GWLCandleStickChartViewController.h"
#import "GWLScatterChartViewController.h"
#import "GWLBarChartViewController.h"
#import "GWLLineChartViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Charts";
}

- (IBAction)pushCombinedChartView {
    [self.navigationController pushViewController:[[GWLCombinedChartViewController alloc] init] animated:YES];
}
- (IBAction)pushBubbleChartView {
    [self.navigationController pushViewController:[[GWLBubbleChartViewController alloc] init] animated:YES];
}
- (IBAction)pushPieChartView {
    [self.navigationController pushViewController:[[GWLPieChartViewController alloc] init] animated:YES];
}
- (IBAction)pushRadarChartView {
    [self.navigationController pushViewController:[[GWLRadarChartViewController alloc] init] animated:YES];
}
- (IBAction)pushCandleStickChartView {
    [self.navigationController pushViewController:[[GWLCandleStickChartViewController alloc] init] animated:YES];
}
- (IBAction)pushScatterChartView {
    [self.navigationController pushViewController:[[GWLScatterChartViewController alloc] init] animated:YES];
}
- (IBAction)pushBarChartView {
    [self.navigationController pushViewController:[[GWLBarChartViewController alloc] init] animated:YES];
}
- (IBAction)pushLineChartView {
    [self.navigationController pushViewController:[[GWLLineChartViewController alloc] init] animated:YES];
}

@end
