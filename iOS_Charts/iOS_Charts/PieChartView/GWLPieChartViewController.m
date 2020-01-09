//
//  GWLPieChartViewController.m
//  iOS_Charts
//
//  Created by gwl on 2020/1/8.
//  Copyright © 2020 gwl. All rights reserved.
//

#import "GWLPieChartViewController.h"

@interface GWLPieChartViewController ()

@property (strong, nonatomic) PieChartView *pieChartView;

@end

@implementation GWLPieChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"PieChartView";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupView:@[@"32", @"12", @"45", @"24", @"50"] colorsArr:@[]];
}

- (void)setupView:(NSArray *)arr colorsArr:(NSArray *)colorsArr {
    self.pieChartView = [[PieChartView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT - TABBAR_BOTTOM_HEIGHT)];
    [self.view addSubview:self.pieChartView];
    
    //饼状图距离边缘的间隙
    [self.pieChartView setExtraOffsetsWithLeft:30 top:30 right:30 bottom:30];
    //是否根据所提供的数据, 将显示数据转换为百分比格式，默认YES
    self.pieChartView.usePercentValuesEnabled = YES;
    //图形是否延伸到中心，即无空心。默认NO
    self.pieChartView.drawSlicesUnderHoleEnabled= NO;
    //空心半径占比。默认0.5
    self.pieChartView.holeRadiusPercent = 0.5;
    //半透明空心半径占比
    self.pieChartView.transparentCircleRadiusPercent = 0.55;
    //半透明空心的颜色
    self.pieChartView.transparentCircleColor = [UIColor redColor];
    //是否允许拖拽旋转。默认YES
    self.pieChartView.rotationEnabled = YES;
    //拖拽饼状图后是否有惯性效果。默认YES
    self.pieChartView.dragDecelerationEnabled = YES;
    //拖拽旋转后惯性系数0-1。默认0.9
    self.pieChartView.dragDecelerationFrictionCoef = 0.9;
    
    self.pieChartView.highlightPerTapEnabled = YES;
    

    //标记，指示是否应该绘制入口标签。默认 YES
    self.pieChartView.drawEntryLabelsEnabled = YES;
    //条目标签的颜色。
    self.pieChartView.entryLabelColor = [UIColor redColor];
    //条目标签字体大小。name: "", size: 13.0
    self.pieChartView.entryLabelFont = [UIFont systemFontOfSize:13];
    
    //默认NO
    self.pieChartView.drawSlicesUnderHoleEnabled = YES;
    
    //饼状图是否是空心，默认YES
    self.pieChartView.drawHoleEnabled = YES;
    //空心颜色。默认white
    self.pieChartView.holeColor = [UIColor whiteColor];
    //是否显示中心文字
    self.pieChartView.drawCenterTextEnabled = YES;
    //中心文字
    self.pieChartView.centerText = @"中间文字";
    //中心文字 富文本
    //self.pieChartView.centerAttributedText = ;
    //中心文字的偏移量
    self.pieChartView.centerTextOffset = CGPointMake(0, 0);
    //默认1.0
    self.pieChartView.centerTextRadiusPercent = 1.0;
    //饼图显示的最大角度。默认360.0
    self.pieChartView.maxAngle = 360;
    //饼图显示时旋转的角度。默认270.0
    self.pieChartView.rotationAngle = 270;
    //饼图周围的最小偏移量，影响饼图大小。默认0
    self.pieChartView.minOffset = 0;
    //是否双指拖拽旋转，值为YES时则单指无法拖拽旋转。默认NO
    self.pieChartView.rotationWithTwoFingers = NO;
    
    
    //空表时显示的文本
    self.pieChartView.noDataText = @"暂无数据";
    self.pieChartView.noDataFont = [UIFont systemFontOfSize:13];
    self.pieChartView.noDataTextColor = [UIColor blackColor];
    //默认left
    self.pieChartView.noDataTextAlignment = NSTextAlignmentLeft;
    
    //默认YES
    self.pieChartView.drawMarkers = YES;
    
    //顶部偏移量，影响饼图大小。默认0
    self.pieChartView.extraTopOffset = 0;
    //右侧偏移量，影响饼图大小。默认0
    self.pieChartView.extraRightOffset = 0;
    //底部偏移量，影响饼图大小。默认0
    self.pieChartView.extraBottomOffset = 0;
    //左侧偏移量，影响饼图大小。默认0
    self.pieChartView.extraLeftOffset = 0;
    
    //饼状图描述
    self.pieChartView.chartDescription.enabled = YES;
    if (self.pieChartView.chartDescription.isEnabled) {
        //饼状图描述文字
        self.pieChartView.chartDescription.text = @"饼状图描述文字";
        //饼状图描述文字颜色
        self.pieChartView.chartDescription.textColor = [UIColor redColor];
        //饼状图描述文字位置。默认right
        self.pieChartView.chartDescription.textAlign = NSTextAlignmentRight;
        //饼状图描述文字大小
        self.pieChartView.chartDescription.font = [UIFont systemFontOfSize:15];
    }
    
    self.pieChartView.legend.enabled = YES;
    //图例在饼状图中的大小占比。默认0.95
    self.pieChartView.legend.maxSizePercent = 0.95;
    ////图例文本间隔
    self.pieChartView.legend.formToTextSpace = 50;
    ////图例字体大小间隔
    self.pieChartView.legend.font = [UIFont systemFontOfSize:20];
    ////图例字体颜色间隔
    self.pieChartView.legend.textColor = [UIColor blueColor];
    //图例在饼状图中水平方向的位置，默认left
    self.pieChartView.legend.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
    //图例在饼状图中垂直方向的位置，默认bottom
    self.pieChartView.legend.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    //图例排列方向，默认horizontal
    self.pieChartView.legend.orientation = ChartLegendOrientationHorizontal;
    //图示样式。默认square
    self.pieChartView.legend.form = ChartLegendFormSquare;
    //图示大小
    self.pieChartView.legend.formSize = 30;
    
    [self setData:arr colorsArr:colorsArr];
}

- (PieChartData *)setData:(NSArray *)arr colorsArr:(NSArray *)colorsArr {
    NSMutableArray *values = [[NSMutableArray alloc] init];
    for (int i = 0; i < arr.count; i++) {
        NSString * aaa = arr[i];
        double bb = aaa.doubleValue;
        [values addObject:[[PieChartDataEntry alloc] initWithValue: bb label:@""]];
    }
    
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithEntries:values label:@"sadad"];
    dataSet.drawValuesEnabled = YES;
    //文字显示位置，默认insideSlice
    // dataSet.xValuePosition = PieChartValuePositionOutsideSlice;
    //文字显示位置，默认insideSlice
    dataSet.yValuePosition = PieChartValuePositionOutsideSlice;
    dataSet.valueFont = [UIFont systemFontOfSize:20];
    dataSet.valueTextColor = [UIColor blackColor];
    //yValuePosition == PieChartValuePositionOutsideSlice 时生效，指示线颜色和饼图切片颜色相同。默认NO
    dataSet.useValueColorForLine = NO;
    //yValuePosition == PieChartValuePositionOutsideSlice 时生效，指示线颜色。默认black
    dataSet.valueLineColor = [UIColor blackColor];
    //yValuePosition == PieChartValuePositionOutsideSlice 时生效，指示线宽度。默认1.0
    dataSet.valueLineWidth = 1.0;
    //默认NO
    dataSet.automaticallyDisableSliceSpacing = NO;
    //yValuePosition == PieChartValuePositionOutsideSlice 时生效，指示线偏移量占饼图百分比。默认0.75
    dataSet.valueLinePart1OffsetPercentage = 0.75;
    //yValuePosition == PieChartValuePositionOutsideSlice 时生效，指示线前半部分长度占饼图百分比。默认0.3
    dataSet.valueLinePart1Length = 0.3;
    //yValuePosition == PieChartValuePositionOutsideSlice 时生效，指示线后半部分长度占饼图百分比。默认0.4
    dataSet.valueLinePart2Length = 0.4;
    //yValuePosition == PieChartValuePositionOutsideSlice 时生效，指示线后半部分长度占饼图百分比。默认0.4
    //yValuePosition == PieChartValuePositionOutsideSlice 时生效，旋转饼图时，是否动态改变指示线的长度。默认YES
    dataSet.valueLineVariableLength = YES;
    dataSet.entryLabelFont = [UIFont systemFontOfSize:60];
    dataSet.entryLabelColor = [UIColor blueColor];
    //饼图选中后的颜色
    dataSet.highlightColor = [UIColor grayColor];
    //饼图距离边距距离。默认18.0
    dataSet.selectionShift = 18;
    
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    
    if (colorsArr.count > 0) {
        dataSet.colors = [NSMutableArray arrayWithArray:colorsArr];
    } else {
        [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
        dataSet.colors = colors;
    }
    
    dataSet.sliceSpace = 0;
    
    PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
    //饼图选中后时候放大显示。默认YES
    data.highlightEnabled = YES;
    
    self.pieChartView.data = data;
    [self.pieChartView setNeedsDisplay];
    
    return data;
}

#pragma mark ChartViewDelegate 参见 GWLBarChartView


@end
