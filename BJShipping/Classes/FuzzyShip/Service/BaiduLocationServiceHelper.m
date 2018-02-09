//
//  BaiduLocationServiceHelper.m
//  captain
//
//  Created by RockeyCai on 2016/12/27.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import "BaiduLocationServiceHelper.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import "JZLocationConverter.h"
#import "FuzzyShip.h"
//#import "NSDate+Formatter.h"
#import "UploadLocationApi.h"


static BaiduLocationServiceHelper *locationService = nil;


@interface BaiduLocationServiceHelper()<BMKLocationServiceDelegate>
{
    BMKLocationService* _locService;
}
@end


@implementation BaiduLocationServiceHelper


/**
 *  获取单例对象
 *  @return <#return value description#>
 */
+ (BaiduLocationServiceHelper *)getSingleton
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        locationService = [[BaiduLocationServiceHelper alloc] init];
    });
    
    return locationService;
}

-(void)baiduLocationInit{
    
    _locService = nil;
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
}


/**
 停止定位服务
 */
-(void)stopLocationService{

    if (_locService) {
        _locService.delegate = nil;
        [_locService stopUserLocationService];
        _locService = nil;
    }
}



/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    
    //上传位置数据
    [self postLocation:userLocation];
    //停止定位服务
    [self stopLocationService];
    
}


-(void)postLocation:(BMKUserLocation *)userLocation{
    
    @synchronized(self)
    {
        /**
         RequestParams params = new RequestParams();
         params.addBodyParameter("testHelperState" , "FALSE");
         params.addBodyParameter("shipId" , fuzzyShip.getShipId());
         params.addBodyParameter("userId" , AppConfigHelper.getUDID(mContext));
         params.addBodyParameter("lat" , String.format("%.6f", mPoint.getLat()));//纬度
         params.addBodyParameter("lng" , String.format("%.6f", mPoint.getLng()));//经度
         params.addBodyParameter("cog" , location.getDirection() + "");//方向
         params.addBodyParameter("sog" , location.getSpeed() + "");//速度
         params.addBodyParameter("gpsTime" , TimeHelper.date2String(new Date() , TimeHelper.YYYY_MM_DD_HH_MM_SS));
         **/
        
        if (userLocation.location) {
            
            CLLocationCoordinate2D baidu = userLocation.location.coordinate;//百度坐标

            CLLocationCoordinate2D gps = [JZLocationConverter bd09ToGcj02:baidu];

            NSString *currentTime =  [EdgeTimeHelper dealTimeDateToString:[NSDate date] format:@"yyyy-MM-dd HH:mm:ss"];
           
            NSString *latitude = [NSString stringWithFormat:@"%.6f",gps.latitude];
            NSString *longitude = [NSString stringWithFormat:@"%.6f",gps.longitude];
            
            UploadLocationApi *api = [[UploadLocationApi alloc] initWithtestHelperState:@"false" shipId:[FuzzyShip getShipInfo].ship_id userId:[OpenUDID value] lat:latitude lng:longitude gpsTime:currentTime];
            
            [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                
                NSString *json = request.responseString;
                if (json) {
                    
                    NSDictionary *dic = [EdgeJsonHelper dictionaryWithJsonString:json];
                  
                    BOOL success = [dic objectForKey:@"success"];
                    
                    if (success) {
                        
                        BBUserDefault.gpsNum = ++BBUserDefault.gpsNum;
                        
                         EdgeLog(@"BBUserDefault.gpsNum  =%d",BBUserDefault.gpsNum);
                       
                        //发送广播，触发更新
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"onlyReloadTable4onlineOrGps" object:nil];
                    }
                }
                
            } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                NSLog(@"上传定位失败");
            }];
        }
        
    }

}




/**
 上传位置信息
 */
-(void)sendGSPInfo{
    
    @synchronized(self)
    {
        [self baiduLocationInit];
    }
}

@end
