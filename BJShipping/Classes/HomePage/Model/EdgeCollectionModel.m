//
//  EdgeCollectionModel.m
//  BJShipping
//
//  Created by UEdge on 2017/10/17.
//  Copyright © 2017年 UEdge. All rights reserved.
//

#import "EdgeCollectionModel.h"

@implementation EdgeCollectionModel

-(instancetype)initID:(NSInteger)ID imageName:(NSString *)buttonImageName label:(NSString *)buttonLabel  userType:(UserType)userType{
    self = [super init];
    if (self) {
        _ID = ID;
        _buttonImageName = buttonImageName;
        _buttonLabel = buttonLabel;
        _userType = userType;
        
    }
    return self;
}



/**
 主页菜单
 
 一直显示：查找船舶，碍航信息，航运信息，北江动态，船闸信息,
 
 if(vf_user_type=="HuiYuan" || vf_user_type=="GHXTSYQY"){
 //会员  港航系统水运企业
 我的船舶,智能场景,调度信息,船员管理，安全检查
 }else if(vf_user_type=="001"|| vf_user_type=="GHGLBM"){
 //管理员  交通局用户
 区域监控,大数据分析
 }
 
 @return arr
 */
+(NSArray *)getHomeCollectionViewMenuArray:(UserType)userType
{
    NSMutableArray *functionMenuArray= [[NSMutableArray alloc] init];
    
        if (userType == HuiYuan || userType == GHXTSYQY) {//会员 或者 港航系统水运企业

            [functionMenuArray addObjectsFromArray:  [self loadMembers_Enterprise_DataWithType:userType]];
            
    
        }else if(userType == Admin || userType == GHGLBM){  //管理员 或者 交通局用户
            
            [functionMenuArray addObjectsFromArray:  [self load_Administrator_TrafficDataWithType:userType]];
            
        }else{//  游客
            
            [functionMenuArray addObjectsFromArray:  [self load_TouristsDataWithType:userType]];
            
        }
    return functionMenuArray;
}


/**
    获取游客数据
 */
+(NSArray *)load_TouristsDataWithType:(UserType)userType{
    
    NSMutableArray *functionMenuArray= [[NSMutableArray alloc] init];
    
    EdgeCollectionModel *menu_1 = [[EdgeCollectionModel alloc]initID:0 imageName:@"cbss" label:@"查找船舶" userType:userType];
    
    menu_1.url = [NSString stringWithFormat:@"%@/BjAppWeb/page/QueryFuzzy.html",IPHelper.getDataURL];
    
    [functionMenuArray addObject:menu_1];
    
    EdgeCollectionModel *menu_2 = [[EdgeCollectionModel alloc]initID:0 imageName:@"hahz" label:@"碍航信息" userType:userType];
    menu_2.url = [NSString stringWithFormat:@"%@/BjAppWeb/page/channelInfo.html",IPHelper.getDataURL];
    [functionMenuArray addObject:menu_2];
    
    EdgeCollectionModel *menu_3 = [[EdgeCollectionModel alloc]initID:0 imageName:@"hyxx" label:@"航运信息" userType:userType];
    menu_3.url = [NSString stringWithFormat:@"%@/BjAppWeb/page/transportInfo.html",IPHelper.getDataURL];
    [functionMenuArray addObject:menu_3];
    
    EdgeCollectionModel *menu_4 = [[EdgeCollectionModel alloc]initID:0 imageName:@"bjdt" label:@"北江动态" userType:userType];
    menu_4.url = [NSString stringWithFormat:@"%@/BjAppWeb/page/NewsLists.html",IPHelper.getDataURL];
    
    [functionMenuArray addObject:menu_4];
    
    EdgeCollectionModel *menu_5 = [[EdgeCollectionModel alloc]initID:0 imageName:@"cbgl" label:@"船闸信息" userType:userType];
    menu_5.url = [NSString stringWithFormat:@"%@",IPHelper.getDataURL];
    
    [functionMenuArray addObject:menu_5];
    
    return functionMenuArray;
}

/**
 获取会员-企业数据
 */
+(NSArray *)loadMembers_Enterprise_DataWithType:(UserType)userType{
    
         NSMutableArray *functionMenuArray= [[NSMutableArray alloc] init];
   
    //  先加游客数据
    [functionMenuArray addObjectsFromArray:[self load_TouristsDataWithType:userType]];
    
    EdgeCollectionModel *menu_6 = [[EdgeCollectionModel alloc]initID:0 imageName:@"wdcb" label:@"我的船舶" userType:userType];
    
        menu_6.url = [NSString stringWithFormat:@"%@/BjAppWeb/page/ShipInfo.html",IPHelper.getDataURL];
        [functionMenuArray addObject:menu_6];

        EdgeCollectionModel *menu_7 = [[EdgeCollectionModel alloc]initID:0 imageName:@"zncj" label:@"智能场景" userType:userType];
        menu_7.url = [NSString stringWithFormat:@"%@/BjAppWeb/page/intelligentScene.html",IPHelper.getDataURL];
    
        [functionMenuArray addObject:menu_7];
    
        EdgeCollectionModel *menu_8 = [[EdgeCollectionModel alloc]initID:0 imageName:@"cbdd" label:@"调度信息" userType:userType];
        menu_8.url = [NSString stringWithFormat:@"%@",IPHelper.getDataURL];
        [functionMenuArray addObject:menu_8];
    
        EdgeCollectionModel *menu_9 = [[EdgeCollectionModel alloc]initID:0 imageName:@"cygl" label:@"船员管理" userType:userType];
        menu_9.url = [NSString stringWithFormat:@"%@",IPHelper.getDataURL];
        [functionMenuArray addObject:menu_9];
    
        EdgeCollectionModel *menu_10 = [[EdgeCollectionModel alloc]initID:0 imageName:@"aqjc" label:@"安全检查" userType:userType];
        menu_10.url = [NSString stringWithFormat:@"%@",IPHelper.getDataURL];
        [functionMenuArray addObject:menu_10];
  
    return functionMenuArray;
    
}

/**
 获取管理员-交通局用户数据
 */
+(NSArray *)load_Administrator_TrafficDataWithType:(UserType)userType{
    
    NSMutableArray *functionMenuArray= [[NSMutableArray alloc] init];
    
    //  先加游客数据
    [functionMenuArray addObjectsFromArray:[self load_TouristsDataWithType:userType]];
    
    EdgeCollectionModel *menu_6 = [[EdgeCollectionModel alloc]initID:0 imageName:@"cbjk" label:@"区域监控" userType:userType];
        menu_6.url = [NSString stringWithFormat:@"%@/BjAppWeb/page/BJMapMain.html",IPHelper.getDataURL];
        [functionMenuArray addObject:menu_6];
    
        EdgeCollectionModel *menu_7 = [[EdgeCollectionModel alloc]initID:0 imageName:@"dsjfx" label:@"大数据分析" userType:userType];
        menu_7.url = [NSString stringWithFormat:@"%@",IPHelper.getDataURL];
    
        [functionMenuArray addObject:menu_7];

    return functionMenuArray;
}
    
@end
