//
//  GWLLineChartViewController.m
//  iOS_Charts
//
//  Created by gwl on 2020/1/8.
//  Copyright © 2020 gwl. All rights reserved.
//

#import "GWLLineChartViewController.h"

@interface GWLLineChartViewController () <IChartAxisValueFormatter, ChartViewDelegate>

@property (strong, nonatomic) LineChartView *lineChartView;
@property (strong, nonatomic) NSArray *datas;

@end

@implementation GWLLineChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"LineChartView";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.datas = @[@"23", @"13", @"53", @"63", @"35", @"39", @"70", @"23", @"13", @"53", @"63", @"35", @"39", @"70"];
    
    [self setupLineChartView];
}
#pragma mark - LineChartView
-(void)setupLineChartView {
    [self.view addSubview:self.lineChartView];
    
    [self drawData];
}
- (void)drawData {
    NSMutableArray *values = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.datas.count; i++) {
        NSString * aaa = self.datas[i];
        double bb = aaa.doubleValue;
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:bb];
        [values addObject:entry];
    }
    
    LineChartDataSet *dataSet = [[LineChartDataSet alloc] initWithEntries:values label:@"图例"];
    
    LineChartData *data = [[LineChartData alloc] initWithDataSet:dataSet];
    
    self.lineChartView.data = data;
}

#pragma mark - lazy
- (LineChartView *)lineChartView {
    if (!_lineChartView) {
        _lineChartView = [[LineChartView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT - TABBAR_BOTTOM_HEIGHT)];
        _lineChartView.delegate = self;
    }
    return _lineChartView;
}

@end
