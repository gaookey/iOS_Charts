//
//  GWLBarChartViewController.m
//  iOS_Charts
//
//  Created by gwl on 2020/1/8.
//  Copyright © 2020 gwl. All rights reserved.
//

#import "GWLBarChartViewController.h"

typedef NS_ENUM(NSInteger, BarChartViewType) {
    BarChartViewTypeSingle = 1 << 0,//单柱
    BarChartViewTypeGroup = 1 << 1,//分组
    BarChartViewTypeStacked = 1 << 2,//堆叠式
};

@interface GWLBarChartViewController () <IChartAxisValueFormatter, ChartViewDelegate>

/// 默认垂直显示，水平柱状图使用 HorizontalBarChartView
@property (strong, nonatomic) BarChartView *barChartView;

@property (assign, nonatomic) BarChartViewType barChartViewType;

/// 圆柱 数据
@property (strong, nonatomic) NSArray *datas;
/// 圆柱 x轴标题
@property (strong, nonatomic) NSArray *titles;

/// 堆叠式圆柱 单个圆柱各层颜色数组
@property (strong, nonatomic) NSArray <UIColor *>*stackColors;
/// 堆叠式圆柱 图例文字数组
@property (strong, nonatomic) NSArray *stackLabels;

///maskView
@property (strong, nonatomic) UIView *maskView;

@end

@implementation GWLBarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"BarChartView";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadData];
//    [self loadStackedData];
//    [self loadGroupData];
    [self setupBarChartView];
}
// 单层数据
- (void)loadData {
    self.barChartViewType = BarChartViewTypeSingle;
    
    self.titles = @[@"12",@"2",@"3",@"4",@"5",@"6.000",@"7",@"8",@"9",@"10",@"11",@"12"];
    self.datas = @[@"11",@"42",@"23",@"42",@"15",@"46.000",@"30",@"8",@"39",@"19",@"31",@"12"];
}
// stacked数据
- (void)loadStackedData {
    self.barChartViewType = BarChartViewTypeStacked;
    
    self.titles = @[@"4", @"6", @"7",@"433333333333333333333",@"4", @"6", @"7",@"4",@"4", @"6", @"7",@"4"];
    self.datas = @[@[@"12", @"32", @"23"], @[@"32",@"12",@"23"], @[@"12", @"23",@"32"],@[@"12", @"32", @"23"],@[@"12", @"32", @"23"], @[@"32",@"12",@"23"], @[@"12", @"23",@"32"],@[@"12", @"32", @"23"],@[@"12", @"32", @"23"], @[@"32",@"12",  @"23"], @[@"12", @"23",@"32"],@[@"12", @"32", @"23"]];
    self.stackLabels = @[@"2", @"5", @"8"];
    self.stackColors = @[[UIColor orangeColor], [UIColor grayColor], [UIColor cyanColor]];
}
//分组数据
- (void)loadGroupData {
    self.barChartViewType = BarChartViewTypeGroup;
    
    self.datas = @[@[@"99", @"32", @"23", @"35", @"78", @"13"], @[@"12", @"33", @"58", @"03", @"48", @"29"], @[@"08", @"59", @"12", @"32", @"59", @"20"]];
    self.titles = @[@"4",@"6", @"7",@"4",@"4", @"5"];
}
#pragma mark - BarChartView
-(void)setupBarChartView {
    [self.view addSubview:self.barChartView];
    
#pragma mark - 配置
    
    //柱状条后面画一个灰色区域，表示最大值。默认NO
    self.barChartView.drawBarShadowEnabled = NO;
    //显示顶部文字。默认YES
    self.barChartView.drawValueAboveBarEnabled = YES;
    //在圆柱左右两端各增加一半的条宽。默认NO
    self.barChartView.fitBars = NO;
    //仅适用于堆叠式(stacked)，当为YES时，点击圆柱时即使只选中了一个堆栈条目，也会高亮整条圆柱。默认NO
    self.barChartView.highlightFullBarEnabled = NO;
    
    //x轴动画
    [self.barChartView animateWithYAxisDuration:1.0f];
    //y轴动画
    [self.barChartView animateWithXAxisDuration:1.0f];
    
    //空表时显示的文字
    self.barChartView.noDataText = @"暂无数据";
    //空表时显示的文字大小。默认12
    self.barChartView.noDataFont = [UIFont systemFontOfSize:12];
    //空表时显示的文字颜色。默认black
    self.barChartView.noDataTextColor = [UIColor blackColor];
    //空表时显示的文字位置。默认left
    self.barChartView.noDataTextAlignment = NSTextAlignmentLeft;
    
    //绘制值的最大项数，大于此值的条目号将导致value-label消失。默认100
    self.barChartView.maxVisibleCount = 100;
    //y轴自动缩放，默认NO
    self.barChartView.autoScaleMinMaxEnabled = NO;
    
    //是否绘制网格背景。默认NO
    self.barChartView.drawGridBackgroundEnabled = NO;
    //网格背景颜色。默认(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
    self.barChartView.gridBackgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0];
    
    //是否绘制图表边框，绘制后就不需要绘制x轴和y轴的轴线了。默认NO
    self.barChartView.drawBordersEnabled = NO;
    //图表边框颜色。默认black
    self.barChartView.borderColor = [UIColor blackColor];
    //图表边框宽度。默认1.0
    self.barChartView.borderLineWidth = 1.0;
    
    //默认NO
    self.barChartView.clipValuesToContentEnabled = NO;
    //NO时，则柱状图(x轴线)下方不裁剪突出的显示(图表放大后可看出效果)。默认YES
    self.barChartView.clipDataToContentEnabled = YES;
    
    //图表周围的最小偏移量，值越大图表越小。默认为10
    self.barChartView.minOffset = 10;
    //图表偏移量(上)。默认0
    self.barChartView.extraTopOffset = 0;
    //图表偏移量(下)。默认0
    self.barChartView.extraBottomOffset = 0;
    //图表偏移量(左)。默认0
    self.barChartView.extraLeftOffset = 0;
    //图表偏移量(右)。默认0
    self.barChartView.extraRightOffset = 0;
    //[self.barChartView setExtraOffsetsWithLeft:0 top:0 right:0 bottom:0];
    
    //默认NO
    self.barChartView.keepPositionOnRotation = YES;
    //默认YES
    self.barChartView.drawMarkers = YES;
    ChartMarkerView *makerView = [[ChartMarkerView alloc] init];
    makerView.chartView = self.barChartView;
    self.barChartView.marker = makerView;
    //自定义的maskView
    self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 33, 33)];
    self.maskView.backgroundColor = UIColor.redColor;
    [makerView addSubview:self.maskView];
    
    
    ChartDescription *chartDescription = [[ChartDescription alloc] init];
    chartDescription.text = @"图表描述文字";
    //图表描述文字位置，right时显示在图表网格内右下方，设置为center或者left时则文字更靠右超出右侧网格，不知为何。默认right
    chartDescription.textAlign = NSTextAlignmentRight;
    chartDescription.font = [UIFont systemFontOfSize:16];
    //默认black
    chartDescription.textColor = [UIColor orangeColor];
    //图表描述信息
    self.barChartView.chartDescription = chartDescription;
    
    //是否有图例。默认YES
    self.barChartView.legend.enabled = YES;
    //图例图形大小。默认8.0
    self.barChartView.legend.formSize = 8.0;
    //图例文字大小。默认10
    self.barChartView.legend.font = [UIFont systemFontOfSize:10];
    //图例文字颜色。默认black
    self.barChartView.legend.textColor = [UIColor blackColor];
    //图例位置。默认left
    self.barChartView.legend.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
    //图例排列方向。默认Horizontal
    self.barChartView.legend.orientation = ChartLegendOrientationHorizontal;
    
    //多点触控。默认NO
    self.barChartView.multipleTouchEnabled = NO;
    //平移拖动。默认YES
    self.barChartView.dragEnabled = YES;
    //x轴缩放，默认YES
    self.barChartView.scaleXEnabled = YES;
    //y轴缩放 默认YES
    self.barChartView.scaleYEnabled = YES;
    //图表是否可以x轴滑动(包括放大后)。默认YES
    self.barChartView.dragXEnabled = YES;
    //图表是否可以y轴滑动(包括放大后)。默认YES
    self.barChartView.dragYEnabled = YES;
    //触控放大，默认NO
    self.barChartView.pinchZoomEnabled = NO;
    //双击放大图表，默认YES
    self.barChartView.doubleTapToZoomEnabled = YES;
    //拖动后图表是否继续滚动，默认YES。
    self.barChartView.dragDecelerationEnabled = YES;
    //减速摩擦系数，间隔0-1，如果将其设置为0，它将立即停止，1是无效值，并将自动转换为0.9999。默认0.9
    self.barChartView.dragDecelerationFrictionCoef = 0.9;
    
    //当图表完全缩小的时候，每一次拖动都会高亮显示在图标视图上。默认YES
    self.barChartView.highlightPerDragEnabled = YES;
    //设置最大高亮距离（dp）。在图表中的点击位置距离条目的距离超过此距离不会触发高亮显示。默认500
    self.barChartView.maxHighlightDistance = 500;
    //设置为NO，禁止点击手势高亮显示值，值仍然可以通过拖动或编程方式突出显示。默认YES
    self.barChartView.highlightPerTapEnabled = YES;
    
#pragma mark - xAxis x轴
    ChartXAxis *xAxis = self.barChartView.xAxis;
    
    // !!!: ComponentBase 属性
    
    //是否显示x轴。默认YES
    xAxis.enabled = YES;
    //默认5.0
    xAxis.xOffset = 5.0;
    //偏移量。改变值时文字位置不变，图表整体上移或下移距离的大小。默认5.0
    xAxis.yOffset = 5.0;
    
    // !!!: AxisBase 属性
    
    //绘制x轴的标签。默认YES
    xAxis.drawLabelsEnabled = YES;
    //标签文字大小。默认10
    xAxis.labelFont = [UIFont systemFontOfSize:10];
    //标签文字颜色。默认black
    xAxis.labelTextColor = [UIColor blackColor];
    //将轴标签居中，而不是将它们画在原来的位置。默认NO
    xAxis.centerAxisLabelsEnabled = NO;
    
    //显示x轴的轴线。默认YES
    xAxis.drawAxisLineEnabled = YES;
    //轴线的颜色。默认gray
    xAxis.axisLineColor = [UIColor grayColor];
    //轴线的宽度。默认0.5
    xAxis.axisLineWidth = 0.5;
    //默认0
    xAxis.axisLineDashPhase = 0;
    //轴线的虚线效果
    xAxis.axisLineDashLengths = @[];
    
    //显示网格线。默认YES
    xAxis.drawGridLinesEnabled = YES;
    //网格线的颜色
    xAxis.gridColor = [UIColor grayColor];
    //网格线的宽度。默认0.5
    xAxis.gridLineWidth = 0.5;
    xAxis.gridLineDashPhase = 0;
    //网格线的虚线效果，间距值
    xAxis.gridLineDashLengths = @[];
    
    //默认NO
    xAxis.granularityEnabled = NO;
    //granularityEnabled = YES时，设置x轴标签显示，例如：设置3则每隔两个柱子显示一个标签。默认1
    xAxis.granularity = 1;
    //x轴显示数量，全部显示，不滑动。若设置setVisibleXRangeMaximum则labelCount设置无效
    xAxis.labelCount = self.titles.count;
    
    //标签格式化，设置后则titles显示换成0开始的序列号
    NSNumberFormatter *setFormatter = [[NSNumberFormatter alloc] init];
    setFormatter.positivePrefix = @"第";
    setFormatter.positiveSuffix = @"个";
    //xAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:setFormatter];
    //小数位
    xAxis.decimals = 0;
    
    //不强制绘制指定数量的label。默认NO
    xAxis.forceLabelsEnabled = NO;
    //默认0.0
    xAxis.axisRange = 0;
    //开启抗锯齿。默认YES
    xAxis.gridAntialiasEnabled = YES;
    //默认butt
    xAxis.gridLineCap = kCGLineCapButt;
    
    //设置自定义最大值，如果设置则根据提供的数据将不会自动计算该值
    //xAxis.axisMaximum = 0;
    //撤销axisMaximum设置的最大值
    //[xAxis resetCustomAxisMax];
    //设置为0时则柱状图从最左端开始显示
    //xAxis.axisMinimum = 0.0;
    //第一条数据距最左端距离，相当于偏移几个单位量。默认0.5
    xAxis.spaceMin = 0.5;
    //最后一条数据距最右端距离，相当于偏移几个单位量。默认0.5
    xAxis.spaceMax = 0.5;
    
    // !!!: XAxis 属性
    
    //默认1.0
    xAxis.labelWidth = 1.0;
    //默认1.0
    xAxis.labelHeight = 1.0;
    //x轴标签文字倾斜度(图表会上移)。默认0.0
    xAxis.labelRotationAngle = 0.0;
    //默认1.0
    xAxis.labelRotatedHeight = 1.0;
    //默认1.0
    xAxis.labelRotatedWidth = 1.0;
    //x轴第一个和最后一个标签条目超过图表边缘时剪切。默认NO
    xAxis.avoidFirstLastClippingEnabled = NO;
    //x轴文字位置。默认top
    xAxis.labelPosition = XAxisLabelPositionBottom;
    //x轴标签文字换行。默认NO
    xAxis.wordWrapEnabled = YES;
    //wordWrapEnabled == YES时，x轴标签显示宽度的百分比。默认1.0
    xAxis.wordWrapWidthPercent = 1.0;
    
    //添加限制线
    ChartLimitLine *xLimitLine = [[ChartLimitLine alloc] initWithLimit:2 label:@"x轴限制线"];
    //添加到Y轴上
    [xAxis addLimitLine:xLimitLine];
    //限制线。默认NO
    xAxis.drawLimitLinesBehindDataEnabled = YES;
    
#pragma mark - leftAxis y轴
    ChartYAxis *leftAxis = self.barChartView.leftAxis;
    
    // !!!: ComponentBase
    
    //是否显示x轴。默认YES
    leftAxis.enabled = YES;
    //偏移量。改变值时图表位置不变，y轴标签文字右移距离的大小。默认5.0
    leftAxis.xOffset = 5.0;
    //默认0.0
    leftAxis.yOffset = 0.0;
    
    // !!!: AxisBase (参见 XAxis -> AxisBase)
    //y轴最大值
    //leftAxis.axisMaximum = 100;
    //y值最小值，不设置此值在stacked时，圆柱悬空(不从x轴线开始)
    leftAxis.axisMinimum = 0;
    
    // !!!: YAxis 属性
    
    //显示y轴底部标签项，默认YES
    leftAxis.drawBottomYLabelEntryEnabled = YES;
    //显示y轴顶部标签项，默认YES
    leftAxis.drawTopYLabelEntryEnabled = YES;
    //柱状图是否倒置，默认NO
    leftAxis.inverted = NO;
    //是否显示y轴零线。默认NO
    leftAxis.drawZeroLineEnabled = NO;
    //y轴零线颜色。默认gray
    leftAxis.zeroLineColor = [UIColor grayColor];
    //y轴零线宽度。默认1.0
    leftAxis.zeroLineWidth = 1.0;
    //默认0.0
    leftAxis.zeroLineDashPhase = 0.0;
    //y轴零线虚线效果
    leftAxis.zeroLineDashLengths = @[];
    //最大值到顶部所占整个轴的百分比，默认0.1
    leftAxis.spaceTop = 0.1;
    //默认0.1
    leftAxis.spaceBottom = 0.1;
    //y轴标签的显示位置。默认outsideChart
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
    //y轴文字的对齐方式。默认left
    leftAxis.labelAlignment = NSTextAlignmentLeft;
    //y轴标签的水平偏移量。默认10.0
    leftAxis.labelXOffset = 10.0;
    //y轴最小宽度。默认0.0
    leftAxis.minWidth = 0.0;
    //y轴最大宽度
    leftAxis.maxWidth = 50.0;
    
    //添加限制线
    ChartLimitLine *yLimitLine = [[ChartLimitLine alloc] initWithLimit:35 label:@"y轴限制线"];
    yLimitLine.lineWidth = 2;
    yLimitLine.lineColor = [UIColor greenColor];
    //虚线样式
    yLimitLine.lineDashLengths = @[@5.0f, @5.0f];
    //位置
    yLimitLine.labelPosition = ChartLimitLabelPositionTopRight;
    //添加到Y轴上
    [leftAxis addLimitLine:yLimitLine];
    //限制线。默认NO
    leftAxis.drawLimitLinesBehindDataEnabled = YES;
    
#pragma mark - rightAxis y轴(参考leftAxis)
    //隐藏右侧显示，默认YES
    self.barChartView.rightAxis.enabled = NO;
    
    
    switch (self.barChartViewType) {
        case BarChartViewTypeSingle:
            [self drawData];
            break;
        case BarChartViewTypeGroup:
            [self drawGroupData];
            break;
        case BarChartViewTypeStacked:
            [self drawStackedData];
            break;
            
        default:
            break;
    }
}
#pragma mark - GroupData
- (void)drawGroupData {
    double dataSetMax = 0;
    float groupSpace = 0.4;
    float barSpace = 0.03;
    //柱子宽度（(barSpace + barWidth) * 系列数 + groupSpace = 1.00 -> interval per "group"）
    float barWidth = 0.17;
    
    NSMutableArray *dataSets = [NSMutableArray array];
    for (int i = 0; i < self.datas.count; i++) {
        NSMutableArray *yVals = [NSMutableArray array];
        BarChartDataSet *set = nil;
        NSArray *array = self.datas[i];
        for (int j = 0; j < array.count; j++) {
            double val = [array[j] doubleValue];
            dataSetMax = MAX(val, dataSetMax);
            [yVals addObject:[[BarChartDataEntry alloc] initWithX:j y:val]];
            set = [[BarChartDataSet alloc] initWithEntries:yVals label:[NSString stringWithFormat:@"第%d个图例",i]];
            [set setColor:[UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1]];
            set.valueColors = @[UIColor.blackColor];
        }
        [dataSets addObject:set];
    }
    
    dataSetMax = (dataSetMax + dataSetMax * 0.1);
    
    self.barChartView.leftAxis.axisMaximum = dataSetMax;
    self.barChartView.leftAxis.axisMinimum = 0;
    
    BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
    data.barWidth = barWidth;
    [data groupBarsFromX:-0.5 groupSpace:groupSpace barSpace:barSpace];
    
    self.barChartView.data = data;
    
    [self.barChartView setVisibleXRangeMaximum:2];
}
#pragma mark - StackedData
- (void)drawStackedData {
    NSMutableArray *entries = [NSMutableArray array];
    for (int i = 0; i < self.datas.count; i++) {
        int total = 0;
        NSArray *datas = self.datas[i];
        for (int i = 0; i < datas.count; i ++) {
            NSString *str = datas[i];
            total += [str integerValue];
        }
        
        CGFloat num = 0;
        NSMutableArray *yValues = [NSMutableArray array];
        for (int i = 0; i < datas.count; i ++) {
            NSString *str = datas[i];
            num = [str integerValue] * 100 / (CGFloat)total;
            [yValues addObject:[NSNumber numberWithFloat:num]];
        }
        
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:i yValues:yValues];
        [entries addObject:entry];
    }
    
    BarChartDataSet *set = [[BarChartDataSet alloc] initWithEntries:entries label:@"图例"];
    set.stackLabels = self.stackLabels;
    if (self.stackColors.count > 0) {
        set.colors = self.stackColors;
    } else {
        NSMutableArray *colors = [[NSMutableArray alloc] init];
        [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
        set.colors = colors;
    }
    
    BarChartData *data = [[BarChartData alloc] initWithDataSet:set];
    
    self.barChartView.data = data;
}
#pragma mark - data
- (void)drawData {
    NSMutableArray *entries = [NSMutableArray array];
    for (int i = 0; i < self.datas.count; i++) {
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:i y:[self.datas[i] integerValue]];
        [entries addObject:entry];
    }
    
    BarChartDataSet *set = [[BarChartDataSet alloc] initWithEntries:entries label:@"图例"];
    //圆柱颜色
    [set setColor:[UIColor cyanColor]];
    
    NSNumberFormatter *setFormatter = [[NSNumberFormatter alloc] init];
    setFormatter.positiveSuffix = @"%";
    [set setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:setFormatter]];
    //单个高亮显示
    set.highlightEnabled = YES;
    //单个高亮显示颜色
    set.highlightColor = [UIColor purpleColor];
    //高亮颜色透明度。
    set.highlightAlpha = (120.0 / 255.0);
    //圆柱边宽。默认0.0
    set.barBorderWidth = 0.0;
    //圆柱边色。默认black
    set.barBorderColor = [UIColor blackColor];
    //圆柱阴影色。(red: 215.0/255.0, green: 215.0/255.0, blue: 215.0/255.0, alpha: 1.0)
    set.barShadowColor = [UIColor colorWithRed:(215.0/255.0) green:(215.0/255.0) blue:(215.0/255.0) alpha:1.0];
    //圆柱上是否显示文字
    set.drawValuesEnabled = YES;
    
    BarChartData *data = [[BarChartData alloc] initWithDataSet:set];
    //显示柱状图顶部文字。默认YES
    [data setDrawValues:YES];
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:[[NSNumberFormatter alloc] init]]];
    [data setValueTextColor:UIColor.blackColor];
    //柱状图顶部文字大小
    [data setValueFont:[UIFont systemFontOfSize:10]];
    //圆柱和间距的比例，默认0.85
    [data setBarWidth:0.85];
    
    self.barChartView.data = data;
    
    //设置左右滑动。
    [self.barChartView setVisibleXRangeMaximum:8];
}
#pragma mark - IChartAxisValueFormatter
- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis {
    return self.titles[(int)value];
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

#pragma mark - lazy
- (BarChartView *)barChartView {
    if (!_barChartView) {
        _barChartView = [[BarChartView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT - TABBAR_BOTTOM_HEIGHT)];
        _barChartView.delegate = self;
        _barChartView.xAxis.valueFormatter = self;
    }
    return _barChartView;
}

@end
