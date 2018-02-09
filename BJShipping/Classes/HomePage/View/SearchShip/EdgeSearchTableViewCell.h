//
//  EdgeSearchTableViewCell.h
//  BJShipping
//
//  Created by UEdge on 2017/10/19.
//  Copyright © 2017年 UEdge. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EdgeSearchTableViewCell;

@protocol EdgeSearchHistoryCellDeleagte <NSObject>

@optional

/**
 点击删除历史记录

 @param cell cell
 */
- (void)onDelSearchHistoryRecord:(EdgeSearchTableViewCell *)cell;

/**
 点击历史记录按钮

 @param cell cell
 */
- (void)searchHistoryCellOnTap:(EdgeSearchTableViewCell *)cell;

@end

@interface EdgeSearchTableViewCell : UITableViewCell
@property (strong, nonatomic) NSString *text;
@property (copy, nonatomic) void(^operation)();
/**点击index*/
@property (strong, nonatomic, readonly) NSIndexPath *indexPath;
@property (weak, nonatomic) id<EdgeSearchHistoryCellDeleagte> delegate;

+ (instancetype)searchHistoryCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
@end
