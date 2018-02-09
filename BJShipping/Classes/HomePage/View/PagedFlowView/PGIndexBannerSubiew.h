//
//  PGIndexBannerSubiew.h
//  NewPagedFlowViewDemo

/******************************
 
 可以根据自己的需要继承PGIndexBannerSubiew
 
 ******************************/

#import <UIKit/UIKit.h>
#import "EdgeFlowViewModel.h"

@class EdgeFlowViewModel;

@interface PGIndexBannerSubiew : UIView
/**数据模型*/
@property(nonatomic,strong)EdgeFlowViewModel *flowModel;

/**新闻标题Label*/
@property (nonatomic, strong) UILabel *titleIndexLabel;

/**
 *  主图
 */
@property (nonatomic, strong) UIImageView *mainImageView;

/**
 *  用来变色的view
 */
@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, copy) void (^didSelectCellBlock)(NSInteger tag, PGIndexBannerSubiew *cell);

/**
 设置子控件frame,继承后要重写

 @param superViewBounds <#superViewBounds description#>
 */
- (void)setSubviewsWithSuperViewBounds:(CGRect)superViewBounds;

@property(nonatomic,strong)NSString *scroll_Url;

@end
