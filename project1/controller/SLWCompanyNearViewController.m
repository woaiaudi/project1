//
//  SLWCompanyNearViewController.m
//  project1
//
//  Created by zyue on 14/12/30.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "SLWCompanyNearViewController.h"
#import "CloudPOIAnnotation.h"
#import "SLWCompanyDetail2ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface SLWCompanyNearViewController ()
@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) AMapCloudAPI *cloudAPI;

@end

@implementation SLWCompanyNearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left_arrow.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(returnAction)];
    if (self.mapView == nil)
    {
        self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    }
    self.mapView.frame = self.view.bounds;
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    self.mapView.visibleMapRect = MAMapRectMake(220880104, 101476980, 272496, 466656);
    
    
    self.cloudAPI = [[AMapCloudAPI alloc] initWithCloudKey:(NSString *)APIKey delegate:nil];
    self.cloudAPI.delegate = self;
    
    if ([tableID length] == 0)
    {
        NSLog(@"%@",[NSString stringWithFormat:@"\nSDKVersion:%@\nFILE:%s\nLINE:%d\nMETHOD:%s", [MAMapServices sharedServices].SDKVersion, __FILE__, __LINE__, __func__]);
        NSLog(@"请首先配置APIKey.h中的tableID, 查询tableID参考见 http://yuntu.amap.com");
    }
    //用户当前定位的位置
    self.mapView.showsUserLocation = YES;    //YES 为打开定位，NO为关闭定位
    [_mapView setUserTrackingMode: MAUserTrackingModeNone animated:YES]; //地图不跟着位置移动

    
    
    //[self cloudPlaceAroundSearchByLat:32.039177 andLong:118.792892];
    
}
#pragma mark -locationManager 系统定位回调
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    //取出当前位置的坐标
    if (updatingLocation) {
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        [self cloudPlaceAroundSearchByLat:userLocation.coordinate.latitude andLong:userLocation.coordinate.longitude];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 返回事件
- (void)returnAction
{
    [self.navigationController popViewControllerAnimated:YES];
    self.mapView.showsUserLocation = NO;
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView removeOverlays:self.mapView.overlays];
    self.mapView.delegate = nil;
    self.cloudAPI.delegate = nil;
    
}
#pragma mark - 执行搜索:(CLLocationCoordinate2D)userLocalPoint
- (void)cloudPlaceAroundSearchByLat:(double)latitude andLong:(double)longitude
{
    AMapCloudPlaceAroundSearchRequest *placeAround = [[AMapCloudPlaceAroundSearchRequest alloc] init];
    [placeAround setTableID:(NSString *)tableID];
    
    double radius = 4000;
    //搜索中心
    AMapCloudPoint *centerPoint = [AMapCloudPoint locationWithLatitude:latitude longitude:longitude];
    
    //设置中心点和半径
    [placeAround setRadius:radius];
    [placeAround setCenter:centerPoint];
    
    //设置关键字
    //[placeAround setKeywords:@"公园"];
    
    //过滤条件数组filters的含义等同于SQL语句:WHERE _address = "文津街1" AND _id BETWEEN 20 AND 40
    //    NSArray *filters = [[NSArray alloc] initWithObjects:@"_id:[20,70]", @"_address:文津街", nil];
    //    [placeAround setFilter:filters];
    
    //设置排序方式
    //    [placeAround setSortFields:@"_id"];
    //    [placeAround setSortType:AMapCloudSortType_DESC];
    
    //设置每页记录数和当前页数
    [placeAround setOffset:80];
    //    [placeAround setPage:2];
    
    [self.cloudAPI AMapCloudPlaceAroundSearch:placeAround];
}

#pragma mark - 云图搜索成功回调
- (void)onCloudPlaceAroundSearchDone:(AMapCloudPlaceAroundSearchRequest *)request response:(AMapCloudSearchResponse *)response
{
    NSLog(@"status:%ld ,info:%@ ,count:%ld",(long)response.status, response.info, (long)response.count);
    
    [self addAnnotationsWithPOIs:[response POIs]];
}
#pragma mark - 云图搜索失败回调
- (void)cloudRequest:(id)cloudSearchRequest error:(NSError *)error
{
    NSLog(@"CloudRequestError:{Code: %ld; Description: %@}", (long)error.code, error.localizedDescription);
}
#pragma mark - 搜索到的点添加到地图上
- (void)addAnnotationsWithPOIs:(NSArray *)pois
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    for (AMapCloudPOI *aPOI in pois)
    {
        NSLog(@"%@",aPOI);
        
        CloudPOIAnnotation *ann = [[CloudPOIAnnotation alloc] initWithCloudPOI:aPOI];
        [self.mapView addAnnotation:ann];
    }
    
    [self.mapView showAnnotations:self.mapView.annotations animated:YES];
}

#pragma mark - MAMapViewDelegate--显示poi点
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[CloudPOIAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"PlaceAroundSearchIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        
        annotationView.canShowCallout   = YES;
        annotationView.animatesDrop     = NO;
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    if ([view.annotation isKindOfClass:[CloudPOIAnnotation class]])
    {
        [self gotoDetailForCloudPOI:[(CloudPOIAnnotation *)view.annotation cloudPOI]];
    }
}

- (void)gotoDetailForCloudPOI:(AMapCloudPOI *)cloudPOI
{
    CompanyBean *tmpBean = [[CompanyBean alloc]init];
    tmpBean.id =[cloudPOI.customFields valueForKey:@"companyid"];
    tmpBean.group_id =[cloudPOI.customFields valueForKey:@"group_id"];
    tmpBean.company =cloudPOI.name;
    tmpBean.linker =[cloudPOI.customFields valueForKey:@"linker"];
    tmpBean.linktel =[cloudPOI.customFields valueForKey:@"linkertel"];
    tmpBean.chuanzhen =[cloudPOI.customFields valueForKey:@"chuanzhen"];
    tmpBean.compemail =[cloudPOI.customFields valueForKey:@"compemail"];
    tmpBean.zip =[cloudPOI.customFields valueForKey:@"zip"];
    tmpBean.webaddr =[cloudPOI.customFields valueForKey:@"webaddr"];
    tmpBean.compaddr =cloudPOI.address;
    tmpBean.logo =[cloudPOI.customFields valueForKey:@"logo"];
    
    SLWCompanyDetail2ViewController * detailPage = [[SLWCompanyDetail2ViewController alloc]init];
    [detailPage setTitle:tmpBean.company];
    [detailPage setCompanyBean:tmpBean];
    [self.navigationController pushViewController:detailPage animated:YES];
    
    
}
@end
