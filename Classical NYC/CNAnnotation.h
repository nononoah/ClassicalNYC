//
//  CNPinView.h
//  Classical NYC
//
//  Created by Noah Blake on 2/11/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CNAnnotation : NSObject <MKAnnotation>

- (id) initWithCoordinate: (CLLocationCoordinate2D) inCoordinate andTitle: (NSString *) inTitle andSubtitle: (NSString *) inSubtitle;
- (id) initWithCoordinate: (CLLocationCoordinate2D) inCoordinate andBoundingMapRect: (MKMapRect) inBoundingMapRect;

@property (nonatomic, assign) MKMapRect bounding;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;


@end
