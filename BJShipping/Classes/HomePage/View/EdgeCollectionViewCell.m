//
//  EdgeCollectionViewCell.m
//  BJShipping
//
//  Created by UEdge on 2017/10/17.
//  Copyright © 2017年 UEdge. All rights reserved.
//

#import "EdgeCollectionViewCell.h"

@implementation EdgeCollectionViewCell


-(void)setCollectionModel:(EdgeCollectionModel *)collectionModel{
    
    _collectionModel = collectionModel;
    
    self.imageView.image = [UIImage imageNamed:collectionModel.buttonImageName];
   
    self.label.text = collectionModel.buttonLabel;
    
    self.messageCountLabel.text = collectionModel.messageCount;
}

// 重新定义label
-(void)setLabel:(UILabel *)label{
    
    _label = label;

    if (Screen_H<600.0) {// 4.0屏幕
        
         self.topMargin.constant = 0.0;
        label.font = [UIFont systemFontOfSize:13.0];
        
    }else{
        
        if (Screen_H<700.0) {// 4.7屏幕
            
            self.topMargin.constant = 3.0;
            label.font = [UIFont systemFontOfSize:14.0];
      
        }else{// 5.5以上
            
            self.topMargin.constant = 15.0;
            label.font = [UIFont systemFontOfSize:15.0];
            
        }
       
    }
}

// 设置图片大小
-(void)setTopMargin:(NSLayoutConstraint *)topMargin{

    _topMargin = topMargin;
    
    if (Screen_H<600.0) {// 4.0屏幕
        
        topMargin.constant = 0.0;
        
    }else{
        
        if (Screen_H<700.0) {// 4.7屏幕
            
            topMargin.constant = 5.0;
            
        }else{// 5.5以上
            
            topMargin.constant = 10.0;
            
        }
        
    }
}

-(void)setMessageCountLabel:(UILabel *)messageCountLabel{
    
    _messageCountLabel = messageCountLabel;
  
    messageCountLabel.layer.masksToBounds = YES;
    messageCountLabel.layer.cornerRadius = 8.0;
}
@end
