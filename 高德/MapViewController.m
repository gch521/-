//
//  MapViewController.m
//  高德
//
//  Created by gch on 16/10/26.
//  Copyright © 2016年 gch. All rights reserved.
//

#import "MapViewController.h"



#define SelectLocation_Not_Show @"不显示位置"
#define ApiKey @"2e2f16167f16481c3b811020ee68f4f9"; // 高德的apikey

@interface MapViewController ()<AMapSearchDelegate,MAMapViewDelegate,CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) AMapSearchAPI  *search;

@property (nonatomic,strong) NSMutableArray *addressArray;

@property (nonatomic,strong) UITableView    *tableView;
@property (nonatomic, strong)CLLocation *currentLocation;
@property (nonatomic, retain)MAMapView *mapView;


@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    AMapPOI *first  = [[AMapPOI alloc] init];
    first.name      = SelectLocation_Not_Show;
    [self.addressArray addObject:first];
    
    [AMapServices sharedServices].apiKey =ApiKey;
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 2)];
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    self.mapView.mapType = MAMapTypeStandard;
    self.mapView.showsUserLocation = YES;
    [self.mapView setUserTrackingMode:(MAUserTrackingModeFollow) animated:YES];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height / 2, self.view.frame.size.width, self.view.frame.size.height / 2) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];


}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    self.currentLocation = [userLocation.location copy];
    NSLog(@"------%f----%f", self.currentLocation.coordinate.latitude,self.currentLocation.coordinate.longitude);
    [self sendRequest];
}

- (void)sendRequest{
    
    
    if (_currentLocation) {
        
        AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
        
        NSLog(@"------%f----=%f", self.currentLocation.coordinate.latitude,self.currentLocation.coordinate.longitude);
        request.location = [AMapGeoPoint locationWithLatitude:self.currentLocation.coordinate.latitude longitude:-self.currentLocation.coordinate.longitude];
        request.keywords                    = @"";
        request.sortrule                    = 0;
        request.requireExtension            = YES;
//        request.radius                      = 1000;
        
        request.types                       = @"050000|060000|070000|080000|090000|100000|110000|120000|130000|140000|150000|160000|170000";  // @"风景名胜|商务住宅|政府机构及社会团体|交通设施服务|公司企业|道路附属设施|地名地址信息"
        
        [self.search AMapPOIAroundSearch:request];
        
    }
}
#pragma mark - AMapSearchDelegate
/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    
    if (response.pois.count == 0){
        return;
    }
    
    [self.addressArray addObjectsFromArray:response.pois];
    
    [self.tableView reloadData];
}

#pragma mark TableView delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"SelectLocationCell";
    UITableViewCell *cell    = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
    }
    
    AMapPOI *info               = self.addressArray[indexPath.row];
    cell.textLabel.text         =  info.name;
    cell.detailTextLabel.text   = [NSString stringWithFormat:@"%@%@%@", info.city, info.district, info.address] ;
    
    cell.accessoryType  = UITableViewCellAccessoryNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AMapPOI *info = self.addressArray[indexPath.row];
    if (self.successBlock) {
        self.successBlock([info.name isEqualToString:SelectLocation_Not_Show] ? nil : info);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setSuccessBlock:(SelectLocationSuccessBlock)successBlock{
    _successBlock = successBlock;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addressArray.count;
}

- (NSMutableArray *)addressArray{
    if (!_addressArray) {
        _addressArray = [[NSMutableArray alloc] init];
    }
    return _addressArray;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
