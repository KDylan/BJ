//
//  EdgeSearchTableViewCell.m
//  BJShipping
//
//  Created by UEdge on 2017/10/19.
//  Copyright © 2017年 UEdge. All rights reserved.
//

#import "EdgeSearchTableViewCell.h"

@interface EdgeSearchTableViewCell(){
    NSIndexPath * _indexPath;
}

/**历史记录标题*/
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation EdgeSearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
}

- (NSIndexPath *)indexPath {
    return _indexPath;
}

- (void)setText:(NSString *)text {
    _text = text;
    _titleLabel.text = text;
}


+ (instancetype)searchHistoryCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *CellID = @"SearchHistoryCell";
    EdgeSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EdgeSearchTableViewCell" owner:nil options:nil] lastObject];
        
    }
    [cell setIndexPath:indexPath];
    return cell;
}

/**
 点击删除按钮

 @param sender action
 */
- (IBAction)onDelBtnTap:(id)sender {
    if ([_delegate respondsToSelector:@selector(onDelSearchHistoryRecord:)]) {
        [_delegate onDelSearchHistoryRecord:self];
    }
}

/**
 点击cell

 @param sender action
 */
- (IBAction)onCellTap:(id)sender {
    if ([_delegate respondsToSelector:@selector(searchHistoryCellOnTap:)]) {
        [_delegate searchHistoryCellOnTap:self];
    }
}

@end
