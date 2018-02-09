//
//  EdgeCollectionViewCell.m
//  BJShipping
//
//  Created by UEdge on 2017/10/17.
//  Copyright © 2017年 UEdge. All rights reserved.
//

#define margin_1 3.0
#define margin_2 5.0
#define margin_3 10.0
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
        

        label.font = [UIFont systemFontOfSize:13.0];
        
    }else{
        
        if (Screen_H<700.0) {// 4.7屏幕
            
            label.font = [UIFont systemFontOfSize:14.0];
      
        }else{// 5.5以上
            
            label.font = [UIFont systemFontOfSize:15.0];
            
        }
       
    }
}

// 设置图片大小
-(void)setTopMargin:(NSLayoutConstraint *)topMargin{

    _topMargin = topMargin;
    
    if (Screen_H<600.0) {// 4.0屏幕
        
        topMargin.constant = margin_1;
        
    }else{
        
        if (Screen_H<700.0) {// 4.7屏幕
            
            topMargin.constant = margin_2;
            
        }else{// 5.5以上
            
            topMargin.constant = margin_3;
            
        }
        
    }
}

-(void)setMessageCountLabel:(UILabel *)messageCountLabel{
    
    _messageCountLabel = messageCountLabel;
  
    messageCountLabel.layer.masksToBounds = YES;
    messageCountLabel.layer.cornerRadius = messageCountLabel.frame.size.width/2;
}


-(void)setCountMarginTop:(NSLayoutConstraint *)countMarginTop{
    
    _countMarginTop = countMarginTop;
    
    if (Screen_H<600.0) {// 4.0屏幕
        
         countMarginTop.constant = -margin_1;
        
    }else{
        
        if (Screen_H<700.0) {// 4.7屏幕
            
            countMarginTop.constant = -margin_2;
            
        }else{// 5.5以上
            
            countMarginTop.constant = -margin_3/2;
            
        }
        
    }
}

-(void)setCountMarginTralling:(NSLayoutConstraint *)countMarginTralling{
   
    _countMarginTralling = countMarginTralling;
    
    
    if (Screen_H<600.0) {// 4.0屏幕
        
        countMarginTralling.constant = margin_1+3;
        
    }else{
        
        if (Screen_H<700.0) {// 4.7屏幕
            
            countMarginTralling.constant = margin_2;
            
        }else{// 5.5以上
            
            countMarginTralling.constant = margin_3/2;
            
        }
        
    }
}
@end
