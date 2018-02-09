//
//  NgBridgeInformationConver.h
//  captain
//
//  Created by RockeyCai on 2016/12/22.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import "JSONModel.h"
#import "NgBridgeInformation.h"

@protocol NgBridgeInformation;

@interface NgBridgeInformationConver : JSONModel

@property (nonatomic, strong) NSArray<NgBridgeInformation> *ngBridgeInformations;

@end
