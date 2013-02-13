//
//  CNNearbyController.h
//  Classical NYC
//
//  Created by Noah Blake on 2/13/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "CNMapViewController.h"

@interface CNNearbyController : UIViewController <MKMapViewDelegate>

@property (nonatomic, assign) MKMapView *mapView;
@property (nonatomic, assign) NSMutableArray *annotationArray;

@end
