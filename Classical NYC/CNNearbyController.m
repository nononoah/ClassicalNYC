//
//  CNNearbyController.m
//  Classical NYC
//
//  Created by Noah Blake on 2/13/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "CNNearbyController.h"
#import "CNVenueHandler.h"
#import "CNVenue.h"
#import "CNAnnotation.h"

@interface CNNearbyController ()

@end

@implementation CNNearbyController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"Nearby";
        self.annotationArray = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void) viewDidLoad
{
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    
    // {} shortcut for defining structs
    CLLocationCoordinate2D tmpCenter = {40.7142, -74.006}; //latitude, longitude
    MKCoordinateSpan tmpSpan = {.2, .2}; //degrees of lat and long span includes
    MKCoordinateRegion tmpRegion = {tmpCenter, tmpSpan}; //region sets default location and zoom for map when it opens
    self.mapView.region = tmpRegion;
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    

    [self.view addSubview: self.mapView];
    
    //change to picker view in a later iteration. For now, buttons
    int tmpArray[] = {1, 5, 10};
    for (int i = 0; i < 3; ++i)
    {
        UIButton *tmpButton = [UIButton buttonWithType: UIButtonTypeCustom];
        [tmpButton setFrame: CGRectMake(i * 104 + (4 * i), 0, 104, 30)];
        [tmpButton setTitle: [NSString stringWithFormat: @"%i miles", tmpArray[i]] forState: UIControlStateNormal];
        [tmpButton.titleLabel setTextColor: [UIColor blackColor]];
        [tmpButton setBackgroundColor: [UIColor grayColor]];
        [tmpButton addTarget: self action: @selector(proximitySearch:) forControlEvents: UIControlEventTouchUpInside];
        [self.view addSubview: tmpButton];
    }
}

- (void) proximitySearch: (UIButton *) sender
{
    //clear annotations and clear array
    if (self.annotationArray.count != 0)
    {
        [self.mapView removeAnnotations: self.annotationArray];
        [self.annotationArray removeAllObjects];
    }
    
    //determine the proximity range from the first two characters of the sender
    int tmpProximityRange = (int)[sender.currentTitle characterAtIndex: 0] + (int)[sender.currentTitle characterAtIndex: 1];
    DLog(@"Proximity range: %i", tmpProximityRange);
    CLLocation *tmpUserLocation = [[CLLocation alloc] initWithLatitude: self.mapView.userLocation.coordinate.latitude longitude: self.mapView.userLocation.coordinate.longitude];
    
    //test each venue for its proximity to current location
    for (CNVenue *tmpVenue in VENUELIST)
    {
        CLLocation *tmpVenueLocation = [[CLLocation alloc] initWithLatitude: tmpVenue.latitude.doubleValue longitude: tmpVenue.longitude.doubleValue];
        //add 85 to make the int to ASCII conversion
        float tmpDistanceFromCurrentLocation = ([tmpVenueLocation distanceFromLocation: tmpUserLocation] / 1609.34) + 80;
        
        //if user is close enough to a venue, drop the venue's pin
        if (tmpDistanceFromCurrentLocation <= tmpProximityRange)
        {
            CLLocationCoordinate2D tmpVenueCoordinate = {tmpVenue.latitude.doubleValue, tmpVenue.longitude.doubleValue};
            CNAnnotation *tmpPin = [[CNAnnotation alloc] initWithCoordinate: tmpVenueCoordinate
                                                                   andTitle: tmpVenue.venueName
                                                                andSubtitle: tmpVenue.venueStreetAddress];
            [self.annotationArray addObject: tmpPin];
            [tmpPin release];
        }
    }
    [self.mapView addAnnotations: self.annotationArray];
}

#pragma mark MKMapView delegate methods
//gain access to customization of MKAnnotationView through this method
-(MKAnnotationView *)mapView:(MKMapView *) inMapView viewForAnnotation: (id <MKAnnotation>) inAnnotation
{
    //don't do anything if this is the user's current location
    if ([inAnnotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    static NSString *defaultPinID = @"default pin";
    MKPinAnnotationView *pinView = [[MKPinAnnotationView alloc] initWithAnnotation: inAnnotation reuseIdentifier: defaultPinID];
    //pinView.draggable = YES;
    //pinView.image
    
    pinView.pinColor = MKPinAnnotationColorRed;
    pinView.canShowCallout = YES;
    pinView.animatesDrop = YES;
    
    return pinView;
}

//delegate learns a view has been selected
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    CLLocation *userLocation = [[CLLocation alloc] initWithLatitude: mapView.userLocation.coordinate.latitude longitude: mapView.userLocation.coordinate.longitude];
    CLLocation *pinLocation = [[CLLocation alloc] initWithLatitude: view.annotation.coordinate.latitude longitude: view.annotation.coordinate.longitude];
    DLog(@"Distance between pin and current location: %f", [pinLocation distanceFromLocation: userLocation] / 1609.34);
    DLog(@"Selected a view, height of view: %f, width of view: %f", view.frame.size.height, view.frame.size.width);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
