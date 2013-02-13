//
//  CNMapView.m
//  Classical NYC
//
//  Created by Noah Blake on 2/11/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "CNMapViewController.h"
#import "CNVenueHandler.h"
#import "CNVenue.h"
#import "CNAnnotation.h"

@implementation CNMapViewController

static int _pinCount = 0;

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"Map";
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
    
    [self annotateMapView];
   
    [self.view addSubview: self.mapView];
}

- (void) viewDidAppear:(BOOL)animated
{
    if (_pinCount == 0)
    {
        DLog(@"Required refresh");
        [self annotateMapView];
    }
}


- (void) annotateMapView
{
    for (CNVenue *tmpVenue in VENUELIST)
    {
        CLLocationCoordinate2D tmpVenueCoordinate = {tmpVenue.latitude.doubleValue, tmpVenue.longitude.doubleValue};
        CNAnnotation *tmpPin = [[CNAnnotation alloc] initWithCoordinate: tmpVenueCoordinate
                                                               andTitle: tmpVenue.venueName
                                                            andSubtitle: tmpVenue.venueStreetAddress];
        [self.mapView addAnnotation: tmpPin];
        _pinCount++;
        [tmpPin release];
    }
}
#pragma mark MKMapView delegate methods

//gain access to customization of MKAnnotationView through this method
-(MKAnnotationView *)mapView:(MKMapView *) inMapView viewForAnnotation: (id <MKAnnotation>) inAnnotation
{
    //don't do anything if this is the user's current location
    if ([inAnnotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    static NSString *defaultPinID = @"default pin";
    MKPinAnnotationView *pinView = [[[MKPinAnnotationView alloc] initWithAnnotation: inAnnotation reuseIdentifier: defaultPinID] autorelease];
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
@end
