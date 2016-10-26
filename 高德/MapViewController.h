//
//  MapViewController.h
//  高德
//
//  Created by gch on 16/10/26.
//  Copyright © 2016年 gch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>


typedef void (^SelectLocationSuccessBlock)(AMapPOI *poi);
@interface MapViewController : UIViewController
@property (nonatomic,strong)   AMapPOI                      *oldPoi;
@property (nonatomic,copy  )   SelectLocationSuccessBlock   successBlock;

@end
