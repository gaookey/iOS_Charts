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
///数据
@property (strong, nonatomic) NSArray *datas;
///x轴标签
@property (strong, nonatomic) NSArray *titles;

@end

@implementation GWLLineChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"LineChartView";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.titles = @[@"1标签", @"1标签3", @"5标签3", @"标签63", @"35标签", @"39标签", @"7标签0", @"2标签3",@"2标签3", @"标签13", @"标签53", @"6标签3", @"35标签", @"39标签", @"70标签", @"2标签3"];
    self.datas = @[@"23", @"13", @"53", @"63", @"35", @"39", @"70", @"23",@"23", @"13", @"53", @"63", @"35", @"39", @"70", @"23"];
    
    [self setupLineChartView];
}
#pragma mark - LineChartView
-(void)setupLineChartView {
    [self.view addSubview:self.lineChartView];
    
    //y轴自动缩放。默认NO
    self.lineChartView.autoScaleMinMaxEnabled = NO;
    //触控放大。默认NO
    self.lineChartView.pinchZoomEnabled = NO;
    //双击放大。默认YES
    self.lineChartView.doubleTapToZoomEnabled = YES;
    //图表是否可以x轴滑动(包括放大后)。默认YES
    self.lineChartView.dragXEnabled = YES;
    //图表是否可以x轴滑动(包括放大后)。默认YES
    self.lineChartView.dragYEnabled = YES;
    //x轴缩放，默认YES
    self.lineChartView.scaleXEnabled = YES;
    //y轴缩放 默认YES
    self.lineChartView.scaleYEnabled = YES;
    
    //是否绘制网格背景。默认NO
    self.lineChartView.drawGridBackgroundEnabled = NO;
    //网格背景颜色。默认(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
    self.lineChartView.gridBackgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0];
    
    //是否绘制图表边框，绘制后就不需要绘制x轴和y轴的轴线了。默认NO
    self.lineChartView.drawBordersEnabled = NO;
    //图表边框颜色。默认black
    self.lineChartView.borderColor = [UIColor blackColor];
    //图表边框宽度。默认1.0
    self.lineChartView.borderLineWidth = 1.0;
    
    //默认NO
    self.lineChartView.clipValuesToContentEnabled = NO;
    //默认YES
    self.lineChartView.clipDataToContentEnabled = YES;
    
    //图表周围的最小偏移量，值越大图表越小。默认为10
    self.lineChartView.minOffset = 10;
    //图表偏移量(上)。默认0
    self.lineChartView.extraTopOffset = 0;
    //图表偏移量(下)。默认0
    self.lineChartView.extraBottomOffset = 0;
    //图表偏移量(左)。默认0
    self.lineChartView.extraLeftOffset = 0;
    //图表偏移量(右)。默认0
    self.lineChartView.extraRightOffset = 0;
    //[self.barChartView setExtraOffsetsWithLeft:0 top:0 right:0 bottom:0];
    
    //默认NO
    self.lineChartView.keepPositionOnRotation = NO;
    
    //设置为NO，禁止点击手势高亮显示值，值仍然可以通过拖动或编程方式突出显示。默认YES
    self.lineChartView.highlightPerTapEnabled = YES;
    //拖动后图表是否继续滚动，默认YES。
    self.lineChartView.dragDecelerationEnabled = YES;
    //减速摩擦系数，间隔0-1，如果将其设置为0，它将立即停止，1是无效值，并将自动转换为0.9999。默认0.9
    self.lineChartView.dragDecelerationFrictionCoef = 0.9;
    
    ChartDescription *chartDescription = [[ChartDescription alloc] init];
    chartDescription.text = @"图表描述文字";
    //图表描述文字位置，right时显示在图表网格内右下方，设置为center或者left时则文字更靠右超出右侧网格，不知为何。默认right
    chartDescription.textAlign = NSTextAlignmentRight;
    chartDescription.font = [UIFont systemFontOfSize:16];
    //默认black
    chartDescription.textColor = [UIColor orangeColor];
    //图表描述信息
    self.lineChartView.chartDescription = chartDescription;
    
    //是否有图例。默认YES
    self.lineChartView.legend.enabled = YES;
    //图例图形大小。默认8.0
    self.lineChartView.legend.formSize = 8.0;
    //图例文字大小。默认10
    self.lineChartView.legend.font = [UIFont systemFontOfSize:10];
    //图例文字颜色。默认black
    self.lineChartView.legend.textColor = [UIColor blackColor];
    //图例位置。默认left
    self.lineChartView.legend.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
    //图例排列方向。默认Horizontal
    self.lineChartView.legend.orientation = ChartLegendOrientationHorizontal;
    
    //空表时显示的文字
    self.lineChartView.noDataText = @"暂无数据";
    //空表时显示的文字大小。默认12
    self.lineChartView.noDataFont = [UIFont systemFontOfSize:12];
    //空表时显示的文字颜色。默认black
    self.lineChartView.noDataTextColor = [UIColor blackColor];
    //空表时显示的文字位置。默认left
    self.lineChartView.noDataTextAlignment = NSTextAlignmentLeft;
    
    //默认YES
    self.lineChartView.drawMarkers = YES;
    
#pragma mark - xAxis x轴
    ChartXAxis *xAxis = self.lineChartView.xAxis;
        
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
    xAxis.granularity = 3;
    //x轴显示数量，默认6
    xAxis.labelCount = self.datas.count;
    
    
    //标签格式化，设置后则titles显示换成0开始的序列号
    NSNumberFormatter *setFormatter = [[NSNumberFormatter alloc] init];
    setFormatter.positivePrefix = @"第";
    setFormatter.positiveSuffix = @"个";
    //xAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:setFormatter];
    //xAxis.decimals = 0;
    
    //默认NO
    xAxis.forceLabelsEnabled = NO;
    //默认0.0
    xAxis.axisRange = 0;
    //默认NO
    xAxis.drawLimitLinesBehindDataEnabled = NO;
    //默认YES
    xAxis.gridAntialiasEnabled = YES;
    //默认NO
    xAxis.granularityEnabled = NO;
    //默认butt
    xAxis.gridLineCap = kCGLineCapButt;
    
    //第一条数据距最左端距离，相当于偏移几个单位量。默认0.0
    xAxis.spaceMin = 0;
    //最后一条数据距最右端距离，相当于偏移几个单位量。默认0.0
    xAxis.spaceMax = 0;
    
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
    ChartYAxis *leftAxis = self.lineChartView.leftAxis;
    
    // !!!: ComponentBase
    
    //是否显示x轴。默认YES
    leftAxis.enabled = YES;
    //默认5.0
    leftAxis.xOffset = 5.0;
    //默认5.0
    leftAxis.yOffset = 5.0;
    
    // !!!: AxisBase (参见 XAxis -> AxisBase)
    //y轴最大值
    //leftAxis.axisMaximum = 100;
    //y值最小值
    leftAxis.axisMinimum = 0;
    
    // !!!: YAxis 属性
    
    //显示y轴底部标签项，默认YES
    leftAxis.drawBottomYLabelEntryEnabled = YES;
    //显示y轴顶部标签项，默认YES
    leftAxis.drawTopYLabelEntryEnabled = YES;
    //是否倒置，默认NO
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
    self.lineChartView.rightAxis.enabled = NO;
    
    
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
    //(0.05-1.0)。默认0.2
    dataSet.cubicIntensity = 0.2;
    //显示每个点。默认YES
    dataSet.drawCirclesEnabled = YES;
    //是否圆心。默认YES
    dataSet.drawCircleHoleEnabled = YES;
    //每个点的大小。默认8.0
    dataSet.circleRadius = 8.0;
    //每个点的空心半径。默认4.0
    dataSet.circleHoleRadius = 4.0;
    //每个点的颜色。默认
    //dataSet.circleColors = @[UIColor.redColor, UIColor.orangeColor, UIColor.purpleColor];
    //每个点的空心颜色。默认white
    dataSet.circleHoleColor = UIColor.whiteColor;
    //默认0.0
    dataSet.lineDashPhase = 0.0;
    //折线虚线效果
    dataSet.lineDashLengths = @[];
//    dataSet.valueColors
//    dataSet.valueTextColor
    //折线颜色
    //dataSet.colors = @[UIColor.redColor, UIColor.purpleColor, UIColor.orangeColor, UIColor.blueColor];
    //折线颜色
    dataSet.color = UIColor.cyanColor;
    //单个高亮显示
    dataSet.highlightEnabled = YES;
    //单个高亮显示颜色
    dataSet.highlightColor = [UIColor purpleColor];
    //圆柱上是否显示文字
    dataSet.drawValuesEnabled = YES;
    dataSet.lineCapType = kCGLineCapButt;
    
    //显示折线下填充颜色。默认NO
    dataSet.drawFilledEnabled = NO;
    dataSet.fillColor = UIColor.orangeColor;
    //默认0.33
    dataSet.fillAlpha = 0.33;
    //折线的宽度(0.0-10.0)。默认1.0
    dataSet.lineWidth = 1.0;
    dataSet.formLineWidth = 50.0;
    
    NSNumberFormatter *setFormatter = [[NSNumberFormatter alloc] init];
       setFormatter.positiveSuffix = @"%";
//       [dataSet setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:setFormatter]];
    
    
    LineChartData *data = [[LineChartData alloc] initWithDataSet:dataSet];
    //显示每个顶点上的文字。默认YES
    [data setDrawValues:YES];
//    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:[[NSNumberFormatter alloc] init]]];
    //文字颜色
    [data setValueTextColor:UIColor.blackColor];
    //文字大小
    [data setValueFont:[UIFont systemFontOfSize:10]];
    
    
//    NSArray *arr = @[@"13", @"33", @"63", @"63", @"75", @"19", @"30"];
//    NSMutableArray *values2 = [[NSMutableArray alloc] init];
//       for (int i = 0; i < arr.count; i++) {
//           NSString * aaa = arr[i];
//           double bb = aaa.doubleValue;
//           ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:bb];
//           [values2 addObject:entry];
//       }
//       LineChartDataSet *dataSet2 = [[LineChartDataSet alloc] initWithEntries:values2 label:@"图例2"];
//
//    dataSet2.color = UIColor.redColor;
//    [data addDataSet:dataSet2];
    
    self.lineChartView.data = data;
}
#pragma mark - IChartAxisValueFormatter
//- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis {
//    return self.datas[(int)value % self.datas.count];
//}
#pragma mark - lazy
- (LineChartView *)lineChartView {
    if (!_lineChartView) {
        _lineChartView = [[LineChartView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT - TABBAR_BOTTOM_HEIGHT)];
        _lineChartView.delegate = self;
//        _lineChartView.xAxis.valueFormatter = self;
    }
    return _lineChartView;
}

@end
