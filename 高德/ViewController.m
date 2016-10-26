//
//  ViewController.m
//  高德
//
//  Created by gch on 16/10/26.
//  Copyright © 2016年 gch. All rights reserved.
//

#import "ViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

#define ApiKey @"2e2f16167f16481c3b811020ee68f4f9"; // 高德的apikey
@interface ViewController ()<AMapSearchDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)AMapSearchAPI *search;
@property (nonatomic, strong)NSMutableArray *dataArray;


@property (nonatomic, strong)UITextField *keywordsTextField;
@property (nonatomic, strong)UITextField *cityTextField;
@property (nonatomic, strong)UITextField *typesTextField;
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [AMapServices sharedServices].apiKey =ApiKey;
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    self.dataArray = [NSMutableArray array];
    
    self.keywordsTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 20, (self.view.frame.size.width - 20) / 3, 50)];
    self.keywordsTextField.placeholder = @"查询关键字";
    [self.view addSubview:self.keywordsTextField];
    self.cityTextField = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 20)  / 3 + 10, 20, (self.view.frame.size.width - 20) / 3, 50)];
    self.cityTextField.placeholder = @"查询城市";
    [self.view addSubview:self.cityTextField];
    self.typesTextField = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 20) * 2 / 3 + 20, 20, (self.view.frame.size.width - 20) / 3, 50)];
    self.typesTextField.placeholder = @"查询关键字";
    [self.view addSubview:self.typesTextField];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(0, 80, self.view.frame.size.width, 50);
    [button setTitle:@"搜索" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(actionButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, self.view.frame.size.height - 150) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    

    
}
- (void)actionButton:(UIButton *)button
{
    [self.view endEditing:YES];
    [self sendRequest];

}

- (void)sendRequest
{
    
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    
    request.keywords            = self.keywordsTextField.text; // 查询关键字(多选用"|"分割)
    request.city                = self.cityTextField.text; // 查询城市
    request.types               = self.typesTextField.text; // 类型
    request.requireExtension    = YES;
    
    /*  搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI。*/
    request.cityLimit           = YES;
    request.requireSubPOIs      = YES;
    [self.search AMapPOIKeywordsSearch:request];
}

/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        return;
    }
    
    //解析response获取POI信息，具体解析见 Demo
    [self.dataArray addObjectsFromArray:response.pois];
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"cell"];
    }
    
    AMapPOI *info               = self.dataArray[indexPath.row];
    cell.textLabel.text         =  info.name;
    cell.detailTextLabel.text   = [NSString stringWithFormat:@"%@%@%@", info.city, info.district, info.address] ;

    cell.accessoryType  = UITableViewCellAccessoryNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 60;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
