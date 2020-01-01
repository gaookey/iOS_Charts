//
//  GWLBarChartView.h
//  icits
//
//  Created by gwl on 2019/12/31.
//  Copyright © 2019 gwl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GWLBarChartView : UIView <IChartAxisValueFormatter, ChartViewDelegate>

/// 单层
- (instancetype)initWithFrame:(CGRect)frame datas:(NSArray <NSString *>*)datas titles:(NSArray <NSString *>*)titles;

/// 多层
- (instancetype)initWithFrame:(CGRect)frame multiLayerData:(NSArray <NSArray <NSString *>*>*)multiLayerData colors:(NSArray <UIColor *>*)colors stackLabels:(NSArray <NSString *>*)stackLabels titles:(NSArray <NSString *>*)titles;

@property (strong, nonatomic) BarChartView *barChartView;

@property (copy, nonatomic) void (^chartValueSelected)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
