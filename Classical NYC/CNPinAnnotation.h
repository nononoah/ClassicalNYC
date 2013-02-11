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

@interface CNPinAnnotation : NSObject <MKAnnotation>

- (id) initWithCoordinate: (CLLocationCoordinate2D) inCoordinates andTitle: (NSString *) inTitle;

@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic, copy) NSString *title;

@end
