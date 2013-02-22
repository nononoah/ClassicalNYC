//
//  CNGoogleMapViewController.m
//  Classical NYC
//
//  Created by Noah Blake on 2/12/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "CNGoogleMapViewController.h"


@interface CNGoogleMapViewController ()
{
    GMSMapView *_mapView;
}
@end

@implementation CNGoogleMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: 40.7142 
                                                            longitude: -74.006
                                                                 zoom: 10];
    _mapView = [GMSMapView mapWithFrame:CGRectZero camera: camera];
    _mapView.myLocationEnabled = YES;
    self.view = _mapView;
    
    GMSMarkerOptions *options = [[GMSMarkerOptions alloc] init];
    options.position = CLLocationCoordinate2DMake(40.7142, -74.006);
    options.title = @"New York";
    options.snippet = @"New York";
    [_mapView addMarkerWithOptions: options];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
