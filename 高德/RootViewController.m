//
//  RootViewController.m
//  高德
//
//  Created by gch on 16/10/26.
//  Copyright © 2016年 gch. All rights reserved.
//

#import "RootViewController.h"
#import "ViewController.h" // 关键字检索
#import "MapViewController.h" // 定位周边

@interface RootViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *dataArray;

@property (nonatomic, strong) AMapPOI     *poi;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.navigationController.navigationBar.translucent = NO;
    self.dataArray = @[@"关键字检索", @"定位周边"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row == 0) {
        ViewController *vc = [[ViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1) {
    
        MapViewController *vc = [[MapViewController alloc] init];
        // 将MapViewController的值传到这个界面, 就可以用了
        __weak __typeof(self) weakSelf = self;
        [vc setSuccessBlock:^(AMapPOI *obj){
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.poi = obj;
            if (obj) {
                if (obj.name.length > 0) {
                    NSString *str = [NSString stringWithFormat:@"%@·%@\n%@",self.poi.city,self.poi.name,self.poi.address];
                    NSLog(@"---------=%@", str);
                }else{
                    NSString *str  = [NSString stringWithFormat:@"%@",self.poi.city];
                    NSLog(@"---------=%@", str);

                }
            } else{
                NSString *str = @"所在位置";
                NSLog(@"---------=%@", str);

            }
        }];

        
        [self.navigationController pushViewController:vc animated:YES];
    }
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
