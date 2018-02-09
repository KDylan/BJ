
//  PGIndexBannerSubiew.m
//  NewPagedFlowViewDemo


#import "PGIndexBannerSubiew.h"

#define Label_H 25.0

@implementation PGIndexBannerSubiew

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.mainImageView];
        [self addSubview:self.coverView];
        [self addSubview:self.titleIndexLabel];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleCellTapAction:)];
        [self addGestureRecognizer:singleTap];
    }
    
    return self;
}

- (void)singleCellTapAction:(UIGestureRecognizer *)gesture {
    if (self.didSelectCellBlock) {
        self.didSelectCellBlock(self.tag, self);
    }
}

- (void)setSubviewsWithSuperViewBounds:(CGRect)superViewBounds {
    
    if (CGRectEqualToRect(self.mainImageView.frame, superViewBounds)) {
        return;
    }
    
    self.mainImageView.frame = superViewBounds;
    self.coverView.frame = self.bounds;
    self.titleIndexLabel.frame = CGRectMake(0, superViewBounds.size.height-Label_H, superViewBounds.size.width, Label_H);
}

- (UIImageView *)mainImageView {
    
    if (_mainImageView == nil) {
        _mainImageView = [[UIImageView alloc] init];
        _mainImageView.userInteractionEnabled = YES;
    }
    return _mainImageView;
}

- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc] init];
        _coverView.backgroundColor = [UIColor whiteColor];
    }
    return _coverView;
}

-(UILabel *)titleIndexLabel{
    if (_titleIndexLabel == nil) {
        
        _titleIndexLabel = [[UILabel alloc] init];
        _titleIndexLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
        _titleIndexLabel.font = [UIFont systemFontOfSize:16.0];
        _titleIndexLabel.textColor = [UIColor whiteColor];
    }
    return _titleIndexLabel;
}

// 设置模型数据
-(void)setFlowModel:(EdgeFlowViewModel *)flowModel{
    
    _flowModel = flowModel;

    self.mainImageView.image = [UIImage imageNamed:flowModel.back_up1];
    self.titleIndexLabel.text = flowModel.nn_news_content;
//    self.scroll_Url = flowModel.Scroll_Url;
}
@end
