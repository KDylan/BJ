//
//  MapViewController.m
//  captain
//
//  Created by RockeyCai on 2016/12/21.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import "MapViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
//#import "ImportHelper.h"
#import "NgBridgeInformationApi.h"
#import "NgBridgeInformationConver.h"
#import "NgBridgeInformationDao.h"
#import "SettingTableViewController.h"
#import "FuzzyShip.h"
#import "AppDelegate.h"
#import "AppInfoService.h"
#import "AppInfo.h"
//#import "YYModel.h"
#import "AppInfoConver.h"

static MapViewController *instance = nil;

@interface MapViewController ()<BMKMapViewDelegate , BMKLocationServiceDelegate>
{
   BMKLocationService* _locService;
}

@property (weak, nonatomic) IBOutlet BMKMapView *mapView;

@property (weak, nonatomic) IBOutlet UIView *ngBridgeInformationView;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *info;

@property (weak, nonatomic) IBOutlet UIButton *mapTypeBut;

@property (weak, nonatomic) IBOutlet UILabel *shipName;


//桥梁覆盖物
//@property (strong , nonatomic) NSMutableArray *shipOverlayArray;

//桥梁列表
@property (strong , nonatomic) NSMutableArray *ngBridgeInformationArray;

//距离最近的桥梁
@property (retain , nonatomic) NgBridgeInformation *ngBridgeInformation;

//桥梁覆盖物
@property (retain , nonatomic) BMKPointAnnotation *pointAnnotation;



@end

@implementation MapViewController


+ (MapViewController *)getInstance
{
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    instance = self;
    [self dataInit];
    [self viewInit];
    
    
}

-(void)dataInit{
    
    //注册登录状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setShipInfo:)
                                                 name:KNOTIFICATION_LOGINCHANGE
                                               object:nil];
    
    self.ngBridgeInformationArray = [NSMutableArray new];
    
    //设置按钮圆角样式
    self.mapTypeBut.layer.cornerRadius = 5;
    [self.mapTypeBut.layer setMasksToBounds:YES];
    
    
//    //获取网络桥梁数据
//    [self loadWebShipData];
//    //获取本地桥梁数据
//    [self loadLocalShipData];
    
}


-(void)viewInit{

    // Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self setShipInfo:nil];
    
    self.ngBridgeInformationView.hidden = YES;
    
    _locService = [[BMKLocationService alloc]init];
    //设置地图缩放级别
    [_mapView setZoomLevel:18];
}

//开启定位，进入跟随模式
-(IBAction)startLocation
{
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    _mapView.showsUserLocation = YES;//显示定位图层
    //进入跟随模式
    [self startFollowing:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    
    
    //umeng跟踪page 以本项目的VC页面才进入友盟统计
//    [MPUmengHelper beginLogPageView:[self class]];
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    
    //umeng跟踪page 以开头本项目的VC页面才进入友盟统计
//    [MPUmengHelper endLogPageView:[self class]];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //开启定位，进入跟随模式
    [self startLocation];
    
    //检查更新
//    [self checkVersion];
}


- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *在地图View将要启动定位时，会调用此函数
 
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
   
    [_mapView updateLocationData:userLocation];
    
    //  添加桥梁标记
//    [self setPoint:userLocation];
    
}


// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = NO;// 设置该标注点动画显示
        [newAnnotationView setImage:[UIImage imageNamed:@"round_red"]];
        return newAnnotationView;
    }
    return nil;
}


- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay{
    if ([overlay isKindOfClass:[BMKGroundOverlay class]]){
        BMKGroundOverlayView* groundView = [[BMKGroundOverlayView alloc] initWithOverlay:overlay];
        return groundView;
    }
    return nil;
}


/**
 设置桥梁信息
 */
-(void)setNgBridgeInformationView{
    
    if (self.ngBridgeInformation) {
        self.name.text = self.ngBridgeInformation.NgBridgeName;
        self.info.text = self.ngBridgeInformation.getNgBridgeInfo;
        if (self.ngBridgeInformationView.hidden) {
            self.ngBridgeInformationView.hidden = NO;
        }
    }else{
        if (!self.ngBridgeInformationView.hidden) {
            self.ngBridgeInformationView.hidden = YES;
        }
    }
}


/**
 定位模式

 @param sender sender
 */
- (IBAction)mapTypeAction:(id)sender {
    
    switch (_mapView.userTrackingMode) {
        case BMKUserTrackingModeFollowWithHeading://罗盘态
            [self.mapTypeBut setTitle:@"跟随" forState:UIControlStateNormal];
            //却换为跟随状态
            [self startFollowing:sender];
            break;
        case BMKUserTrackingModeHeading://跟随态
            [self.mapTypeBut setTitle:@"罗盘" forState:UIControlStateNormal];
            //却换为罗盘状态
            [self startFollowHeading:sender];
            break;
        case BMKUserTrackingModeFollow://跟随态
            [self.mapTypeBut setTitle:@"罗盘" forState:UIControlStateNormal];
            //却换为罗盘状态
            [self startFollowHeading:sender];
            break;
        default:
            break;
    }
    
}


//罗盘态
-(IBAction)startFollowHeading:(id)sender
{
    EdgeLog(@"进入罗盘态");
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollowWithHeading;
    _mapView.showsUserLocation = YES;
}

//跟随态
-(IBAction)startFollowing:(id)sender
{
    EdgeLog(@"进入跟随态");
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
}


-(void)setShipInfo:(id)sender{
    
    FuzzyShip *ship = [FuzzyShip getShipInfo];
    if (ship) {
        self.shipName.text = ship.name;
    }else{
        self.shipName.text = nil;
    }
}

/**
 *在地图View停止定位后，会调用此函数
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}



/**
 远程获取船只数据
 */
-(void)loadWebShipData{
    
    __weak typeof(self) weakSelf = self;
    
    //获取船只信息
    NgBridgeInformationApi *api = [[NgBridgeInformationApi alloc] init];
    
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSString *json = request.responseString;
        if (json && ![json isEqualToString:@"[]"]) {
            
            //保存数据
            
            [AsyncHelper inBackgroundVoid:^{
                NgBridgeInformationConver *conver = [[NgBridgeInformationConver alloc] initWithString:[NSString stringWithFormat:@"{\"ngBridgeInformations\":%@}" , json] error:nil];
                
                if (conver.ngBridgeInformations) {
                    
                    [NgBridgeInformationDao saveArray:conver.ngBridgeInformations];
                    
                    [weakSelf.ngBridgeInformationArray addObjectsFromArray:conver.ngBridgeInformations];
                }
            }];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

/**
 获取本地桥梁数据
 */
-(void)loadLocalShipData{
    
    NSArray *temp = [NgBridgeInformationDao getNgBridgeInformationArray];
    if (temp) {
        [self.ngBridgeInformationArray addObjectsFromArray:temp];
    }
    
}


/**
 * 添加桥梁图层标记
 */
- (void)setPoint:(BMKUserLocation *)userLocation {
    
    if (self.ngBridgeInformationArray && userLocation.location) {
        
        if (userLocation.location) {
            
            __weak typeof(self) weakself = self;
            
            [AsyncHelper inBackground:^{
                
                //最小距离的点
                int minDistance = 0;
                //下标
                NSInteger minDistanceIndex = -1;
                
                //船只位置
                BMKMapPoint tagShipMapPoint = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude));
                
                for (NSInteger index = 0 ; index < self.ngBridgeInformationArray.count ; index++) {
                    
                    NgBridgeInformation *ship = [self.ngBridgeInformationArray objectAtIndex:index];
                    
                    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(ship.Lat, ship.Lng);//原始坐标
                    NSDictionary* testdic = BMKConvertBaiduCoorFrom(coor,BMK_COORDTYPE_COMMON);
                    //解密加密后的坐标字典
                    CLLocationCoordinate2D baiduCoor = BMKCoorDictionaryDecode(testdic);//转换后的百度坐标
                    
                    //验证是否在一公里范围内
                    BOOL ptInCircle = BMKCircleContainsCoordinate(baiduCoor, userLocation.location.coordinate , 1000 * 1);
                    if (ptInCircle) {
                        
                        BMKMapPoint temp = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(baiduCoor.latitude, baiduCoor.longitude));
                        
                        //计算距离 单位m
                        int distance = BMKMetersBetweenMapPoints(tagShipMapPoint , temp);
                        //                        NSLog(@"index:%ld distance:%d name:%@" ,index, distance , ship.NgBridgeName);
                        if (minDistanceIndex == -1) {
                            minDistanceIndex = index;
                            minDistance = distance;
                        }
                        
                        //获取最小的桥梁
                        if (distance <= minDistance) {
                            minDistance = distance;
                            minDistanceIndex = index;
                        }
                        
                    }
                    
                }
                
                if (minDistanceIndex > -1) {
                    
                    //设置最近的桥梁
                    weakself.ngBridgeInformation = [self.ngBridgeInformationArray objectAtIndex:minDistanceIndex];
                    
                    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(weakself.ngBridgeInformation.Lat, weakself.ngBridgeInformation.Lng);//原始坐标
                    NSDictionary* testdic = BMKConvertBaiduCoorFrom(coor,BMK_COORDTYPE_COMMON);
                    //解密加密后的坐标字典
                    CLLocationCoordinate2D baiduCoor = BMKCoorDictionaryDecode(testdic);//转换后的百度坐标
                    
                    //设置最近的桥梁覆盖物
                    weakself.pointAnnotation = [[BMKPointAnnotation alloc]init];
                    weakself.pointAnnotation.coordinate = baiduCoor;
                    weakself.pointAnnotation.title = weakself.ngBridgeInformation.NgBridgeName;
                    weakself.pointAnnotation.subtitle = weakself.ngBridgeInformation.BackUp1;
                }else{
                    
                    weakself.ngBridgeInformation = nil;
                    weakself.pointAnnotation = nil;
                }
                
            } onMainUI:^(id obj) {
                //移除原有的桥梁标注
                [weakself.mapView removeOverlays:weakself.mapView.annotations];
                
                //添加新的桥梁标注
                if (weakself.ngBridgeInformation) {
                    [weakself.mapView addAnnotation:weakself.pointAnnotation];
                }
                //
                [weakself setNgBridgeInformationView];
            }];
            
        }
    }
}



///**
// 检查更新
// */
//-(void)checkVersion{
//    
//    AppInfoService *app = [[AppInfoService alloc] init];
//    [app startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        
//        if (request.responseString) {
//            
//            AppInfoConver *dic = [[AppInfoConver alloc] initWithString:request.responseString error:nil];
//            
//            if (dic.iosCaptain) {
//                
//                self.appInfo = dic.iosCaptain;
//                
//                NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//                // app build版本
//                NSString *appBuild = [infoDictionary objectForKey:@"CFBundleVersion"];
//                
//                if (self.appInfo.Version && [self.appInfo.Version intValue] > appBuild.doubleValue) {
//                    
//                    NSString *time = @"";
//                    
//                    if (self.appInfo.OperateTime) {
//                        
//                        time = self.appInfo.OperateTime;
//                        
//                    }
//                    
//                    NSString *info = [[NSString alloc] initWithFormat:@"%@\n版本更新说明:\n%@\n时间:%@" ,
//                                      self.appInfo.BackUp1 ,
//                                      self.appInfo.ChangeLog ,
//                                      time];
//                    
//                    
//                    [[AlertViewHelper getInstance] show:@"版本更新" msg:info rightBlock:^{
//                        
//                        if (self.appInfo.DownloadUrl) {
//                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.appInfo.DownloadUrl]];
//                        }
//                        
//                    }];
//                    
//                }
//            }
//        }
//        
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        NSLog(@"----");
//    }];
//}
//


@end
