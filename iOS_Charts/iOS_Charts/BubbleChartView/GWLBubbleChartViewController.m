//
//  GWLBubbleChartViewController.m
//  iOS_Charts
//
//  Created by gwl on 2020/1/8.
//  Copyright © 2020 gwl. All rights reserved.
//

#import "GWLBubbleChartViewController.h"

@interface GWLBubbleChartViewController () <IChartAxisValueFormatter, ChartViewDelegate>

@property (strong, nonatomic) BubbleChartView *bubbleChartView;

/// 圆柱 数据
@property (strong, nonatomic) NSArray *datas;
/// 圆柱 x轴标题
@property (strong, nonatomic) NSArray *titles;

/// 是否是堆叠式
@property (assign, nonatomic) BOOL isStacked;
/// 堆叠式圆柱 单个圆柱各层颜色数组
@property (strong, nonatomic) NSArray <UIColor *>*stackColors;
/// 堆叠式圆柱 图例文字数组
@property (strong, nonatomic) NSArray *stackLabels;

@end

@implementation GWLBubbleChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"BubbleChartView";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadData];
    [self setupBarChartView];
}
// 单层数据
- (void)loadData {
    self.titles = @[@"12",@"2",@"3",@"4",@"5",@"6.000",@"7",@"8",@"9",@"10",@"11",@"12"];
    self.datas = @[@"11",@"42",@"23",@"42",@"15",@"46.000",@"30",@"8",@"39",@"19",@"31",@"12"];
    
//            self.titles = @[@"12",@"2"];
//            self.datas = @[@"11",@"42"];
}

#pragma mark - BarChartView
-(void)setupBarChartView {
    [self.view addSubview:self.bubbleChartView];
    
#pragma mark - 配置
    //x轴动画
    [self.bubbleChartView animateWithYAxisDuration:1.0f];
    //y轴动画
    [self.bubbleChartView animateWithXAxisDuration:1.0f];
    
    //空表时显示的文字
    self.bubbleChartView.noDataText = @"暂无数据";
    //空表时显示的文字大小。默认12
    self.bubbleChartView.noDataFont = [UIFont systemFontOfSize:12];
    //空表时显示的文字颜色。默认black
    self.bubbleChartView.noDataTextColor = [UIColor blackColor];
    //空表时显示的文字位置。默认left
    self.bubbleChartView.noDataTextAlignment = NSTextAlignmentLeft;
    
    //绘制值的最大项数，大于此值的条目号将导致value-label消失。默认100
    self.bubbleChartView.maxVisibleCount = 100;
    //y轴自动缩放，默认NO
    self.bubbleChartView.autoScaleMinMaxEnabled = NO;
    
    //是否绘制网格背景。默认NO
    self.bubbleChartView.drawGridBackgroundEnabled = NO;
    //网格背景颜色。默认(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
    self.bubbleChartView.gridBackgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0];
    
    //是否绘制图表边框，绘制后就不需要绘制x轴和y轴的轴线了。默认NO
    self.bubbleChartView.drawBordersEnabled = NO;
    //图表边框颜色。默认black
    self.bubbleChartView.borderColor = [UIColor blackColor];
    //图表边框宽度。默认1.0
    self.bubbleChartView.borderLineWidth = 1.0;
    
    //默认NO
    self.bubbleChartView.clipValuesToContentEnabled = NO;
    //NO时，则柱状图(x轴线)下方不裁剪突出的显示(图表放大后可看出效果)。默认YES
    self.bubbleChartView.clipDataToContentEnabled = YES;
    
    //图表周围的最小偏移量，值越大图表越小。默认为10
    self.bubbleChartView.minOffset = 10;
    //图表偏移量(上)。默认0
    self.bubbleChartView.extraTopOffset = 0;
    //图表偏移量(下)。默认0
    self.bubbleChartView.extraBottomOffset = 0;
    //图表偏移量(左)。默认0
    self.bubbleChartView.extraLeftOffset = 0;
    //图表偏移量(右)。默认0
    self.bubbleChartView.extraRightOffset = 0;
    //[self.bubbleChartView setExtraOffsetsWithLeft:0 top:0 right:0 bottom:0];
    
    //默认NO
    self.bubbleChartView.keepPositionOnRotation = YES;
    //是否有浮层。默认YES
    self.bubbleChartView.drawMarkers = YES;
    
    
    ChartDescription *chartDescription = [[ChartDescription alloc] init];
    chartDescription.text = @"图表描述文字";
    //图表描述文字位置，right时显示在图表网格内右下方，设置为center或者left时则文字更靠右超出右侧网格，不知为何。默认right
    chartDescription.textAlign = NSTextAlignmentRight;
    chartDescription.font = [UIFont systemFontOfSize:16];
    //默认black
    chartDescription.textColor = [UIColor orangeColor];
    //图表描述信息
    self.bubbleChartView.chartDescription = chartDescription;
    
    //是否有图例。默认YES
    self.bubbleChartView.legend.enabled = YES;
    //图例图形大小。默认8.0
    self.bubbleChartView.legend.formSize = 8.0;
    //图例文字大小。默认10
    self.bubbleChartView.legend.font = [UIFont systemFontOfSize:10];
    //图例文字颜色。默认black
    self.bubbleChartView.legend.textColor = [UIColor blackColor];
    //图例位置。默认left
    self.bubbleChartView.legend.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
    //图例排列方向。默认Horizontal
    self.bubbleChartView.legend.orientation = ChartLegendOrientationHorizontal;
    
    //多点触控。默认NO
    self.bubbleChartView.multipleTouchEnabled = NO;
    //平移拖动。默认YES
    self.bubbleChartView.dragEnabled = YES;
    //x轴缩放，默认YES
    self.bubbleChartView.scaleXEnabled = YES;
    //y轴缩放 默认YES
    self.bubbleChartView.scaleYEnabled = YES;
    //图表是否可以x轴滑动(包括放大后)。默认YES
    self.bubbleChartView.dragXEnabled = YES;
    //图表是否可以y轴滑动(包括放大后)。默认YES
    self.bubbleChartView.dragYEnabled = YES;
    //触控放大，默认NO
    self.bubbleChartView.pinchZoomEnabled = NO;
    //双击放大图表，默认YES
    self.bubbleChartView.doubleTapToZoomEnabled = YES;
    //拖动后图表是否继续滚动，默认YES。
    self.bubbleChartView.dragDecelerationEnabled = YES;
    //减速摩擦系数，间隔0-1，如果将其设置为0，它将立即停止，1是无效值，并将自动转换为0.9999。默认0.9
    self.bubbleChartView.dragDecelerationFrictionCoef = 0.9;
    
    //当图表完全缩小的时候，每一次拖动都会高亮显示在图标视图上。默认YES
    self.bubbleChartView.highlightPerDragEnabled = YES;
    //设置最大高亮距离（dp）。在图表中的点击位置距离条目的距离超过此距离不会触发高亮显示。默认500
    self.bubbleChartView.maxHighlightDistance = 500;
    //设置为NO，禁止点击手势高亮显示值，值仍然可以通过拖动或编程方式突出显示。默认YES
    self.bubbleChartView.highlightPerTapEnabled = YES;
    
#pragma mark - xAxis x轴
    ChartXAxis *xAxis = self.bubbleChartView.xAxis;
    
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
    
    //设置x轴标签显示，例如：设置3则每隔两个柱子显示一个标签。默认1
    xAxis.granularity = 1;
    //x轴显示数量，和setVisibleXRangeMaximum配合使用。默认6
    xAxis.labelCount = self.datas.count;
    
    //标签格式化，设置后则titles显示换成0开始的序列号
    NSNumberFormatter *setFormatter = [[NSNumberFormatter alloc] init];
    setFormatter.positivePrefix = @"第";
    setFormatter.positiveSuffix = @"个";
    //xAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:setFormatter];
    //小数位
    xAxis.decimals = 0;
    
    //默认NO
    xAxis.forceLabelsEnabled = NO;
    //默认0.0
    xAxis.axisRange = 0;
    //限制线。默认NO
    xAxis.drawLimitLinesBehindDataEnabled = NO;
    //默认YES
    xAxis.gridAntialiasEnabled = YES;
    //默认NO
    xAxis.granularityEnabled = NO;
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
    xAxis.wordWrapEnabled = NO;
    //wordWrapEnabled == YES时，x轴标签显示宽度的百分比。默认1.0
    xAxis.wordWrapWidthPercent = 1.0;
    
#pragma mark - leftAxis y轴
    ChartYAxis *leftAxis = self.bubbleChartView.leftAxis;
    
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
    
#pragma mark - rightAxis y轴(参考leftAxis)
    //隐藏右侧显示，默认YES
    self.bubbleChartView.rightAxis.enabled = NO;
    
    
    [self drawData];
}
#pragma mark - data
- (void)drawData {
    NSMutableArray *entries = [NSMutableArray array];
    for (int i = 0; i < self.datas.count; i++) {
        BubbleChartDataEntry *entry = [[BubbleChartDataEntry alloc] initWithX:i y:[self.datas[i] integerValue] size:500];
        [entries addObject:entry];
    }
    
    BubbleChartDataSet *set = [[BubbleChartDataSet alloc] initWithEntries:entries label:@"图例"];
    
    BubbleChartData *data = [[BubbleChartData alloc] initWithDataSet:set];
    
    self.bubbleChartView.data = data;
    
    [self.bubbleChartView setVisibleXRangeMaximum:self.datas.count];
}

//#pragma mark - IChartAxisValueFormatter
- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis {
    return self.titles[(int)value];
}

#pragma mark - lazy
- (BubbleChartView *)bubbleChartView {
    if (!_bubbleChartView) {
        _bubbleChartView = [[BubbleChartView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT - TABBAR_BOTTOM_HEIGHT)];
        _bubbleChartView.delegate = self;
        _bubbleChartView.xAxis.valueFormatter = self;
    }
    return _bubbleChartView;
}

@end
