//
//  EdgeCollectionViewCell.h
//  BJShipping
//
//  Created by UEdge on 2017/10/17.
//  Copyright © 2017年 UEdge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EdgeCollectionModel.h"
@class EdgeFlowViewModel;
@interface EdgeCollectionViewCell : UICollectionViewCell
/**imageView*/
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/**label*/
@property (weak, nonatomic) IBOutlet UILabel *label;

@property(nonatomic,strong)EdgeCollectionModel *collectionModel;

/**image距离顶部距离*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topMargin;

/**消息数量label*/
@property (weak, nonatomic) IBOutlet UILabel *messageCountLabel;

@end
