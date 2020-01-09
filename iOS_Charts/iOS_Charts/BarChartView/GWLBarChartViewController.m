//
//  GWLBarChartViewController.m
//  iOS_Charts
//
//  Created by gwl on 2020/1/8.
//  Copyright © 2020 gwl. All rights reserved.
//

#import "GWLBarChartViewController.h"


@interface GWLBarChartViewController () <IChartAxisValueFormatter, ChartViewDelegate>

@property (strong, nonatomic) BarChartView *barChartView;

/// 单层圆柱 x轴标题
@property (strong, nonatomic) NSArray <NSString *>*titles;
/// 单层圆柱 数据
@property (strong, nonatomic) NSArray <NSString *>*datas;

/// 是否是多层
@property (assign, nonatomic) BOOL isMultiLayer;
/// 多层圆柱 数据
@property (strong, nonatomic) NSArray <NSArray <NSString *>*>*multiLayerData;
/// 多层圆柱 单个圆柱各层颜色数组
@property (strong, nonatomic) NSArray <UIColor *>*colors;
/// 多层圆柱 图例文字数组
@property (strong, nonatomic) NSArray <NSString *>*stackLabels;

/// 页面显示圆柱个数
@property (assign, nonatomic) NSInteger visibleXRangeMaximum;

@end

@implementation GWLBarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"BarChartView";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.visibleXRangeMaximum = 6;
    
    [self loadData];
    //    [self loadMultiLayerData];
    [self setupBarChartView];
}
//单层数据
- (void)loadData {
    self.titles = @[@"12",@"2",@"3",@"4",@"5",@"6.000",@"7",@"8",@"9",@"10",@"11",@"12"];
    self.datas = @[@"11",@"42",@"23",@"42",@"15",@"46.000",@"30",@"8",@"39",@"19",@"31",@"12"];
    
    //    self.titles = @[@"12",@"2"];
    //    self.datas = @[@"11",@"42"];
}
//多层数据
- (void)loadMultiLayerData {
    self.isMultiLayer = YES;
    
    //    self.titles = @[@"4", @"6"];
    //    self.multiLayerData = @[@[@"12", @"32", @"23"], @[@"32",@"12",  @"23"]];
    //    self.stackLabels = @[@"2", @"5", @"8"];
    //    self.colors = @[[UIColor orangeColor], [UIColor grayColor], [UIColor cyanColor]];
    
    self.titles = @[@"4", @"6", @"7",@"4",@"4", @"6", @"7",@"4",@"4", @"6", @"7",@"4"];
    self.multiLayerData = @[@[@"12", @"32", @"23"], @[@"32",@"12",  @"23"], @[@"12", @"23",@"32"],@[@"12", @"32", @"23"],@[@"12", @"32", @"23"], @[@"32",@"12",  @"23"], @[@"12", @"23",@"32"],@[@"12", @"32", @"23"],@[@"12", @"32", @"23"], @[@"32",@"12",  @"23"], @[@"12", @"23",@"32"],@[@"12", @"32", @"23"]];
    self.stackLabels = @[@"2", @"5", @"8"];
    self.colors = @[[UIColor orangeColor], [UIColor grayColor], [UIColor cyanColor]];
}
#pragma mark - BarChartView
-(void)setupBarChartView {
    //默认垂直显示，水平柱状图使用 HorizontalBarChartView
    BarChartView *barChartView = [[BarChartView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT - TABBAR_BOTTOM_HEIGHT)];
    barChartView.delegate = self;
    barChartView.xAxis.valueFormatter = self;
    [self.view addSubview:barChartView];
    self.barChartView = barChartView;
    
#pragma mark - 配置
    //x轴动画
    [self.barChartView animateWithYAxisDuration:1.0f];
    //y轴动画
    [self.barChartView animateWithXAxisDuration:1.0f];
    //柱状条后面画一个灰色区域，表示最大值。默认NO
    self.barChartView.drawBarShadowEnabled = NO;
    //显示顶部文字，默认YES
    self.barChartView.drawValueAboveBarEnabled = YES;
    //NO时，则柱状图下方不裁剪突出显示，默认YES
    self.barChartView.clipDataToContentEnabled = YES;
    //空表时显示的文字
    self.barChartView.noDataText = @"暂无数据";
    //空表时显示的文字大小，默认12
    self.barChartView.noDataFont = [UIFont systemFontOfSize:12];
    //空表时显示的文字颜色，默认black
    self.barChartView.noDataTextColor = [UIColor blackColor];
    //空表时显示的文字位置，默认left
    self.barChartView.noDataTextAlignment = NSTextAlignmentLeft;
    
    //是否有图例，默认YES
    self.barChartView.legend.enabled = YES;
    if (self.barChartView.legend.isEnabled) {
        //图例图形大小，默认8
        self.barChartView.legend.formSize = 8.0;
        //图例文字大小，默认10
        self.barChartView.legend.font = [UIFont systemFontOfSize:10];
        //图例文字颜色，默认black
        self.barChartView.legend.textColor = [UIColor blackColor];
        //图例位置默认left
        self.barChartView.legend.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
        //默认Horizontal
        self.barChartView.legend.orientation = ChartLegendOrientationHorizontal;
    }
    
#pragma mark - 图表交互
    //多点触控，默认NO
    self.barChartView.multipleTouchEnabled = NO;
    //平移拖动，默认YES
    self.barChartView.dragEnabled = YES;
    //x轴缩放，默认YES
    self.barChartView.scaleXEnabled = YES;
    //y轴缩放 默认YES
    self.barChartView.scaleYEnabled = YES;
    //触控放大，默认NO
    self.barChartView.pinchZoomEnabled = NO;
    //双击放大图表，默认YES
    self.barChartView.doubleTapToZoomEnabled = YES;
    //拖动后图表是否继续滚动，默认YES。
    self.barChartView.dragDecelerationEnabled = YES;
    //减速摩擦系数，间隔0-1，如果将其设置为0，它将立即停止，1是无效值，并将自动转换为0.9999。默认0.9
    self.barChartView.dragDecelerationFrictionCoef = 0.9;
    //在圆柱左右两端各增加一半的条宽，默认NO
    self.barChartView.fitBars = NO;
    
#pragma mark - 高亮显示
    //默认值YES
    self.barChartView.highlightPerDragEnabled = YES;
    //默认值YES
    self.barChartView.highlightPerTapEnabled = YES;
    //默认值500
    self.barChartView.maxHighlightDistance = 500;
    
#pragma mark - Axis x轴
    ChartXAxis *xAxis = self.barChartView.xAxis;
    //是否启用x轴，默认YES。
    xAxis.enabled = YES;
    //是否绘制x轴的标签。默认YES
    xAxis.drawLabelsEnabled = YES;
    //如果是否绘制沿轴的线（轴线），默认YES
    xAxis.drawAxisLineEnabled = YES;
    //网格线，默认YES
    xAxis.drawGridLinesEnabled = YES;
    //设置自定义最大值，如果设置则根据提供的数据将不会自动计算该值。
    //xAxis.axisMaximum = 5;
    //撤销axisMaximum设置的最大值
    //[xAxis resetCustomAxisMax];
    //设置为0时则柱状图从最左端开始显示
    //xAxis.axisMinimum = 0;
    //第一条数据距最左端距离，相当于偏移几个单位量。
    //xAxis.spaceMin = 1.5;
    //x轴显示数量，默认6。由setVisibleXRangeMaximum替代
    if (self.titles.count > self.visibleXRangeMaximum) {
        xAxis.labelCount = self.visibleXRangeMaximum;
    } else {
        xAxis.labelCount = self.titles.count;
    }
    //设置x轴标签显示，例如：设置3则每隔两个柱子显示一个标签。默认1
    //xAxis.granularity = 1;
    //x轴文字位置，默认top
    xAxis.labelPosition = XAxisLabelPositionBottom;
    //x轴标签文字大小，默认10
    xAxis.labelFont = [UIFont systemFontOfSize:10];
    //x轴标签文字颜色，默认black
    xAxis.labelTextColor = [UIColor blackColor];
    //x轴标签宽度
    //xAxis.labelWidth = 1;
    //标签文字倾斜，默认0
    xAxis.labelRotationAngle = 0.0;
    //轴的网格线的宽度
    xAxis.gridLineWidth = 0.5;
    //轴的网格线的颜色
    xAxis.gridColor = [UIColor grayColor];
    //轴的宽度
    xAxis.axisLineWidth = 0.5;
    //轴的颜色
    xAxis.axisLineColor = [UIColor grayColor];
    //设置轴的网格线的虚线效果，间距值
    xAxis.gridLineDashLengths = @[@5.0f, @10.0f, @5.0f];
    //默认YES
    //xAxis.gridAntialiasEnabled = YES;
    
#pragma mark - leftAxis y 轴，属性参考xAxis
    ChartYAxis *leftAxis = self.barChartView.leftAxis;
    leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:[[NSNumberFormatter alloc] init]];
    //y轴最大值
    //leftAxis.axisMaximum = 100;
    //y值最小值
    leftAxis.axisMinimum = 0;
    //默认OutsideChart
    //leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
    //最大值到顶部所占整个轴的百分比，默认0.1
    leftAxis.spaceTop = 0.1;
    //y轴网格线个数，默认6
    leftAxis.labelCount = 6;
    leftAxis.labelFont = [UIFont systemFontOfSize:10];
    leftAxis.labelTextColor = [UIColor blackColor];
    
#pragma mark - rightAxis y 轴，属性参考xAxis
    //隐藏右侧显示，默认YES
    self.barChartView.rightAxis.enabled = NO;
    
    if (self.isMultiLayer) {
        [self drawMultiLayerData];
    } else {
        [self drawData];
    }
}
#pragma mark - 单层
-(void)drawData {
    if (self.titles.count != self.datas.count) {
        return;
    }
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < self.datas.count; i++) {
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:i y:[self.datas[i] integerValue]];
        [array addObject:entry];
    }
    //set
    BarChartDataSet *set = [[BarChartDataSet alloc] initWithEntries:array];
    set.label = @"图例";
    //圆柱颜色
    [set setColor:[UIColor cyanColor]];
    NSNumberFormatter *setFormatter = [[NSNumberFormatter alloc] init];
    setFormatter.positiveSuffix = @"%";
    [set setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:setFormatter]];
    //单个高亮显示
    set.highlightEnabled = YES;
    //单个高亮显示颜色
    set.highlightColor = [UIColor orangeColor];
    //圆柱边宽
    //set.barBorderWidth = 2;
    //圆柱边色
    //set.barBorderColor = [UIColor cyanColor];
    //圆柱阴影色
    //set.barShadowColor = [UIColor orangeColor];
    //set.formLineWidth = 100;
    //圆柱上是否显示文字
    set.drawValuesEnabled = YES;
    
    BarChartData *data = [[BarChartData alloc] initWithDataSet:set];
    //显示柱状图顶部文字，默认YES
    [data setDrawValues:YES];
    //柱状图顶部文字大小
    [data setValueFont:[UIFont systemFontOfSize:10]];
    //圆柱和间距的比例，默认0.85
    [data setBarWidth:0.85];
    self.barChartView.data = data;
    
    //[self.barChartView notifyDataSetChanged];
    //[self.barChartView.data notifyDataChanged];
    if (self.titles.count > self.visibleXRangeMaximum) {
        [self.barChartView setVisibleXRangeMaximum:self.visibleXRangeMaximum];
    }
}
#pragma mark - 多层
- (void)drawMultiLayerData {
    if (self.titles.count != self.multiLayerData.count) {
        return;
    }
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < self.multiLayerData.count; i++) {
        int total = 0;
        NSArray *datas = self.multiLayerData[i];
        for (int i = 0; i < datas.count; i ++) {
            NSString *str = datas[i];
            total += [str intValue];
        }
        
        CGFloat num = 0;
        NSMutableArray *yValues = [NSMutableArray array];
        for (int i = 0; i < datas.count; i ++) {
            NSString *str = datas[i];
            num = [str intValue] * 100 / (CGFloat)total;
            [yValues addObject:[NSNumber numberWithFloat:num]];
        }
        [yVals addObject:[[BarChartDataEntry alloc] initWithX:i yValues:yValues]];
    }
    
    BarChartDataSet *set = [[BarChartDataSet alloc] initWithEntries:yVals];
    set.label = @"图例";
    set.drawIconsEnabled = YES;
    //圆柱上是否显示文字，默认YES
    set.drawValuesEnabled = YES;
    set.stackLabels = self.stackLabels;
    
    if (set.colors.count > 0) {
        set.colors = self.colors;
    } else {
        NSMutableArray *colors = [[NSMutableArray alloc] init];
        [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
        set.colors = colors;
    }
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set];
    
    BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
    [data setValueFont:[UIFont systemFontOfSize:12]];
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:[[NSNumberFormatter alloc] init]]];
    [data setValueTextColor:UIColor.blackColor];
    
    self.barChartView.data = data;
    
    if (self.titles.count > self.visibleXRangeMaximum) {
        [self.barChartView setVisibleXRangeMaximum:self.visibleXRangeMaximum];
    }
}
#pragma mark - IChartAxisValueFormatter
- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis {
    return self.titles[(int)value % self.titles.count];
}
#pragma mark ChartViewDelegate
// 点击
-(void)chartValueSelected:(ChartViewBase *)chartView entry:(ChartDataEntry *)entry highlight:(ChartHighlight *)highlight {
    NSLog(@"点击了 %f - %f", entry.x, entry.y);
}
// 停止在图表上的值之间移动
- (void)chartViewDidEndPanning:(ChartViewBase *)chartView {
    
}
// 没有选择任何内容或取消选择
- (void)chartValueNothingSelected:(ChartViewBase *)chartView {
    
}
// 缩放图表
- (void)chartScaled:(ChartViewBase *)chartView scaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY {
    
}
// 拖动手势移动/转换图表
- (void)chartTranslated:(ChartViewBase *)chartView dX:(CGFloat)dX dY:(CGFloat)dY {
    
}
// 停止动画
- (void)chartView:(ChartViewBase *)chartView animatorDidStop:(ChartAnimator *)animator {
    
}

@end
