//
//  MapViewController.h
//  captain
//
//  Created by RockeyCai on 2016/12/21.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import "BaseViewController.h"
#import "AppInfo.h"

@interface MapViewController : BaseViewController

+ (MapViewController *)getInstance;

@property (nonatomic , strong) AppInfo *appInfo;

@end
