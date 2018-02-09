//
//  EdgeCollectionView.h
//  BJShipping
//
//  Created by UEdge on 2017/10/17.
//  Copyright © 2017年 UEdge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EdgeCollectionModel.h"
@interface EdgeCollectionView : UIView

@property (nonatomic, strong) NSArray *typeItemArray;//数据源

/**item点击回调*/
@property(nonatomic , copy) void (^clickCellCb)(int , EdgeCollectionModel *);


/**刷新数据*/
-(void)reloadData;
//消息数量
@property(nonatomic,strong)NSString *messageCount;
@end
