//
//  FuzzyShipTableViewCell.m
//  captain
//
//  Created by RockeyCai on 2016/12/26.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import "FuzzyShipTableViewCell.h"
#import "FuzzyShip.h"


@interface FuzzyShipTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *ship_name;

@property (weak, nonatomic) IBOutlet UILabel *ship_id;


@end


@implementation FuzzyShipTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setData:(FuzzyShip *)item{
    
    
    [self.icon setImage:[UIImage imageNamed:@"ship_logo"]];
    self.ship_name.text = item.name;//标题
    self.ship_id.text = item.ship_id;
}


@end
